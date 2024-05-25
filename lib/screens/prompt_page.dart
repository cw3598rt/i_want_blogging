import 'package:flutter/material.dart';

import 'package:i_want_blogging/widgets/prompt_form.dart';

class PromptScreen extends StatelessWidget {
  PromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prompt Forms"),
        backgroundColor: Colors.yellowAccent.shade100,
      ),
      body: PromptForm(),
    );
  }
}
