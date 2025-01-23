const express = require("express");
const router = express.Router();

const multer = require("multer");
const Data = require("./post/postModel");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads");
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, file.fieldname + "-" + uniqueSuffix + ".jpg");
  },
});

const upload = multer({ storage: storage });

router.post("/uploadImage", upload.single("file"), async (req, res) => {
  try {
    const newData = new Data({
      imageTitle: req.body.imageTitle,
      imageDesc: req.body.imageDesc,
      imageSlug: req.file.filename,
      userName: req.body.userName,
    });

    const savedData = await newData.save();

    res.json(savedData);
  } catch (error) {
    console.log(error);
    res.status(400).send(error);
  }
});

module.exports = router;
