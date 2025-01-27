const express = require("express");
const dotenv = require("dotenv");
const conn = require("./db");
const dataRoutes = require("./post/postRoutes");
const imageRoutes = require("./imageRoutes");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(express.static("./uploads"));

app.use(bodyParser.json());

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*"); // update to match the domain you will make the request from
  res.header("Access-Control-Allow-Credentials", "true");
  res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
  res.header(
    "Access-Control-Allow-Headers",
    "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  );

  next();
});

const corsOptions = {
  allowedHeaders: ["Content-Type", "Authorization"],
};
app.use(cors(corsOptions));

dotenv.config();
conn();

app.use("/", dataRoutes, imageRoutes);

app.listen(4001, () => console.log("Server is running"));
