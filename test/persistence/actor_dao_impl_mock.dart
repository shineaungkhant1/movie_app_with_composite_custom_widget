import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';

class ActorDaoImplMock extends ActorDao{
  Map<int,ActorVO> actorListFromDatabaseMock = {};

  @override
  List<ActorVO> getAllActors() {
   return actorListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    actorList.forEach((actor) {
      actorListFromDatabaseMock[actor.id??0] = actor;
    });
  }


}