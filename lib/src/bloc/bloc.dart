import 'dart:async';

import 'package:english_words/english_words.dart';

class Bloc {
  Set<WordPair> saved = <WordPair>{};

  final _savedStreamController = StreamController<Set<WordPair>>();

  // Stream<Set<WordPair>> savedStream() {
  //   return _savedStreamController.stream;
  // }

  get savedStream => _savedStreamController.stream;

  addToOrRemoveFromSavedList(WordPair item) {
    if(saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }

    // 데이터가 변경되었음을 스트림콘트롤러에 알려준다.
    _savedStreamController.sink.add(saved);
  }

  dispose() {
    _savedStreamController.close();
  }
}

var bloc = Bloc();