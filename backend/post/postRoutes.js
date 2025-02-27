const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.get("/images", dataController.getAllData);
router.get("/image/:slug", dataController.getPost);

router.post("/register", dataController.registerUser);
router.post("/login", dataController.loginUser);
router.post("/favorites/toggle", dataController.updateFavorites);
router.post("/favorites", dataController.getFavorites);

module.exports = router;
