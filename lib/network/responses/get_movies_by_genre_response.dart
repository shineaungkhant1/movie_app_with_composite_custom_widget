import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

part 'get_movies_by_genre_response.g.dart';

@JsonSerializable()
class GetMoviesByGenreResponse{

  @JsonKey(name: "results")
  List<MovieVO>? results;


  GetMoviesByGenreResponse(this.results);

  factory GetMoviesByGenreResponse.fromJson(Map<String,dynamic> json) => _$GetMoviesByGenreResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetMoviesByGenreResponseToJson(this);
}