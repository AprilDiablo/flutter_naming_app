import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'bloc/bloc.dart';

class SavedList extends StatefulWidget {
  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Saved"),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Object>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {

        Set<WordPair> saved = <WordPair>{};

        if(snapshot != null) {
          if(snapshot.hasData) {
            saved.addAll(snapshot.data as Set<WordPair>);
          } else {
            bloc.addCurrentSaved;
          }
        }

        return ListView.builder(
          itemCount: saved.length * 2,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }
            var realIndex = index ~/ 2;

            return _buildRow(saved.toList()[realIndex]);
          },
        );
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          bloc.addToOrRemoveFromSavedList(pair);
        });
      },
    );
  }
}
