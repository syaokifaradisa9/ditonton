import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/last_episode.dart';

class LastEpisodeModel extends Equatable{
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;
  final String airDate;
  final int episodeNumber;

  const LastEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.airDate,
    required this.voteCount,
    required this.voteAverage,
    required this.episodeNumber,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
  });

  factory LastEpisodeModel.fromJson(Map<String, dynamic> json) => LastEpisodeModel(
    id: json['id'],
    airDate: json['air_date'],
    episodeNumber: json['episode_number'],
    name: json['name'],
    overview: json['overview'],
    productionCode: json['production_code'],
    seasonNumber: json['season_number'],
    stillPath: json['still_path'] ?? '',
    voteAverage: json['vote_average'].toDouble(),
    voteCount: json['vote_count']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'air_date': airDate,
    'episode_number': episodeNumber,
    'name': name,
    'overview': overview,
    'production_code': productionCode,
    'season_number': seasonNumber,
    'still_path': stillPath,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };

  LastEpisode toEntity() => LastEpisode(
      id: id,
      name: name,
      overview: overview,
      airDate: airDate,
      voteCount: voteCount,
      voteAverage: voteAverage,
      episodeNumber: episodeNumber,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath
  );

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    airDate,
    voteCount,
    voteAverage,
    episodeNumber,
    productionCode,
    seasonNumber,
    stillPath,
  ];
}