import 'package:movies/model/genre.dart';
import 'package:movies/widgets/genres_list.dart';

class MovieDetail{
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int runTime;

  MovieDetail(this.id,this.adult,this.budget,this.genres,this.releaseDate,this.runTime);

  MovieDetail.fromJSON(Map<String,dynamic> json):
      id = json["id"],
      adult = json["adult"],
      budget = json["budget"],
      genres = (json["genres"] as List).map((e) => Genre.fromJSON(e)).toList(),
      releaseDate = json["release_date"],
      runTime = json["runtime"];
}