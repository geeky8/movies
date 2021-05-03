import 'package:dio/dio.dart';
import 'package:movies/elements/movie_detail.dart';
import 'package:movies/model/cast_response.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/model/person_response.dart';
import 'package:movies/model/video_response.dart';

class MovieRepository {
  final String apiKey = "5851e4b364586234092a0c69f792c6dd";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      print(response.data.runtimeType);
      return MovieResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieResponse> getPlayingMovie() async {
    var params = {"api_key": apiKey, "language": "en-IN", "page": 1};
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return MovieResponse.withError(error);
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "en-IN", "page": 1};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return GenreResponse.withError(error);
    }
  }

  Future<PersonResponse> getPerson() async {
    var params = {"api_key": apiKey};
    try {
      Response response = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return PersonResponse.withError(error);
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-IN",
      "page": 1,
      "with_genres": id
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieDetailResponse> getMovieDetails(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-IN"
    };
    try {
      Response response =
      await _dio.get(movieUrl + "/${id}", queryParameters: params);
      return MovieDetailResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return MovieDetailResponse.withError(error);
    }
  }

  Future<CastResponse> getCastDetails(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-IN"
    };
    try {
      Response response =
      await _dio.get(movieUrl + "/${id}" + "/credits", queryParameters: params);
      return CastResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return CastResponse.withError(error);
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-IN"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMoviesVideos(int id) async{
    var params = {
      "api_key": apiKey,
      "language": "en-IN"
    };
    try {
      Response response =
      await _dio.get(movieUrl + "/${id}" + "/videos", queryParameters: params);
      return VideoResponse.fromJSON(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return VideoResponse.withError(error);
    }
  }
}
