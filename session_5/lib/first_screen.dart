import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'dart:core';

class FirstScreen extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  bool validateName(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
    return nameRegExp.hasMatch(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String inputText = _textFieldController.text;
                  try {
                    if (inputText.isEmpty) {
                      throw Exception("Nama tidak boleh kosong.");
                    }
                    if (!validateName(inputText)) {
                      throw Exception("Nama hanya boleh mengandung huruf dan spasi.");
                    }
                    Navigator.pushNamed(
                      context,
                      '/second',
                      arguments: inputText,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: Text('Input'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            String inputText = _textFieldController.text;
            try {
              if (inputText.isEmpty) {
                throw Exception("Nama tidak boleh kosong.");
              }
              if (!validateName(inputText)) {
                throw Exception("Nama hanya boleh mengandung huruf dan spasi.");
              }
              Navigator.pushNamed(
                context,
                '/second',
                arguments: inputText,
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Second',
          ),
        ],
      ),
    );
  }
}