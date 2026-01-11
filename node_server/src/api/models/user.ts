import mongoose from "mongoose";
import bcrypt from "bcryptjs";

let userSchema = new mongoose.Schema({
    'username': {
        required: true,
        type: String
    },
    'name': {
        required: false,
        type: String
    },
    'email': {
        required: true,
        type: String
    },
    'password': {
        required: true,
        type: String
    },
    'pfp': {
        required: false,
        type: String
    },
    'dob': {
        required: false,
        type: String
    },
    'occupation': {
        required: false,
        type: String
    },
    'currLoc': {
        required: false,
        type: String
    },
    'gender': {
        required: false,
        type: String
    },
    'mbti': {
        required: false,
        type: String
    },
    'bio': {
        required: false,
        type: String
    },
    friends: {
        type: [String],
        default: [],
    }
});

userSchema.pre("save", async function () {
    if (!this.isModified("password")) return;
    this.password = await bcrypt.hash(this.password, 10);
});

export const User = mongoose.model("User", userSchema);