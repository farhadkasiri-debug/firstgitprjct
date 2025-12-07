const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send(" Hi this is test!");
});

app.get("/health", (req, res) => {
  res.send("ok");
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
