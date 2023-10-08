import 'package:flutter/material.dart';
import 'package:nepboard/word_count_shared_pref.dart';

class KeyboardLayout extends StatefulWidget {
  final TextEditingController controller;
  String ff;

  KeyboardLayout({super.key, required this.controller, required this.ff});

  @override
  State<KeyboardLayout> createState() => _KeyboardLayoutState();
}

class _KeyboardLayoutState extends State<KeyboardLayout> {
  String typedText = "";
  late TextEditingController _controller;

  late String localff;

  bool upperCase = false;
  String _fontChangeToggle = "Roman";
  List<String> recommendationWords = ["afea", "adsf", "jopj8"];
  WordCountData wordCountData = WordCountData();

  @override
  void initState() {
    super.initState();
    localff = widget.ff.toLowerCase();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    // dispose stuff later
    super.dispose();
  }

  // 1
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildButton(_fontChangeToggle, onPressed: () {
              setState(() {
                _fontChangeToggle =
                    (_fontChangeToggle == "Roman") ? "Direct" : "Roman";
                localff = (localff == widget.ff.toLowerCase())
                    ? "sans serif"
                    : widget.ff.toLowerCase();
              });
            })
          ],
        ),
        Row(
          children: recommendationWords.map((word) {
            return Expanded(
              child: TextButton(
                child: Text(
                  word,
                  style: TextStyle(fontFamily: widget.ff),
                ),
                onPressed: () {
                  typedText += '$word ';

                  _controller.text = typedText;
                },
              ),
            );
          }).toList(),
        ),
        Row(
          children: [
            _buildButton('🎙️'),
            _buildButton('🔍'),
            _buildButton('GIF', ts: const TextStyle( fontFamily: 'sans serif' )),
            _buildButton('📋'),
          ],
        ),
        Row(
          children: [
            _buildButton('1'),
            _buildButton('2'),
            _buildButton('3'),
            _buildButton('4'),
            _buildButton('5'),
            _buildButton('6'),
            _buildButton('7'),
            _buildButton('8'),
            _buildButton('9'),
          ],
        ),
        Row(
          children: [
            _buildButton('q'),
            _buildButton('w'),
            _buildButton('e'),
            _buildButton('r'),
            _buildButton('t'),
            _buildButton('y'),
            _buildButton('u'),
            _buildButton('i'),
            _buildButton('o'),
            _buildButton('p'),
          ],
        ),
        Row(
          children: [
            _buildButton('a'),
            _buildButton('s'),
            _buildButton('d'),
            _buildButton('f'),
            _buildButton('g'),
            _buildButton('h'),
            _buildButton('j'),
            _buildButton('k'),
            _buildButton('l'),
          ],
        ),
        Row(
          children: [
            // Shift button
            _buildButton('\u2191',
                flex: 2, ts: const TextStyle(fontWeight: FontWeight.w800),
                onPressed: () {
              setState(() {
                upperCase = !upperCase;
              });
            }),
            _buildButton('z'),
            _buildButton('x'),
            _buildButton('c'),
            _buildButton('v'),
            _buildButton('b'),
            _buildButton('n'),
            _buildButton('m'),
            _buildButton('⌫', onPressed: _backspace, onLongPress: () {
              while (_controller.text.isNotEmpty) {
                _backspace();
              }
            }),
          ],
        ),
        Row(
          children: [
            _buildButton("🙂",
                ts: const TextStyle(fontFamily: "sans serif"),
                onPressed: () {}),
            _buildButton('Space', flex: 3, onPressed: () {
              _input(" ");
            })
          ],
        ),
      ],
    );
  }

  // 2
  // Individual keys
  Widget _buildButton(String text,
      {TextStyle? ts,
      VoidCallback? onPressed,
      VoidCallback? onLongPress,
      int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 213, 99, 99), // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Border radius (optional)
        ),
        child: TextButton(
          onPressed: onPressed ?? () => _input(text),
          onLongPress: onLongPress ?? () {},
          child: Text(
            (upperCase) ? text.toUpperCase() : text.toLowerCase(),
            style: ts ??
                TextStyle(
                  fontFamily: localff,
                ),
          ),
        ),
      ),
    );
  }

  void _input(String text) async {
    setState(() {
      _controller.text += text;
      typedText += text;
    }); // inputs text
  }

  void _backspace() {
    setState(() {
      typedText = typedText.substring(0, typedText.length - 1);
      _controller.text = typedText;
    });
  }
}
