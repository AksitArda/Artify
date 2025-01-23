const mongoose = require("mongoose");

const conn = async () => {
  await mongoose
    .connect(process.env.MONGODB_URI, {
      dbName: "blog",
      useNewUrlParser: true,
      useUnifiedTopology: true,
    })
    .then(() => {
      console.log("Db Connected");
    })
    .catch((err) => {
      console.log(err);
    });
};

module.exports = conn;
