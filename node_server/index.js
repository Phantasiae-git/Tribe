const express = require("express");
const mongoose = require("mongoose");
const Product = require("./product");

const app = express();
const port = 3333;

app.use(express.json());

app.use(express.urlencoded({
    extended: true
}));

const productData = [];

async function startServer() {
    try {
        await mongoose.connect(`mongodb+srv://Phantasiae:${db_pass}@cluster0.fxphavu.mongodb.net/Tribe`);
        console.log("Status: Connected to Mongoose successfully");

        app.post("/api/add_product", async (req, res) => {
            console.log("Result", req.body);

            let data = Product(req.body);

            try{
                let dataToStore = await data.save();
                res.status(200).json(dataToStore);
            } catch (error) {
                res.status(400).json({
                    'status': error.message
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

        app.get("/api/get_product", async (req, res) => {

            try {
                let data = await Product.find();
                res.status(200).json({ products: data });
            } catch (error) {
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

            app.get("/api/get_product/:id", async (req, res) => {

            try {
                let data = await Product.findById(req.params.id);
                res.status(200).json(data);
            } catch (error) {
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

        app.put("/api/update/:id", async (req, res) => {//change flutter to patch as well!!

            let id = req.params.id;
            let updatedData = req.body;
            let options = {new: true};
            try {
                const data = await Product.findByIdAndUpdate(id, updatedData, options);
                res.send(data);
            } catch (error) {
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

        app.delete("/api/delete/:id", async (req, res) => {

            let id = req.params.id;

            try {
                const data = await Product.findByIdAndDelete(id);
                res.json({
                    'status': "Deleted succesfully"
                })
            } catch (error) {
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