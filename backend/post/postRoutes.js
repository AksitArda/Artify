const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.get("/images", dataController.getAllData);
router.get("/image/:id", dataController.getPost);

module.exports = router;
