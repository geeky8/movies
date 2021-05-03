import 'package:movies/model/movie_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBloc{
  final MovieRepository _repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovies() async{
    MovieResponse response = await _repository.getPlayingMovie();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingBloc = NowPlayingListBloc();