const { Data, User } = require("./postModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const getAllData = async (req, res) => {
  try {
    if (req.query.limit < 15) {
      const data = await Data.find()
        .sort({ $natural: -1 })
        .limit(req.query.limit)
        .skip(req.query.skip);
      res.json(data);
    } else {
      const data = await Data.find()
        .sort({ $natural: -1 })
        .limit(15)
        .skip(req.query.skip);
      res.json(data);
    }
  } catch (err) {
    res.status(400).json("Error: " + err.message);
  }
};

const getPost = async (req, res) => {
  try {
    const postSlug = req.params.slug;
    const post = await Data.findOne({ imageSlug: postSlug });

    if (!post) {
      return res.status(404).send("Error: Post not found");
    }

    res.json(post);
  } catch (err) {
    res.status(400).json("Error: " + err.message);
  }
};

const registerUser = async (req, res) => {
  try {
    const { userName, userPassword, userFavorites } = req.body;
    const hashedPassword = await bcrypt.hash(userPassword, 10);
    const userToken = jwt.sign({ userName }, "secretKey", { expiresIn: "1h" });

    const newUser = new User({
      userName,
      userPassword: hashedPassword,
      userToken,
      userFavorites,
    });
    await newUser.save();
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const loginUser = async (req, res) => {
  try {
    const { userName, userPassword } = req.body;
    const user = await User.findOne({ userName });
    if (!user) return res.status(404).json({ message: "User not found" });

    const isMatch = await bcrypt.compare(userPassword, user.userPassword);
    if (!isMatch)
      return res.status(401).json({ message: "Invalid credentials" });

    const userToken = jwt.sign({ userName }, "secretKey", { expiresIn: "1h" });
    user.userToken = userToken;
    await user.save();

    res.json({ message: "Login successful", userToken });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const updateFavorites = async (req, res) => {
  try {
    const { userToken, photoId } = req.body;

    const user = await User.findOne({ userToken });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const index = user.userFavorites.indexOf(photoId);
    if (index !== -1) {
      user.userFavorites.splice(index, 1);
      await user.save();
      return res.json({ message: "Removed from favorites", isFavorite: false });
    } else {
      user.userFavorites.push(photoId);
      await user.save();
      return res.json({ message: "Added to favorites", isFavorite: true });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getFavorites = async (req, res) => {
  try {
    const { userToken } = req.body;

    if (!userToken) {
      return res.status(400).json({ message: "User token is required" });
    }

    const user = await User.findOne({ userToken });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.json({ favorites: user.userFavorites });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = router;

module.exports = {
  getAllData,
  getPost,
  registerUser,
  loginUser,
  updateFavorites,
  getFavorites,
};
