import 'package:equatable/equatable.dart';

class TvSeries extends Equatable{
  int? id;
  String? name;
  String? overview;
  String? firstAirDate;
  List<String>? originCountry;
  List<int>? genreIds;
  String? originalLanguage;
  String? originalName;
  double? popularity;
  double? voteAverage;
  int? voteCount;
  String? posterPath;
  String? backdropPath;

  TvSeries({
    required this.id,
    required this.name,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalName,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.backdropPath,
  });

  TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    firstAirDate,
    originCountry,
    genreIds,
    originalLanguage,
    originalName,
    popularity,
    voteAverage,
    voteCount,
    posterPath,
    backdropPath,
  ];
}