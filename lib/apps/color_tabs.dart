import 'package:flutter/material.dart';

class ColorTabsApp extends StatelessWidget {
  const ColorTabsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colored Tabs Demo App',
      home: ColoredPages(),
    );
  }
}

class ColoredPages extends StatefulWidget {
  const ColoredPages({Key? key}) : super(key: key);

  @override
  State<ColoredPages> createState() => _ColoredPagesState();
}

class _ColoredPagesState extends State<ColoredPages> {
  // the index of the current page
  int _activePageIndex = 0;

  /// declare and initialize the page controller
  /// with initial page that will show first when create
  /// PageView
  final PageController _pageController = PageController(initialPage: 0);

  // this list holds all the pages
  // all of them are constructed in the very end of this file for readability
  final List<Widget> _pages = [
    const Page(
      color: Colors.pink,
      colorName: 'Pink',
    ),
    const Page(
      color: Colors.blue,
      colorName: 'Blue',
    ),
    const Page(
      color: Colors.green,
      colorName: 'Green',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _activePageIndex = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            },
          ),
          // Display the dots indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  _pages.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        _pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 8,
                        // check if a dot is connected to the current page
                        // if true, give it a different color
                        backgroundColor:
                            _activePageIndex == index ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final Color color;
  final String colorName;

  const Page({Key? key, required this.color, required this.colorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        '$colorName Page',
        style: const TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}
