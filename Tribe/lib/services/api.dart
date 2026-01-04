import 'dart:convert';
import 'package:tribe/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tribe/model/product_model.dart';

class Api {
  static const baseUrl =
      "http://192.168.16.168/api/"; //remove hardcode, account for emulated and real phone bc real needs localhost+port?

  //USERS
  //get method (login)
  static Future<User?> getUser(Map<String, dynamic> pdata) async {
    final url = Uri.parse("${baseUrl}login");
    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        return User(
          id: data['_id'],
          username: data['username'],
          name: data['name'],
          email: data['email'],
          pfp: data['pfp'],
          dob: data['dob'],
          occupation: data['occupation'],
          currLocation: data['currLoc'],
          gender: data['gender'],
          bio: data['bio'],
          mbti: data['mbti'],
        );
      }
      print(jsonDecode(res.body));
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //post (Signup)
  static Future<User?> createUser(Map pdata) async {
    print(pdata);
    var url = Uri.parse("${baseUrl}createUser");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        return User(
          id: data['_id'],
          username: data['username'],
          name: data['name'],
          email: data['email'],
          pfp: data['pfp'],
          dob: data['dob'],
          occupation: data['occupation'],
          currLocation: data['currLoc'],
          gender: data['gender'],
          bio: data['bio'],
          mbti: data['mbti'],
        );
      } else {
        print("Failed to get response");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  //get all users
    static Future<List<User>> getAllUsers() async {
    List<User> users = [];

    var url = Uri.parse("${baseUrl}getUsers");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);
        data['users'].forEach(
          (value) => {
            users.add(
              User(
                id: value['_id'],
                name: value['name'],
                username: value['username'],
                email: value['email'],
                occupation: value['occupation'],
              ),
            ),
          },
        );
        return users;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
    return ([]);
  }

  //PRODUCTS (TEST)
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
        data['products'].forEach(
          (value) => {
            products.add(
              Product(
                id: value['_id'],
                name: value['pname'],
                price: value['pprice'],
                desc: value['pdesc'],
              ),
            ),
          },
        );
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
