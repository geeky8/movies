import 'package:movies/model/genre.dart';

class GenreResponse{
  final List<Genre> genre;
  final String error;

  GenreResponse(this.genre,this.error);

  GenreResponse.fromJSON(Map<String,dynamic> json):
        genre = (json["genres"] as List).map((e) => Genre.fromJSON(e)).toList(),
        error = "";
  GenreResponse.withError(String errorValue):
        genre = List(),
        error = errorValue;
}