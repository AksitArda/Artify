const Data = require("./postModel");

const addData = async (req, res) => {
  try {
    const newData = new Data({
      title: req.body.title,
      content: req.body.content,
      tags: req.body.tags,
      public: req.body.public,
    });

    const savedData = await newData.save();
    res.json(savedData);
  } catch (err) {
    res.status(400).json("Error: " + err.message);
  }
};

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
    const postId = req.params.id;
    const post = await Data.findById(postId);

    if (!post) {
      return res.status(404).send("Error: Post not found");
    }

    res.json(post);
  } catch (err) {
    res.status(400).json("Error: " + err.message);
  }
};

module.exports = {
  addData,
  getAllData,
  getPost,
};
