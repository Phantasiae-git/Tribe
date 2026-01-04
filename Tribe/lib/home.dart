import 'package:flutter/material.dart';
import 'package:tribe/delete.dart';
import 'package:tribe/login.dart';
import 'create.dart';
import 'fetch.dart';
import 'update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateData()),
                );
              },
              child: Text("CREATE (POST)"),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FetchData()),
                );
            }, child: Text("SHOW ALL (GET)")),
            ElevatedButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateScreen()),
                );
            }, child: Text("PUT/PATCH")),
            ElevatedButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeleteScreen()),
                );
            }, child: Text("DELETE")),
            
            ElevatedButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
            }, child: Text("LOGIN")),
          ],
        ),
      ),
    );
  }
}
