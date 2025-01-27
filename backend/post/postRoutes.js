const express = require("express");
const router = express.Router();
const dataController = require("./postController");

router.get("/images", dataController.getAllData);
router.get("/image/:slug", dataController.getPost);

router.post("/register", dataController.registerUser);
router.post("/login", dataController.loginUser);
router.put("/favorites/toggle", dataController.updateFavorites);

module.exports = router;
