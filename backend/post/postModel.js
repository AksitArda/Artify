const mongoose = require("mongoose");

const PostSchema = new mongoose.Schema({
  imageTitle: { type: String, required: true },
  imageSlug: { type: String, required: true },
  imageDesc: { type: String, require: true },
  userName: { type: String, require: true },
});

const Data = mongoose.model("photos", PostSchema);

const UserSchema = new mongoose.Schema({
  userName: { type: String, required: true },
  userPassword: { type: String, required: true },
  userToken: { type: String, require: true },
  userFavorites: { type: [String], require: true },
});

const User = mongoose.model("users", UserSchema);

module.exports = { Data, User };
