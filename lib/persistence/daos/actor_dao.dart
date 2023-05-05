import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

abstract class ActorDao {

  void saveAllActors(List<ActorVO> actorList);
  List<ActorVO> getAllActors();

}

