import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tv_series.dart';
import 'package:tvseries/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeries{
  final TvSeriesRepository repository;
  GetWatchlistTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(){
    return repository.getWatchlistTvSeries();
  }
}