const mongoose = require("mongoose");

const PostSchema = new mongoose.Schema({
  imageTitle: { type: String, required: true },
  imageSlug: { type: String, required: true },
  imageDesc: { type: String, require: true },
  userName: { type: String, require: true },
});

const Data = mongoose.model("photos", PostSchema);

module.exports = Data;
