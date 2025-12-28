import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tribe/model/product_model.dart';

class Api {
  static const baseUrl = "http://localhost:3333/api/";


//post method
  static Future<void> addproduct(Map pdata) async {

    print(pdata);
    var url = Uri.parse("${baseUrl}add_product");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      print(e.toString());
    }
  }

//get method
    static Future<List<dynamic>> getProduct() async {

    List<Product> products = [];

    var url = Uri.parse("${baseUrl}get_product");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);
        data['products'].forEach((value) => {
          products.add(Product(id: value['_id'], name: value['pname'], price: value['pprice'], desc: value['pdesc']))
        });
        return products;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
    return ([]);
  }

//update put method
  static Future<void> updateProduct(id, body) async {

    var url = Uri.parse("${baseUrl}update/$id");
    try {
      final res = await http.put(url, body: body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);
      } else {
        print("Failed to update data");
      }
    } catch (e) {
      print(e.toString());
    }
  }

//delete method
static Future<void> deleteProduct(dynamic id) async {

    var url = Uri.parse("${baseUrl}delete/$id");
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);
      } else {
        print("Failed to delete");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
