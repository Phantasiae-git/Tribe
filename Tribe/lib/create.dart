import 'package:flutter/material.dart';
import './services/api.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name here"
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                hintText: "Price here"
              ),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: "Desc here"
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              var data = {
                "pname": nameController.text,
                "pprice": priceController.text,
                "pdesc": descController.text,
              };

              Api.addproduct(data);
            }, child: Text("Create data"))
          ],
        ),
      ),
    );
  }
}