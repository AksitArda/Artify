const Data = require("./postModel");

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

module.exports = {
  getAllData,
  getPost,
};
