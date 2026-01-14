import 'package:flutter/material.dart';

class WaitlistPage extends StatefulWidget {
  const WaitlistPage({super.key});

  @override
  State<WaitlistPage> createState() => _WaitlistPageState();
}

class _WaitlistPageState extends State<WaitlistPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text("You are now on waitlist..."))),
      //add: Unsubmit form button with pop up warning that this will take you out of the queue
      //add: see my answers?
    );
  }
}
