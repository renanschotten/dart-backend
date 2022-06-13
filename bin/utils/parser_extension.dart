extension ParserExtension on String {
  toType({required Type type}) {
    switch (type) {
      case String:
        return toString();
      case int:
        return int.parse(toString());
      default:
        return toString();
    }
  }
}
