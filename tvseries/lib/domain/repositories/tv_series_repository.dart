import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_series.dart';

abstract class TvSeriesRepository{
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);

  Future<Either<Failure, String>> saveWatchList(TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchList(TvSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}