import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_country_vo.dart';
import 'package:movie_app/data/vos/spoken_language_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO,adapterName: "MovieVOAdapter")
class MovieVO{

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name:"backdrop_path")
  @HiveField(1)
  String? backDropPath;

  @JsonKey(name:"genre_ids" )
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(3)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(4)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(5)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(6)
  String? homePage;

  @JsonKey(name:"id" )
  @HiveField(7)
  int? id;

  @JsonKey(name: "imdb_id")
  @HiveField(8)
  String? imdbId;

  @JsonKey(name: "original_language")
  @HiveField(9)
  String? originalLanguage;

  @JsonKey(name:"original_title")
  @HiveField(10)
  String? originalTitle;

  @JsonKey(name:"overview")
  @HiveField(11)
  String? overView;

  @JsonKey(name:"popularity")
  @HiveField(12)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(13)
  String? posterPath;

  @JsonKey(name: "production_companies")
  @HiveField(14)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(15)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(16)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(17)
  int? runtime;

  @JsonKey(name:"release_date")
  @HiveField(18)
  String? releaseDate;

  @JsonKey(name: "spoken_languages")
  @HiveField(19)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(20)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(21)
  String? tagLine;

  @JsonKey(name:"title")
  @HiveField(22)
  String? title;

  @JsonKey(name:"video")
  @HiveField(23)
  bool? video;

  @JsonKey(name:"vote_average")
  @HiveField(24)
  double? voteAverage;

  @JsonKey(name:"vote_count")
  @HiveField(25)
  int? voteCount;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;


  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overView,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runtime,
      this.releaseDate,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.isNowPlaying,
      this.isPopular,
      this.isTopRated);

  factory MovieVO.fromJson(Map<String,dynamic> json) => _$MovieVOFromJson(json);

  Map<String,dynamic> toJson() => _$MovieVOToJson(this);

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }
  String getGenreListAsCommaSeparatedString(){
    return genres?.map((genre) => genre.name ?? "").toList().join(",") ?? "";
  }

  String getProductionCountriesAsComaSeparatedString(){
    return productionCountries
        ?.map((country) => country.name ?? "")
        .toList()
        .join(",") ??
    "";
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overView: $overView, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }


}