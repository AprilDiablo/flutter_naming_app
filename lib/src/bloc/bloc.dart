import 'dart:async';

import 'package:english_words/english_words.dart';

class Bloc {
  Set<WordPair> saved = <WordPair>{};

  final _savedStreamController = StreamController<Set<WordPair>>.broadcast();

  // 스트림 콘트롤러를 이용해서 스트림을 가져온다.
  // Stream<Set<WordPair>> savedStream() {
  //   return _savedStreamController.stream;
  // }

  get savedStream => _savedStreamController.stream;

  get addCurrentSaved => _savedStreamController.sink.add(saved);

  // 그냥 클래스 내부의 데이터를 수정한다.
  // 스트림 콘트롤러와는 직접적으로 상관이 없다. 그냥 클래스의 내부 변수 수정이다.
  // 클래스와 스트림과의 관계는 saved변수를 공유하는 것 뿐이다.
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