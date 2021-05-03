import 'package:flutter/material.dart';
import 'package:movies/bloc/get_genres_bloc.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/widgets/genres_list.dart';

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {

  @override
  void initState() {
    genresBloc..getGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genresBloc.subject.stream,
        builder:(context,AsyncSnapshot<GenreResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error!=0 && snapshot.data.error.length>0){
              return buildError(snapshot.data.error);
            }
            return _buildGenre(snapshot.data);
          }
          else if(snapshot.hasError){
            return buildError(snapshot.error);
          }
          else{
            return buildLoading();
          }
        }
    );
  }
  Widget _buildGenre(GenreResponse data){
    List<Genre> genres = data.genre;
    if(genres.length==0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Genres"),
          ],
        ),
      );
    }else return GenreList(genres: genres);
  }
}
