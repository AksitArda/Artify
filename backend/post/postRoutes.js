const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.get("/images", dataController.getAllData);
router.get("/image/:slug", dataController.getPost);

router.post("/register", dataController.registerUser);
router.post("/login", dataController.loginUser);
router.get("/user/:userName", dataController.getUser);
router.put("/user/:userName/favorites", dataController.updateFavorites);

module.exports = router;
