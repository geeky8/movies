import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movie_details_bloc.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:movies/elements/movie_detail.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/style/theme.dart' as Style;

class MovieInfo extends StatefulWidget {
  final int id;
  MovieInfo({Key key,@required this.id}): super(key: key);
  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;
  _MovieInfoState(this.id);
  @override
  void initState() {
    movieDetails..getMovieDetails(id);
    super.initState();
  }
  @override
  void dispose() {
    movieDetails..drainStream();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
      stream: movieDetails.subject.stream,
      builder: (context,AsyncSnapshot<MovieDetailResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error!=0 && snapshot.data.error.length>0){
            return buildError(snapshot.data.error);
          }
          return _buildInfo(snapshot.data);
        }
        else if(snapshot.hasError){
          return buildError(snapshot.error);
        }
        else{
          return buildLoading();
        }
      },
    );
  }
  Widget _buildInfo(MovieDetailResponse data){
    MovieDetail details = data.movie_detail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                        "BUDGET",
                        style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      details.budget.toString() + "\$",
                      style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "DURATION",
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      details.runTime.toString() + "min",
                      style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "RELEASE DATE",
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      details.releaseDate,
                      style: TextStyle(
                        color: Style.Colors.secondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
        SizedBox(height: 13,),
        Padding(
          padding: const EdgeInsets.only(left: 20,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GENRES",
                style: TextStyle(
                  color: Style.Colors.titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 38,
                padding: EdgeInsets.only(top: 10,),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: details.genres.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 10,),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5),),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: Text(
                            details.genres[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      );
                    },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
