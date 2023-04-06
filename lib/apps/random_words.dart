import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// Random words generated as list and scrollable
/// with possibility to favourite some words and
/// view them in separated window

class RandomWordsAPP extends StatelessWidget {
  const RandomWordsAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _wordPair = <WordPair>[]; // Generated and presented
  final _savedWords = <WordPair>{}; // Favourites

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordPair Generator'),
        actions: [
          IconButton(icon: const Icon(Icons.list), onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  final Iterable<ListTile> tiles = _savedWords.map((
                      WordPair pair) {
                    return ListTile(title: Text(pair.asPascalCase,
                        style: const TextStyle(fontSize: 16.0)));
                  });

                  final List<Widget> divided = ListTile.divideTiles(
                      context: context, tiles: tiles).toList();

                  return Scaffold(
                      appBar: AppBar(title: const Text('Saved WordPairs')),
                      body: SafeArea(child: ListView(children: divided)));
                }));
          }),
        ],
      ),
      body: SafeArea(child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) return const Divider();

          // Calculating word index without the divider
          final wordIndex = index ~/ 2;

          if (wordIndex >= _wordPair.length) {
            _wordPair.addAll(generateWordPairs().take(10));
          }

          final currentWordPair = _wordPair[wordIndex];
          final alreadySaved = _savedWords.contains(currentWordPair);

          return ListTile(
            title: Text(currentWordPair.asPascalCase,
                style: const TextStyle(fontSize: 18.0)),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _savedWords.remove(currentWordPair);
                } else {
                  _savedWords.add(currentWordPair);
                }
              });
            },
          );
        },
      ),
      ),
    );
  }
}