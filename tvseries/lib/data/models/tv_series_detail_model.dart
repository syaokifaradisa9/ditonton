import 'package:equatable/equatable.dart';
import 'package:tvseries/data/models/creator_model.dart';
import 'package:tvseries/data/models/genre_model.dart';
import 'package:tvseries/data/models/last_episode_model.dart';
import 'package:tvseries/data/models/network_channel_model.dart';
import 'package:tvseries/data/models/production_country_model.dart';
import 'package:tvseries/data/models/season_model.dart';
import 'package:tvseries/data/models/spoken_language_model.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';

import 'production_company_model.dart';
class TvSeriesDetailResponse extends Equatable{
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
  final List<CreatorModel> creators;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final String lastAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final LastEpisodeModel lastEpisode;
  final List<NetworkChannelModel> networks;
  final int numberOfEpisode;
  final int numberOfSeason;
  final List<String> country;
  final List<ProductionCompanyModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final List<SeasonModel> seasons;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvSeriesDetailResponse({
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

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) => TvSeriesDetailResponse(
    id: json['id'],
    name: json['name'],
    originalName: json['original_name'],
    inProduction: json['in_production'],
    languages: List<String>.from(json['languages'].map((x) => x)),
    backdropPath: json['backdrop_path'] ?? '',
    creators: List<CreatorModel>.from(json['created_by'].map(
      (x) => CreatorModel.fromJson(x))
    ),
    episodeRunTime: List<int>.from(json['episode_run_time'].map((x) => x)),
    firstAirDate: json['first_air_date'],
    lastAirDate: json['last_air_date'],
    genres: List<GenreModel>.from(json['genres'].map(
      (x) => GenreModel.fromJson(x))
    ),
    homepage: json['homepage'],
    lastEpisode: LastEpisodeModel.fromJson(json['last_episode_to_air']),
    networks: List<NetworkChannelModel>.from(json['networks'].map(
      (x) => NetworkChannelModel.fromJson(x))
    ),
    numberOfEpisode: json['number_of_episodes'],
    numberOfSeason: json['number_of_seasons'],
    country: List<String>.from(json['origin_country'].map((x) => x)),
    originLanguage: json['original_language'],
    overview: json['overview'],
    popularity: json['popularity'].toDouble(),
    posterPath: json['poster_path'] ?? '',
    productionCompanies: List<ProductionCompanyModel>.from(
      json['production_companies'].map((x) => ProductionCompanyModel.fromJson(x))
    ),
    productionCountries: List<ProductionCountryModel>.from(
      json['production_countries'].map((x) => ProductionCountryModel.fromJson(x))
    ),
    seasons: List<SeasonModel>.from(json['seasons'].map(
      (x) => SeasonModel.fromJson(x))
    ),
    spokenLanguages: List<SpokenLanguageModel>.from(
        json['spoken_language'] != null ?
          json['spoken_language'].map((x) => SpokenLanguageModel.fromJson(x)) :
            List<SpokenLanguageModel>.from([])
    ),
    status: json['status'],
    voteCount: json['vote_count'],
    voteAverage: json['vote_average'].toDouble(),
    tagline: json['tagline'],
    type: json['type']
  );

  Map<String, dynamic> toJson() => {
    'backdrop_path': backdropPath,
    'created_by': List<dynamic>.from(creators.map((x) => x.toJson())),
    'episode_run_time': List<int>.from(episodeRunTime.map((x) => x)),
    'first_air_date': firstAirDate,
    'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
    'homepage': homepage,
    'id': id,
    'in_production': inProduction,
    'languages': List<dynamic>.from(languages.map((x) => x)),
    'last_air_date': lastAirDate,
    'last_episode_to_air': lastEpisode.toJson(),
    'name': name,
    'networks': List<dynamic>.from(networks.map((x) => x.toJson())),
    'number_of_episodes': numberOfEpisode,
    'number_of_season': numberOfSeason,
    'origin_country': List<dynamic>.from(country.map((x) => x)),
    'original_language': originLanguage,
    'original_name': originalName,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'production_companies': List<dynamic>.from(
      productionCompanies.map((x) => x.toJson())
    ),
    'production_countries': List<dynamic>.from(
      productionCountries.map((x) => x.toJson())
    ),
    'seasons': List<dynamic>.from(seasons.map((x) => x.toJson())),
    'spoken_languages': List<dynamic>.from(
      spokenLanguages.map((x) => x.toJson())
    ),
    'status': status,
    'tagline': tagline,
    'type': type,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };

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

  TvSeriesDetail toEntity() => TvSeriesDetail(
      id: id,
      name: name,
      originalName: originalName,
      languages: languages,
      originLanguage: originLanguage,
      overview: overview,
      posterPath: posterPath,
      country: country,
      voteCount: voteCount,
      voteAverage: voteAverage,
      backdropPath: backdropPath,
      popularity: popularity,
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
      status: status,
      creators: creators.map((creator) => creator.toEntity()).toList(),
      episodeRunTime: episodeRunTime,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      inProduction: inProduction,
      lastEpisode: lastEpisode.toEntity(),
      networks: networks.map((network) => network.toEntity()).toList(),
      numberOfEpisode: numberOfEpisode,
      numberOfSeason: numberOfSeason,
      productionCompanies: productionCompanies.map(
          (company) => company.toEntity()
      ).toList(),
      productionCountries: productionCountries.map(
        (country) => country.toEntity()
      ).toList(),
      seasons: seasons.map(
        (season) => season.toEntity()
      ).toList(),
      spokenLanguages: spokenLanguages.map(
        (language) => language.toEntity()
      ).toList(),
      tagline: tagline,
      type: type
  );
}