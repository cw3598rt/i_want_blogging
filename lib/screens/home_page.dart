import 'package:flutter/material.dart';
import 'package:i_want_blogging/screens/prompt_page.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  void onTapMoveToBlogFormScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PromptScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(242, 255, 198, 137), Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Text(
                "AI Blogging",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: 32,
              ),
              Image.asset("assets/images/ai_writing_blogging.jpeg",
                  fit: BoxFit.contain),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    backgroundColor: Colors.amber.shade100),
                onPressed: () {
                  onTapMoveToBlogFormScreen(context);
                },
                child: Text(
                  "START",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
