import 'package:flutter/material.dart';
import 'package:nepboard/typing_screen.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)
      ),
      home: const TypingScreen(),
    )
  );
}
