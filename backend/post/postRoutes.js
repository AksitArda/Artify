const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.get("/images", dataController.getAllData);
router.get("/image/:slug", dataController.getPost);

module.exports = router;
