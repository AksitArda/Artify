const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.post("/add", dataController.addData);
router.get("/posts", dataController.getAllData);
router.get("/post/:id", dataController.getPost);

module.exports = router;
