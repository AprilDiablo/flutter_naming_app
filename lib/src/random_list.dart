import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_naming_app/src/bloc/bloc.dart';
import 'package:flutter_naming_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomListState();
  }
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: const Text("naming app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SavedList())
                );
              },
            )
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream, // bloc 클래스의 savedStream을 사용하겠다.
      builder: (context, snapshot) { // streamBuilder 내부의 데이터가 변경될때마다 snapshot이 온다.

        return ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }
          var realIndex = index ~/ 2;
          if (realIndex >= _suggestions.length) {
            final take10 = generateWordPairs().take(10);
            _suggestions.addAll(take10);
          }

          return _buildRow(snapshot.data, _suggestions[realIndex]);
        });
      }
    );
  }

  Widget _buildRow(Set<WordPair>? saved, WordPair pair) {
    final bool alreadySaved = saved==null? false : saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        setState(() {
          bloc.addToOrRemoveFromSavedList(pair);
        });
      },
    );
  }
}
