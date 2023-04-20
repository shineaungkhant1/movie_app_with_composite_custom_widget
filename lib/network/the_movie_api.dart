
import 'package:dio/dio.dart';
import 'package:movie_app/network/responses/get_actors_response.dart';
import 'package:movie_app/network/responses/get_credits_by_movie_response.dart';
import 'package:movie_app/network/responses/get_genres_response.dart';
import 'package:movie_app/network/responses/get_movies_by_genre_response.dart';
import 'package:movie_app/network/responses/movie_list_response.dart';
import 'package:retrofit/http.dart';
import '../data/vos/movie_vo.dart';
import 'api_constant.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{

  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(END_POINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET(END_POINT_GET_POPULAR)
  Future<MovieListResponse> getPopularMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET(END_POINT_GET_TOP_RATED)
  Future<MovieListResponse> getTopRatedMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET(END_POINT_GET_GENRES)
  Future<GetGenresResponse> getGenres(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );

  @GET(END_POINT_GET_MOVIES_BY_GENRE)
  Future<GetMoviesByGenreResponse> getMoviesByGenres(
      @Query(PARAM_GENRE_ID) String genreId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );

  @GET(END_POINT_GET_ACTORS)
  Future<GetActorsResponse> getActors(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

  @GET('$END_POINT_GET_MOVIE_DETAILS/{movie_id}')
  Future<MovieVO?> getMovieDetails(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      );
  
  @GET("/3/movie/{movie_id}/credits")
  Future<GetCreditsByMovieResponse> getCreditsByMovie(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      );

}