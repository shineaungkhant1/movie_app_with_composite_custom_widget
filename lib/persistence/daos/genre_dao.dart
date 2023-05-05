import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

abstract class GenreDao{
  void saveAllGenres(List<GenreVO> genreList);
  List<GenreVO> getAllGenres();


}