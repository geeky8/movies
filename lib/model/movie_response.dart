import 'package:movies/model/movie.dart';

class MovieResponse{
  final List<Movie> movies;
  final String error;
  final num results;

  MovieResponse(this.movies,this.error,this.results);

  MovieResponse.fromJSON(Map<String,dynamic> json):
      movies = (json["results"] as List).map((e) => Movie.fromJson(e)).toList(),
      error = "",
      results = json["total_results"];
  MovieResponse.withError(String errorValue):
      movies = [],
      error = errorValue,
      results = 0;
}