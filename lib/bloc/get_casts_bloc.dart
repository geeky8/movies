import 'package:flutter/cupertino.dart';
import 'package:movies/model/cast_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CastListBloc{
  final MovieRepository _repository = MovieRepository();
  BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  getcast(int id) async{
    CastResponse response = await _repository.getCastDetails(id);
    _subject.sink.add(response);
  }
  void drainStream(){_subject.value;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<CastResponse> get subject => _subject;
}

final castBloc = CastListBloc();