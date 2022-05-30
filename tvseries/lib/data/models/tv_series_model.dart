import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv_series.dart';

class TvSeriesModel extends Equatable{
  final int id;
  final String name;
  final String overview;
  final String firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalName;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String? posterPath;
  final String? backdropPath;

  const TvSeriesModel({
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

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      firstAirDate: json['first_air_date'],
      originCountry: List<String>.from(json['origin_country'].map((x) => x)),
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      popularity: json['popularity'].toDouble(),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "overview": overview,
    "first_air_date": firstAirDate,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
    'original_language': originalLanguage,
    'original_name': originalName,
    'popularity': popularity,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'poster_path': posterPath,
    'backdrop_path': backdropPath,
  };

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
    backdropPath
  ];

  TvSeries toEntity() => TvSeries(
      id: id,
      name: name,
      overview: overview,
      firstAirDate: firstAirDate,
      originCountry: originCountry,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      originalName: originalName,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      posterPath: posterPath,
      backdropPath: backdropPath
  );
}