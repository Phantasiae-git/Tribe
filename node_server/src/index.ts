import express from "express";
import mongoose from "mongoose";
import dotenv from 'dotenv'
import { Product } from "./product.js";

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
            let options = {new: true};
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