import 'package:flutter/material.dart';
import 'package:tribe/model/user_model.dart';
import 'package:tribe/services/api.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Api.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          } else {
            List<User> users;
            if (snapshot.data.runtimeType == List<User>) {
              users = snapshot.data;
            } else {
              throw Exception("Failed to fetch data.");
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.storage),
                  title: Text("${users[index].username}"),
                  subtitle: Text("${users[index].email}"),
                  trailing: Text("€ ${users[index].occupation}"),
                );
              }
              );
          }
        }
        ),
    );;
  }
}