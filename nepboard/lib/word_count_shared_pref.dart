import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepboard/word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key = 'jsonData';

class WordCountData {
  Future saveJsonData(jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    var saveData = jsonEncode(jsonData);
    await prefs.setString(key, saveData);
  }

  Future<void> getJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString(key) ?? {"": 0};
    var data = WordCountModel.fromMap(jsonDecode(temp.toString()));
    debugPrint("Data received: $data");
  }
}
