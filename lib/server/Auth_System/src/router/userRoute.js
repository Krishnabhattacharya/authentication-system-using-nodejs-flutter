const User=require("../model/user");
const express=require("express");
const router=new express.Router();
const auth=require("../middleware/auth")
// sign-up
router.post("/signup",async(req,res)=>{
    const user=new User(req.body);
    try {
        await user.save();
        const token=await user.generateToken();
      
        res.status(201).send({user,token});
    } catch (error) {
        res.status(500).send({error:"somthing wrong"});
    }
})
//sign-in
router.post("/login",async(req,res)=>{
try {
    const user=await User.finduser(req.body.email,req.body.password);
    const token=await user.generateToken();
    res.send({user,token});
} catch (error) {
    res.status(500).send({error:"somthing wrong"});
}
})

//get authenticate users data
router.get("/profile",auth,async(req,res)=>{
  await  res.send(req.user);
})


module.exports=router;