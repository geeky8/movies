import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/get_movies_bloc.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/style/theme.dart' as Style;

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {

  @override
  void initState() {
    moviesBloc..getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20,),
          child: Text(
            "TOP RATED MOVIES",
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 5,),
        StreamBuilder<MovieResponse>(
            stream: moviesBloc.subject.stream,
            builder:(context,AsyncSnapshot<MovieResponse> snapshot){
              if(snapshot.hasData){
                if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                  return buildError(snapshot.data.error);
                }
                return _buildTopMovies(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        ),
      ],
    );
  }
  Widget _buildTopMovies(MovieResponse data){
    List<Movie> movies = data.movies;
    if(movies.length==0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO MOVIES"),
          ],
        ),
      );
    }else
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,),
                child: Column(
                  children: [
                    movies[index].poster==null
                        ? Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Style.Colors.secondColor,
                        borderRadius: BorderRadius.all(Radius.circular(2),),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: [
                          Icon(EvaIcons.filmOutline,color: Colors.white,size: 50,),
                        ],
                      ),
                    )
                        : Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2),),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200/"+movies[index].poster),fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].title,
                        maxLines: 2,
                        style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          movies[index].rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5,),
                        RatingBar.builder(
                          itemSize: 8,
                          initialRating: movies[index].rating/2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2),
                          itemBuilder: (context,_){
                            return Icon(EvaIcons.star,color: Style.Colors.secondColor,);
                          },
                          onRatingUpdate: (rating){
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
        ),
      );
  }
}
