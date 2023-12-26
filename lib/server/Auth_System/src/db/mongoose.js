const mongoose=require("mongoose");
mongoose.connect("mongodb://127.0.0.1:27017/auth-system").then(()=>{
return console.log("Successfully connected");
}).catch((e)=>{
    console.log(e);
})
