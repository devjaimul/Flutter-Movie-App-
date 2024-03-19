import 'package:flutter/material.dart';
import 'package:movie_app/ui/movie/movie_page.dart';
import 'package:movie_app/ui/tv/tv_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget getView() {
    if (_selectedIndex == 0) {
      return MoviePage();
    } else {
      return TVPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Flutter Movie App"),
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV"),
        ],
      ),
    );
  }
}
