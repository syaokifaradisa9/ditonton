import 'package:equatable/equatable.dart';

class Season extends Equatable{
  final int id;
  final String name;
  final String posterPath;
  final String airDate;
  final String overview;
  final int episodeCount;
  final int seasonNumber;

  const Season({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.overview,
    required this.airDate,
    required this.episodeCount,
  });

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