import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movies_byGenre_bloc.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/genre_movies.dart';

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  GenreList({Key key,@required this.genres}):super(key: key);
  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList> with SingleTickerProviderStateMixin{
  final List<Genre> genres;
  TabController _controller;

  _GenreListState(this.genres);

  @override
  void initState() {
    _controller = TabController(length: genres.length, vsync: this);
    _controller.addListener(() {
      if(_controller.indexIsChanging){
        moviesbygenreBloc..drainStream();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                controller: _controller,
                indicatorColor: Style.Colors.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre genre){
                  return Container(
                    padding: EdgeInsets.only(top: 10,bottom: 15),
                    child: Text(
                      genre.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre){
              return GenreMovies(genreId: genre.id);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
