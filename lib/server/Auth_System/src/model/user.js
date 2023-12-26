const mongoose = require("mongoose");
const validator = require("validator");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        unique: true,
        required: true,
        validate(value) {
            if (!validator.isEmail(value)) {
                throw new Error("Give a proper Email");
            }
        }
    },
    password: {
        type: String,
        required: true,
        validate(value) {
            if (value.length < 6) {
                throw new Error("password should be at least 6 characters");
            }
        }
    },
    tokens: [{
        token: {
            type: String,
            required: true
        }
    }]
});
//hide password and tokens array
userSchema.methods.toJSON = function () {
    const user = this;
    const userObject = user.toObject();
    delete userObject.password;
    delete userObject.tokens;
    return userObject;
}

//generate token
userSchema.methods.generateToken = async function () {
    const user = this;
    const token = jwt.sign({ _id: user._id.toString() }, "generatetoken");
    user.tokens = user.tokens.concat({ token });
    await user.save();
    return token;
}

//fine a user by email and password
userSchema.statics.finduser = async (email, password) => {
    const user = await User.findOne({ email });
    if (!user) {
        throw new Error("Not find the user");
    }
    const ismMatch = bcryptjs.compare(password, user.password);
    if (!ismMatch) {
        throw new Error("password not matched");
    }
    return user;
}
//hashed the password
userSchema.pre("save", async function (next) {
    const user = this;
    if (user.isModified("password")) {
        user.password = await bcryptjs.hash(user.password, 10);
    }
    next();
})
const User = mongoose.model("users", userSchema);
module.exports = User;
