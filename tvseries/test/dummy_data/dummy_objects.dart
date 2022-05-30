import 'package:tvseries/data/models/tv_series_table.dart';
import 'package:tvseries/domain/entities/creator.dart';
import 'package:tvseries/domain/entities/genre.dart';
import 'package:tvseries/domain/entities/last_episode.dart';
import 'package:tvseries/domain/entities/network_channel.dart';
import 'package:tvseries/domain/entities/production_company.dart';
import 'package:tvseries/domain/entities/production_country.dart';
import 'package:tvseries/domain/entities/season.dart';
import 'package:tvseries/domain/entities/spoken_language.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/entities/tv_series.dart';

final testTvSeries = TvSeries(
    id: 1,
    name: 'name',
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['originCountry'],
    genreIds: [1],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    popularity: 1,
    voteAverage: 1,
    voteCount: 1,
    posterPath: 'posterPath',
    backdropPath: 'backdropPath'
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesTable =  const TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview'
);

final testMovieTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'poster_path': 'posterPath',
  'overview': 'overview',
};

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    country: ['country'],
    creators: [
      const Creator(
          id: 1,
          creditId: "creditId",
          name: 'name',
          gender: 1,
          profilePath: 'profilePath'
      )
    ],
    episodeRunTime: [1, 2, 3],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: ['language'],
    lastAirDate: 'lastAirDate',
    lastEpisode: const LastEpisode(
        id: 1,
        airDate: 'airDate',
        episodeNumber: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1
    ),
    voteCount: 1,
    voteAverage: 1,
    overview: 'overview',
    name: 'name',
    networks: [
      const NetworkChannel(
          id: 1, name: 'name', country: 'country', logoPath: 'logoPath')
    ],
    numberOfEpisode: 1,
    numberOfSeason: 1,
    originalName: 'originamName',
    originLanguage: 'originLanguage',
    popularity: 1,
    posterPath: 'posterPath',
    productionCompanies: [
      const ProductionCompany(
          id: 'id', name: 'name', country: 'country', logoPath: 'logoPath')
    ],
    productionCountries: [const ProductionCountry(code: 'code', name: 'name')],
    seasons: [
      const Season(
          id: 1, name: 'name', posterPath: 'posterPath',
          seasonNumber: 1, overview: 'overview', airDate: 'airDate',
          episodeCount: 1)
    ],
    spokenLanguages: [
      const SpokenLanguage(
          name: 'name', code: 'code', englishName: 'englishName')
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type'
);