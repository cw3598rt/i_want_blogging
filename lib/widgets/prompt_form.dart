import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:i_want_blogging/screens/blogging_result_page.dart';
import 'package:text_area/text_area.dart';

final gemini = Gemini.instance;

class PromptForm extends StatefulWidget {
  PromptForm({
    super.key,
  });

  @override
  State<PromptForm> createState() => _PromptFormState();
}

class _PromptFormState extends State<PromptForm> {
  final _myTextController = TextEditingController();
  final _myExamples = TextEditingController();
  String? _role;
  String? _target;
  String? _tone;
  var _mainContentsValidation = true;
  var _examplesValidation = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onTapSubmit() async {
    final myContents;

    if (_formKey.currentState!.validate() && !_examplesValidation) {
      if (!_mainContentsValidation) {
        _formKey.currentState!.save();
        myContents =
            "${_role ??= ""} ${_myTextController.text} ${(_target == null || _target == "") && (_tone == null || _tone == "") && _myExamples.text.isEmpty ? "" : "here are extra information for better answering."} ${(_target != null && _target!.isNotEmpty) ? "target: $_target" : ""} ${(_tone != null && _tone!.isNotEmpty) ? "tone: $_tone" : ""}${_myExamples.text}";

        gemini
            .streamGenerateContent(myContents)
            .listen((value) {})
            .onError((e) {
          log('streamGenerateContent exception', error: e);
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BloggingResultScreen();
            },
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _myTextController.addListener(() {
      setState(() {
        if (_myTextController.text.isEmpty) {
          _mainContentsValidation = true;
        } else if (_myTextController.text.trim().length >= 100) {
          _mainContentsValidation = true;
        } else {
          _mainContentsValidation = false;
        }
      });
    });
    _myExamples.addListener(() {
      setState(() {
        _examplesValidation = _myExamples.text.trim().length >= 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.yellowAccent.shade100, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Icon(
                      Icons.label_important,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Share your Role with AI",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                      ),
                    ),
                  ]),
                  TextFormField(
                    validator: (value) {
                      if (value!.trim().length >= 50) {
                        return "Role must be below 50 words.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "ex) i'm professional traveller...",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onSaved: (newValue) {
                      _role = newValue;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Please Write your main content",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      TextArea(
                        borderRadius: 10,
                        borderColor: const Color(0xFFCFD6FF),
                        textEditingController: _myTextController,
                        validation: _mainContentsValidation,
                        errorText: 'Please type a Contents in 1words!',
                      ),
                      Positioned(
                          bottom: 30,
                          right: 10,
                          child: Text(
                              "${_myTextController.text.trim().length}/100"))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.trim().length >= 50) {
                              return "Target must be below 50 words.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Your target! ex) non-travellers...",
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onSaved: (newValue) {
                            _target = newValue;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.trim().length >= 50) {
                              return "Tone must be below 50 words.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Tone! ex) Polite or Concisly...",
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onSaved: (newValue) {
                            _tone = newValue;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Any Examples",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "template or your experience",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      TextArea(
                        borderRadius: 10,
                        borderColor: const Color(0xFFCFD6FF),
                        textEditingController: _myExamples,
                        validation: _examplesValidation,
                        errorText: 'Examples must be below 100 words!',
                      ),
                      Positioned(
                          bottom: 30,
                          right: 10,
                          child: Text("${_myExamples.text.trim().length}/100"))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: onTapSubmit,
                    child: Text("Submit"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
