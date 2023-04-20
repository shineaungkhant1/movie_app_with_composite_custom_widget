import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/widgets/rating_view.dart';

import '../network/api_constant.dart';
import '../resources/dimens.dart';

class MovieView extends StatelessWidget {

  final MovieVO? movie;


  MovieView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.only(right: MARGIN_MEDIUM),
          width: MOVIE_LIST_ITEMS_WIDTH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: MARGIN_MEDIUM),
              Text(
                movie?.title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MARGIN_SMALL),
              Row(
                children: [
                  Text(
                    "8.9",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: MARGIN_MEDIUM),
                  RatingView(),
                ],
              )
            ],
          ),
        ),
      ]
    );
  }
}
