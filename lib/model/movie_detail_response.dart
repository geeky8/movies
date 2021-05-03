import 'package:movies/elements/movie_detail.dart';

class MovieDetailResponse{
  final MovieDetail movie_detail;
  final String error;

  MovieDetailResponse(this.movie_detail,this.error);

  MovieDetailResponse.fromJSON(Map<String,dynamic> json):
        movie_detail = MovieDetail.fromJSON(json),
        error = "";
  MovieDetailResponse.withError(String errorValue):
        movie_detail = MovieDetail(null, null, null, null, "", null),
        error = errorValue;
}