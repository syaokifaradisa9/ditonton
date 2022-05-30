import 'package:equatable/equatable.dart';

class LastEpisode extends Equatable{
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

  const LastEpisode({
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