import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepboard/keyboard_layout.dart';

class TypingScreen extends StatefulWidget {
  const TypingScreen({super.key});

  @override
  State<TypingScreen> createState() => _TypingScreenState();
}

class _TypingScreenState extends State<TypingScreen> {
  final TextEditingController _mainTextController = TextEditingController();
  final TextEditingController keyboardController = TextEditingController();
  final TextEditingController _engInputController = TextEditingController();
  final TextEditingController _indiInputController = TextEditingController();

  String ff = "Subba";
  final bool typeTextfieldReadonly = true;

  Map<String, int> _convertToMap() {

    List<String> words = _mainTextController.text.split(RegExp(r'\W+'));

    // Create a map to store word counts
    Map<String, int> wordCountMap = {};

    // Count the occurrences of each word
    for (String word in words) {
      if (word.isNotEmpty) {
        if (wordCountMap.containsKey(word)) {
          wordCountMap[word] = (wordCountMap[word] ?? 0) + 1;
        } else {
          wordCountMap[word] = 1;
        }
      }
    }
      return wordCountMap;
  }

  Future<void> _backup() async {
    for (final entry in _convertToMap().entries){
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': entry.key,
        'count': '${entry.value}',
        'lang': "${( ff == "subba" )? 2 : 1}" 
      }),
    );
    if (response.statusCode == 201) {
      print('Data posted successfully');
    } else {
      throw Exception('Failed to post data');
    }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NepBoard"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 50),
              child: TextButton(
                  onPressed: ()async{
                    await _backup();
                  },
                  child: const Text(
                    "Backup",
                    style: TextStyle(color: Colors.white),
                  ))),
          DropdownButton(
            value: ff,
            items: const [
              DropdownMenuItem(value: "Subba", child: Text("Subba", style: TextStyle(color: Colors.white),)),
              DropdownMenuItem(value: "Newa", child: Text("Newa", style: TextStyle(color: Colors.white))),
            ],
            onChanged: (str) {
              setState(() {
                ff = str.toString();
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Main text field
              TextField(
                enabled: false,
                keyboardType: TextInputType.multiline,
                maxLines: 14,
                minLines: 14,
                readOnly: false,
                controller: _mainTextController,
                style: TextStyle(fontFamily: ff),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                onChanged: (str) {
                  setState(() {
                    _mainTextController.text = str;
                  });
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    _mainTextController.text = "";
                  }, icon: const Icon(Icons.clear)),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _mainTextController.text));
                    },
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _engInputController,
                        decoration: const InputDecoration(hintText: "Type..."),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.change_circle)),
                    Expanded(
                      child: TextField(
                        controller: _indiInputController,
                        decoration: InputDecoration(hintText: ff ),
                        style: TextStyle(fontFamily: ff),
                      ), // Consider adding constraints
                    ),
                    TextButton(
                      child: const Text("Translate"),
                      onPressed: () {
                        if (_engInputController.text.toLowerCase() == "thank you"){
                          _indiInputController.text = "Nogen";
                        }

                        else if (_engInputController.text.toLowerCase() == "welcome"){
                          _indiInputController.text = "N;sL;";
                        }
                        
                      },
                    ),
                  ],
                ),
              ),

              // Keyboard
              KeyboardLayout(controller: _mainTextController, ff: ff),
            ],
          ),
        ),
      ),
    );
  }
}
