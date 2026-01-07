import express from "express";
import mongoose from "mongoose";
import dotenv from 'dotenv'
import bcrypt from "bcryptjs";
import { Product } from "./product.ts";
import { User } from "./user.ts";

const app = express();
const port = 3333;

dotenv.config();
const DB_KEY = process.env.DB_KEY;

app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));

async function startServer() {
    try {
        console.log(`Connecting with ${DB_KEY}...`)
        await mongoose.connect(`mongodb+srv://Phantasiae:${DB_KEY}@cluster0.fxphavu.mongodb.net/Tribe`);
        console.log("Status: Connected to Mongoose successfully");
        console.log(`Link: mongodb+srv://Phantasiae:${DB_KEY}@cluster0.fxphavu.mongodb.net/Tribe`);

        app.post("/api/createUser", async (req: any, res: any) => {
            console.log("Result", req.body);

            let data = new User(req.body);

            try {
                let dataToStore = await data.save();
                res.status(200).json(dataToStore);//don't send back password!! CHANGE
            } catch (err: any) {
                res.status(400).json({
                    'status': err.message
                });
            }
        });

        app.post("/api/login", async (req: any, res: any) => {
            const { email, password } = req.body;
            try {
                const user = await User.findOne({ email });

                if (!user) {
                    return res.status(401).json({ error: "Invalid email" });
                }
                const isMatch = await bcrypt.compare(password, user.password);

                if (!isMatch) {
                    return res.status(401).json({ error: "Invalid password" });
                }
                console.log(user);
                res.status(200).json(user);//don't send back password!! CHANGE
            } catch (error: any) {
                res.status(500).json({ error: `Server error:${error.message}` });
            }
        });

        app.get("/api/getUser/:id", async (req: any, res: any) => {
            let _id = req.params.id;
            try {
                const user = await User.findOne({ _id });

                if (!user) {
                    return res.status(401).json({ error: "Invalid uid" });
                }
                console.log(user);
                res.status(200).json(user);
            } catch (error: any) {
                res.status(500).json({ error: `Server error:${error.message}` });
            }
        });

        app.put("/api/updateUser/:id", async (req: any, res: any) => {
           
            let id = req.params.id;
            let updatedData = req.body;
            let options = { new: true };
    
            try {
                const data = await User.findByIdAndUpdate(id, updatedData, options);
                if (!data) {
                    res.status(404).json({ error: "User not found" });
                }else{
                    res.status(200).json(data);
                }
            } catch (error: any) {
                res.status(500).json({ error: error.message });
            }
        });

        app.get("/api/getUsers", async (req: any, res: any) => {

            try {
                let data = await User.find();
                console.log(data);
                res.status(200).json({ users: data });
            } catch (error: any) {
                res.status(500).json(error.message);
            }
        });


        app.post("/api/add_product", async (req: any, res: any) => {
            console.log("Result", req.body);

            let data = new Product(req.body);

            try {
                let dataToStore = await data.save();
                res.status(200).json(dataToStore);
            } catch (err: any) {
                res.status(400).json({
                    'status': err.message
                });
            }
            // const pdata = {
            //     "id": productData.length + 1,
            //     "pname": req.body.pname,
            //     "pprice": req.body.pprice,
            //     "pdesc": req.body.pdesc
            // };

            // productData.push(pdata);
            // console.log("Final", pdata);

            // res.status(200).send({
            //     "status_code": 200,
            //     "message": "Product added successfully",
            //     "product": pdata
            // })
        });

        app.get("/api/get_product", async (req: any, res: any) => {

            try {
                let data = await Product.find();
                res.status(200).json({ products: data });
            } catch (error: any) {
                res.status(500).json(error.message);
            }
            // if (productData.length > 0) {
            //     res.status(200).send({
            //         "status_code": 200,
            //         "products": productData
            //     })
            // } else {
            //     res.status(200).send({
            //         "status_code": 200,
            //         "products": []
            //     })
            // }
        });

        app.get("/api/get_product/:id", async (req: any, res: any) => {

            try {
                let data = await Product.findById(req.params.id);
                res.status(200).json(data);
            } catch (error: any) {
                res.status(500).json(error.message);
            }
            // if (productData.length > 0) {
            //     res.status(200).send({
            //         "status_code": 200,
            //         "products": productData
            //     })
            // } else {
            //     res.status(200).send({
            //         "status_code": 200,
            //         "products": []
            //     })
            // }
        });

        app.put("/api/update/:id", async (req: any, res: any) => {//change flutter to patch as well!!

            let id = req.params.id;
            let updatedData = req.body;
            let options = { new: true };
            try {
                const data = await Product.findByIdAndUpdate(id, updatedData, options);
                res.send(data);
            } catch (error: any) {
                res.send(error.message);
            }
            // let id = req.params.id;
            // let productToUpdate = productData.find(p => p.id == id);
            // let index = productData.indexOf(productToUpdate);

            // productData[index] = req.body;

            // console.log(productData);

            // res.status(200).send({
            //     "status_code": 200,
            //     "message": "Product updated successfully"
            // })
        });

        app.delete("/api/delete/:id", async (req: any, res: any) => {

            let id = req.params.id;

            try {
                const data = await Product.findByIdAndDelete(id);
                res.json({
                    'status': "Deleted succesfully"
                })
            } catch (error: any) {
                res.json(error.message);
            }
            // let id = req.params.id;
            // let productToUpdate = productData.find(p => p.id == id);
            // let index = productData.indexOf(productToUpdate);

            // productData.splice(index, 1);

            // res.status(200).send({
            //     "status_code": 200,
            //     "message": "Product deleted successfully"
            // })
        });

        app.listen(port, () => {
            console.log("Connected at " + port);
        });
    } catch (err) {
        console.error("Mongoose connection error:", err);
    }
}

startServer();