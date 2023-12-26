const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
require("./db/mongoose");
const Userrouter = require("./router/userRoute")
app.use(express.json());
app.use(Userrouter);
app.listen(PORT, () => {
    console.log(`Server is running on ${PORT}`);
})