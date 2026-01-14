import mongoose from "mongoose";

let formSchema = new mongoose.Schema({
    user_id: {
        required: true,
        type: String//change to id object
    },
    min_age: {
        required: true,
        type: Number
    },
    max_age: {
        required: true,
        type: Number
    },
    min_members: {
        required: true,
        type: Number
    },
    max_members: {
        required: true,
        type: Number
    },
    target_locations: {
        type: [String],
        default: [],
    },
    ok_with_pets: {
        required: true,
        type: Boolean
    },
    tags: {
        type: Map,
        of: [
            {
                id: String,
                label: String
            }
        ],
        default: {}
    }
});

export const Form = mongoose.model("Form", formSchema);