const mongoose = require("mongoose");

const PostSchema = new mongoose.Schema({
  title: { type: String, required: true },
  content: { type: Object, required: true },
  tags: { type: [String], validate: (v) => Array.isArray(v) && v.length > 0 },
  public: { type: Boolean, require: true },
});

const Data = mongoose.model("posts", PostSchema);

module.exports = Data;
