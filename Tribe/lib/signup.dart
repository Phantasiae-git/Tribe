import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tribe/dashboard.dart';
import 'package:tribe/login.dart';
import 'package:tribe/services/api.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var usernameController = TextEditingController();
  var passController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(
                      duration: Duration(seconds: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/cat.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/shaco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(198, 135, 135, 0.298),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(198, 135, 135, 0.298),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: emailController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(198, 135, 135, 0.298),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Google auth",
                          style: TextStyle(
                            color: Color.fromRGBO(196, 135, 198, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: () async {
                        var data = {
                          "username": usernameController.text,
                          "email": emailController.text,
                          "password": passController.text,
                        };

                        final user = await Api.createUser(data);
                        print(user);
                        if (user==null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Signup failed")),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(user: user),
                          ),
                        );
                      },
                      color: const Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                        },
                        child: Text(
                          "Login instead",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, .6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
