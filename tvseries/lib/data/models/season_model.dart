import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/season.dart';

class SeasonModel extends Equatable{
  final int id;
  final String name;
  final String posterPath;
  final String airDate;
  final String overview;
  final int episodeCount;
  final int seasonNumber;

  const SeasonModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.overview,
    required this.airDate,
    required this.episodeCount,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    id: json['id'],
    name: json['name'],
    seasonNumber: json['season_number'],
    overview: json['overview'],
    airDate: json['air_date'] ?? '-',
    episodeCount: json['episode_count'],
    posterPath: json['poster_path'] ?? '-',
  );

  Map<String, dynamic> toJson() => {
    'air_date': airDate,
    'episode_count': episodeCount,
    'id': id,
    'name': name,
    'overview': overview,
    'poster_path': posterPath,
    'season_number': seasonNumber,
  };

  Season toEntity() => Season(
    id: id,
    name: name,
    posterPath: posterPath,
    seasonNumber: seasonNumber,
    overview: overview,
    airDate: airDate,
    episodeCount: episodeCount
  );

  @override
  List<Object?> get props => [
    id,
    name,
    seasonNumber,
    overview,
    airDate,
    episodeCount,
    posterPath,
  ];
}