import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/get_now_playing.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movies/style/theme.dart' as Style;

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  @override
  void initState() {
    nowPlayingBloc..getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: nowPlayingBloc.subject.stream,
        builder:(context,AsyncSnapshot<MovieResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error!=0 && snapshot.data.error.length>0){
              return buildError(snapshot.data.error);
            }
            return _buildNowPlaying(snapshot.data);
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
  Widget _buildNowPlaying(MovieResponse data){
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
    }
    else{
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8,
          padding: EdgeInsets.all(5),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context,index){
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster),fit: BoxFit.cover),

                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Style.Colors.mainColor.withOpacity(1),
                            Style.Colors.mainColor.withOpacity(0),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter,
                          stops: [
                            0.0,
                            0.9,
                          ]
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Icon(FontAwesomeIcons.playCircle,color: Style.Colors.secondColor,size: 40,),
                    ),
                    Positioned(
                      bottom: 30,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movies[index].title,
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                    )
                  ],
                );
              }
          ),
          length: movies.take(5).length,
        ),
      );
    }
  }
}
