import 'package:movies/model/video.dart';

class VideoResponse{
  final List<Video> videos;
  final String error;

  VideoResponse(this.videos,this.error);

  VideoResponse.fromJSON(Map<String,dynamic> json):
      videos = (json["results"] as List).map((e) => Video.fromJSON(e)).toList(),
      error = "";
  VideoResponse.withError(String errorValue):
        videos = List(),
        error = errorValue;
}