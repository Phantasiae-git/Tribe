import mongoose from "mongoose";

let dataSchema = new mongoose.Schema({
    'pname': {
        required: true,
        type: String
    },
    'pprice': {
        required: true,
        type: String
    },
    'pdesc': {
        required: true,
        type: String
    },
});

export const Product = mongoose.model("Product", dataSchema);