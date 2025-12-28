var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import express from "express";
import mongoose from "mongoose";
import dotenv from 'dotenv';
import { Product } from "./product.js";
const app = express();
const port = 3333;
// dotenv.config({ path: "../.env" });
dotenv.config();
const DB_KEY = process.env.DB_KEY;
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
function startServer() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            console.log(`Connecting with ${DB_KEY}...`);
            yield mongoose.connect(`mongodb+srv://Phantasiae:${DB_KEY}@cluster0.fxphavu.mongodb.net/Tribe`);
            console.log("Status: Connected to Mongoose successfully");
            app.post("/api/add_product", (req, res) => __awaiter(this, void 0, void 0, function* () {
                console.log("Result", req.body);
                let data = new Product(req.body);
                try {
                    let dataToStore = yield data.save();
                    res.status(200).json(dataToStore);
                }
                catch (err) {
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
            }));
            app.get("/api/get_product", (req, res) => __awaiter(this, void 0, void 0, function* () {
                try {
                    let data = yield Product.find();
                    res.status(200).json({ products: data });
                }
                catch (error) {
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
            }));
            app.get("/api/get_product/:id", (req, res) => __awaiter(this, void 0, void 0, function* () {
                try {
                    let data = yield Product.findById(req.params.id);
                    res.status(200).json(data);
                }
                catch (error) {
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
            }));
            app.put("/api/update/:id", (req, res) => __awaiter(this, void 0, void 0, function* () {
                let id = req.params.id;
                let updatedData = req.body;
                let options = { new: true };
                try {
                    const data = yield Product.findByIdAndUpdate(id, updatedData, options);
                    res.send(data);
                }
                catch (error) {
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
            }));
            app.delete("/api/delete/:id", (req, res) => __awaiter(this, void 0, void 0, function* () {
                let id = req.params.id;
                try {
                    const data = yield Product.findByIdAndDelete(id);
                    res.json({
                        'status': "Deleted succesfully"
                    });
                }
                catch (error) {
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
            }));
            app.listen(port, () => {
                console.log("Connected at " + port);
            });
        }
        catch (err) {
            console.error("Mongoose connection error:", err);
        }
    });
}
startServer();
//# sourceMappingURL=index.js.map