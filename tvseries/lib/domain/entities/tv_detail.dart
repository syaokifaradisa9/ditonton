import 'package:tvseries/domain/entities/genre.dart';

import 'creator.dart';
import 'last_episode.dart';
import 'network_channel.dart';
import 'season.dart';
import 'spoken_language.dart';
import 'package:equatable/equatable.dart';

import 'production_company.dart';
import 'production_country.dart';

class TvSeriesDetail extends Equatable{
  final int id;
  final String name;
  final String originalName;
  final bool inProduction;
  final List<String> languages;
  final String originLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final String backdropPath;
  final List<Creator> creators;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final String lastAirDate;
  final List<Genre> genres;
  final String homepage;
  final LastEpisode lastEpisode;
  final List<NetworkChannel> networks;
  final int numberOfEpisode;
  final int numberOfSeason;
  final List<String> country;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.originalName,
    required this.languages,
    required this.originLanguage,
    required this.overview,
    required this.posterPath,
    required this.country,
    required this.voteCount,
    required this.voteAverage,
    required this.backdropPath,
    required this.popularity,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.status,
    required this.creators,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.inProduction,
    required this.lastEpisode,
    required this.networks,
    required this.numberOfEpisode,
    required this.numberOfSeason,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.tagline,
    required this.type,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    inProduction,
    languages,
    originLanguage,
    overview,
    popularity,
    posterPath,
    backdropPath,
    creators,
    episodeRunTime,
    firstAirDate,
    lastAirDate,
    genres,
    homepage,
    lastEpisode,
    networks,
    numberOfEpisode,
    numberOfSeason,
    country,
    productionCompanies,
    productionCountries,
    seasons,
    spokenLanguages,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}