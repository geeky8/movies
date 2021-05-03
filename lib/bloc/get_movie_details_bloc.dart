import 'package:flutter/material.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc{
  final MovieRepository _repository = MovieRepository();
  BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();

  getMovieDetails(int id) async{
    MovieDetailResponse response = await _repository.getMovieDetails(id);
    _subject.sink.add(response);
  }
  void drainStream(){_subject.value;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetails = MovieDetailBloc();