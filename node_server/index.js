const express = require("express");

const app = express();
const port = 3333;

app.use(express.json());

app.use(express.urlencoded({
    extended: true
}));

const productData = [];

app.listen(port, () => {
    console.log("Connected at "+port);
});

app.post("/api/add_product", (req, res)=>{
    console.log("Result", req.body);

    const pdata = {
        "id": productData.length+1,
        "pname": req.body.pname,
        "pprice": req.body.pprice,
        "pdesc": req.body.pdesc
    };

    productData.push(pdata);
    console.log("Final", pdata);

    res.status(200).send({
        "status_code": 200,
        "message": "Product added successfully",
        "product": pdata
    })
});

app.get("/api/get_product", (req, res) => {

    if(productData.length>0){
        res.status(200).send({
        "status_code": 200,
        "products": productData
        })
    }else{
        res.status(200).send({
        "status_code": 200,
        "products": []
        })
    }
});

app.put("/api/update/:id", (req, res)=>{
    
    let id =req.params.id;
    let productToUpdate = productData.find(p=>p.id==id);
    let index = productData.indexOf(productToUpdate);

    productData[index] = req.body;

    console.log(productData);

    res.status(200).send({
        "status_code": 200,
        "message": "Product updated successfully"
    })
});