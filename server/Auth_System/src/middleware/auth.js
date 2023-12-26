const jwt = require("jsonwebtoken");
const User = require("../model/user");

const auth = async (req, res, next) => {
    try {
        const token = req.header("Authorization").replace("Bearer ", "");
        
        const decoded = jwt.verify(token, "generatetoken");
        const user = await User.findOne({ _id: decoded._id, "tokens.token": token });

        if (!user) {
            return res.status(401).send({ error: "Authentication failed" });
        }

        req.token = token;
        req.user = user;
        next();
    } catch (error) {
        res.status(401).send({ error: "Invalid token" });
    }
};

module.exports = auth;
