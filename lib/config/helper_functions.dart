String cleanShortcodes(String inputText) {
  return inputText.replaceAll(RegExp(r'\[(.*?)\]'), '');
}
