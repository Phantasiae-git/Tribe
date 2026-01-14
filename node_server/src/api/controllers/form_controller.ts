import type { Request, Response } from "express";
import { User } from "../models/user.ts";
import { Form } from "../models/form.ts";

export const submitForm = async (req: Request, res: Response) => {
    try {
        const { user_id, min_age, max_age, min_members, max_members, target_locations, ok_with_pets, tags } = req.body;

        if (
            !user_id ||
            min_age == null ||
            max_age == null ||
            min_members == null ||
            max_members == null ||
            ok_with_pets == null ||
            tags == null
        ) {
            return res.status(400).json({ error: "All fields are required" });
        }

        console.log("hello?");
        console.log(JSON.stringify(req.body, null, 2));


        const user = await User.findById( user_id );

        if (!user) {
            return res.status(409).json({
                error: "No such user",
            });
        }

        const form = new Form({
            user_id,
            min_age,
            max_age,
            min_members,
            max_members,
            target_locations,
            ok_with_pets,
            tags
        });

        const savedForm = await form.save();

        res.status(200).json({
            user_id: savedForm.user_id,
            min_age: savedForm.min_age,
            max_age: savedForm.max_age,
            min_members: savedForm.min_members,
            max_members: savedForm.max_members,
            target_locations: savedForm.target_locations,
            ok_with_pets: savedForm.ok_with_pets,
            tags: savedForm.tags
        });
    } catch (error) {
        console.error("Submit form error:", error);
        res.status(500).json({ error: "Internal server error" });
    }
};