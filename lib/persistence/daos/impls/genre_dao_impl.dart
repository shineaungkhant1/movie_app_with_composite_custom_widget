import 'package:hive/hive.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';

import '../../../data/vos/genre_vo.dart';
import '../../hive_constants.dart';

class GenreDaoImpl extends GenreDao{

  static final GenreDaoImpl _singleton = GenreDaoImpl._internal();

  factory GenreDaoImpl() {
    return _singleton;
  }

  GenreDaoImpl._internal();

  @override
  void saveAllGenres(List<GenreVO> genreList) async {
    Map<int, GenreVO> genreMap = Map.fromIterable(genreList,
        key: (genre) => genre.id, value: (genre) => genre);
    await getGenreBox().putAll(genreMap);
  }

  @override
  List<GenreVO> getAllGenres() {
    return getGenreBox().values.toList();
  }


  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }

}