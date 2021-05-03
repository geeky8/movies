import 'package:movies/model/cast.dart';

class CastResponse{
  final List<Cast> cast;
  final String error;

  CastResponse(this.cast,this.error);

  CastResponse.fromJSON(Map<String,dynamic> json):
        cast = (json["cast"] as List).map((e) => Cast.fromJSON(e)).toList(),
        error = "";
  CastResponse.withError(String errorValue):
        cast = List(),
        error = errorValue;
}