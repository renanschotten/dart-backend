import 'dart:io';
import 'parser_extension.dart';

class CustomEnv {
  static Map<String, String> _envMap = {};
  static String _file = '.env';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<Type> get<Type>({required String key}) async {
    if (_envMap.isEmpty) await _load();
    return _envMap[key]!.toType(type: Type);
  }

  static Future<void> _load() async {
    List<String> lines =
        (await _readFile()).replaceAll(String.fromCharCode(13), '').split("\n");
    _envMap = {
      for (var line in lines) line.split('=')[0]: line.split('=')[1],
    };
  }

  static Future<String> _readFile() async {
    final String fileString = await File(_file).readAsString();
    return fileString;
  }
}
