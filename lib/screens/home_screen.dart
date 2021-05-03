import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/genre.dart';
import 'package:movies/widgets/now_playing.dart';
import 'package:movies/widgets/person.dart';
import 'package:movies/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline,color: Colors.white,),
        title: Text("Movie"),
        actions: [
          IconButton(icon: Icon(EvaIcons.searchOutline,color: Colors.white,), onPressed: (){},),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          GenreScreen(),
          PersonList(),
          TopMovies(),
        ],
      ),
    );
  }
}
