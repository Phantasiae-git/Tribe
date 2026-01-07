
import 'package:flutter/material.dart';
import 'package:tribe/model/product_model.dart';
import './services/api.dart';

class FetchData extends StatelessWidget {
  const FetchData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Api.getProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          } else {
            List<Product> pdata;
            if (snapshot.data.runtimeType == List<Product>) {
              pdata = snapshot.data;
            } else {
              throw Exception("Failed to fetch data.");
            }
            return ListView.builder(
              itemCount: pdata.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.storage),
                  title: Text("${pdata[index].name}"),
                  subtitle: Text("${pdata[index].desc}"),
                  trailing: Text("€ ${pdata[index].price}"),
                );
              }
              );
          }
        }
        ),
    );
  }
}