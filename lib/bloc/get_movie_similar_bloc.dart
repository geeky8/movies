import 'package:flutter/material.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMoviesBloc{
  final MovieRepository _repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getsimilarMovie(int id) async{
    MovieResponse response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }
  void drainStream(){_subject.value;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<MovieResponse> get subject => _subject;
}

final similarMovieBloc = SimilarMoviesBloc();