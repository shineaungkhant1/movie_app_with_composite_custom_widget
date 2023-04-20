import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {

  late final ActorVO? actor;


  ActorView({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEMS_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(
              actorProfilePath: actor?.profilePath ?? "",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtomView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(actorName: actor?.name ?? ""),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  late final String actorProfilePath;


  ActorImageView({required this.actorProfilePath});

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "$IMAGE_BASE_URL$actorProfilePath",
        fit: BoxFit.cover);
  }
}

class FavouriteButtomView extends StatelessWidget {
  const FavouriteButtomView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  late String actorName;


  ActorNameAndLikeView({required this.actorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            actorName,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Icon(
                  Icons.thumb_up,
                  color: Colors.amber,
                  size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  color: MAIN_HOME_SCREEN_LIST_TITLE_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),

              )
            ],
          ),
        ],
      ),
    );
  }
}
