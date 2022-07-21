import 'package:ex_2/language_tool.dart';
//import 'package:language_tool/language_tool.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: myApp(),
  ));
  var tool = LanguageTool();
  var badSentences = ['hi this is my fabourate color'];
  // Works for spelling mistakes.
  var result = await tool.check(badSentences[0]);

  markMistakes(result, badSentences[1]);

// Logic check.
  result = await tool.check(badSentences[1]);
}

///Prints every property for every [WritingMistake] passed.
void printDetails(List<WritingMistake> result) {
  for (var mistake in result) {
    print('''
        Issue: ${mistake.message}
        IssueType: ${mistake.issueDescription}
        positioned at: ${mistake.offset}
        with the lengh of ${mistake.length}.
        Possible corrections: ${mistake.replacements}
    ''');
  }
}

/// prints the given [sentence] with all mistakes marked red.
void markMistakes(List<WritingMistake> result, String sentence) {
  var red = '\u001b[31m';
  var reset = '\u001b[0m';

  var addedChars = 0;

  for (var mistake in result) {
    sentence = sentence.replaceRange(
      mistake.offset + addedChars,
      mistake.offset + mistake.length + addedChars,
      red +
          sentence.substring(mistake.offset + addedChars,
              mistake.offset + mistake.length + addedChars) +
          reset,
    );
    addedChars += 9;
  }

  print(sentence);
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  late String title;
  String text = "No Value Entered";
  TextEditingController inputcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('language tool'),
      ),
      body: Container(
        color: Colors.grey[400],
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: inputcontroller,
                  decoration: InputDecoration(
                      hintText: 'Input text for check spelling'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    text = inputcontroller.text;
                  });
                },
                child: Text(
                  'Check',
                ),
              ),
              Text(
                '$text',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
