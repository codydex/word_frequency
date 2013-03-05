import 'dart:html';

List fromTextToWords(String text) {
  /*
  var textWithout = text.replaceAll(',', '').replaceAll(';', '').
      replaceAll('.', '').replaceAll('\n', ' ');
  */
  var regexp = new RegExp("[,;:.?!()'`’“\"\n]");
  // http://www.regular-expressions.info/reference.html
  // \w : word characters (letters, digits, and underscores)
  // \W : negation of \w
  //var regexp = new RegExp('\W+');
  var textWithout = text.replaceAll(regexp, '');
  return textWithout.split(' ');
}

Map analyzeWordFrequency(List wordList) {
  var wordFrequencyMap = new Map();
  for (var w in wordList) {
    var word = w.trim();
    if (word != '') {
      if (!wordFrequencyMap.containsKey(word)) {
        wordFrequencyMap[word] = 0;
      }
      wordFrequencyMap[word] = wordFrequencyMap[word] + 1;
    }
  }
  return wordFrequencyMap;
}

List sortWords(Map wordFrequencyMap) {
  var wordWordFrequencyMap = new Map<String, String>();
  wordFrequencyMap.forEach((k, v) =>
      wordWordFrequencyMap[k] = '${k}: ${v.toString()}');
  List sortedWordList = wordWordFrequencyMap.values.toList();
  sortedWordList.sort((m,n) => m.compareTo(n));
  return sortedWordList;
}

void main() {
  TextAreaElement textArea = document.query('#text');
  TextAreaElement wordsArea = document.query('#words');
  ButtonElement wordsButton = document.query('#frequency');
  ButtonElement clearButton = document.query('#clear');
  wordsButton.onClick.listen((MouseEvent e) {
    wordsArea.value = 'Word: frequency \n';
    var text = textArea.value.trim();
    if (text != '') {
      var wordsList = fromTextToWords(textArea.value);
      var wordsMap = analyzeWordFrequency(wordsList);
      var sortedWordsList = sortWords(wordsMap);
      sortedWordsList.forEach((word) =>
          wordsArea.value = '${wordsArea.value} \n${word}');
    }
  });
  clearButton.onClick.listen((MouseEvent e) {
    textArea.value = '';
    wordsArea.value = '';
  });
}


