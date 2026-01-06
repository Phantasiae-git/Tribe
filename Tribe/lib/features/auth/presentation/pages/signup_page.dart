import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tribe/features/auth/presentation/components/my_button.dart';
import 'package:tribe/features/auth/presentation/components/my_text_field.dart';
import 'package:tribe/features/auth/presentation/cubits/auth_cubit.dart';

class SignupPage extends StatefulWidget {
  final void Function()? togglePages;
  const SignupPage({super.key, required this.togglePages});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  void register() {
    final String username = usernameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;

    final authCubit = context.read<AuthCubit>();

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.register(username, email, pw);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 50),
                Text(
                  "Welcome to Tribe",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPwController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(onTap: register, text: "Register"),

                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Login instead",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
