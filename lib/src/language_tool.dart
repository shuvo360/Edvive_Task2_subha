import 'package:http/http.dart' as http;

import 'data/awnser_raw.dart';
import 'data/writing_mistake.dart';

class LanguageTool {
  final bool picky;

  final String language;

  LanguageTool({
    this.picky = false,
    this.language = 'auto',
  });

  final _headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  Future<List<WritingMistake>> check(String text) async {
    var languageToolUri = Uri.https("api.languagetoolplus.com", "v2/check");
    var res = await http.post(
      languageToolUri,
      headers: _headers,
      body: _formatDataArgument(text),
    );

    if (res.statusCode != 200) {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }

    final languageToolAwnser = languageToolAwnserFromJson(res.body);
    return parseWritings(languageToolAwnser);
  }

  String _formatDataArgument(String uncheckedText) {
    var level = picky ? 'picky' : 'default';
    var text = uncheckedText.replaceAll(' ', '%20');

    return 'text=$text&language=$language&enabledOnly=false&level=$level';
  }

  /// Converts a [LanguageToolAwnserRaw] in a  [WritingMistake].
  List<WritingMistake> parseWritings(LanguageToolAwnserRaw languageToolAwnser) {
    var result = <WritingMistake>[];
    for (var match in languageToolAwnser.matches) {
      var replacements = <String>[];
      for (var item in match.replacements) {
        replacements.add(item.value);
      }

      result.add(
        WritingMistake(
            issueDescription: match.rule.description,
            issueType: match.rule.issueType,
            length: match.length,
            offset: match.offset,
            replacements: replacements,
            message: match.message),
      );
    }
    return result;
  }
}
