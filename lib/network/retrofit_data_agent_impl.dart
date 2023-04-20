import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/network/api_constant.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent{

  late TheMovieApi mApi;

  RetrofitDataAgentImpl(){
    final dio= Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  void getNowPlayingMovie(int page) {
   mApi.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
       .then((value) {
     debugPrint("Now Playing Movies ======>  ${value.toString()}");
   }).catchError((error) {
     debugPrint("Error  ======> ${error.toString()}");
   });
  }

}