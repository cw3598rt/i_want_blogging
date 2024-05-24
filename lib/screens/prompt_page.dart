import 'package:flutter/material.dart';

class PromptScreen extends StatefulWidget {
  PromptScreen({super.key});

  @override
  State<PromptScreen> createState() {
    return _PromptScreenState();
  }
}

class _PromptScreenState extends State<PromptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prompt Forms"),
      ),
      body: Text("aaa"),
    );
  }
}
