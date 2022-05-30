import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class SaveTvSeriesWatchlist{
  final TvSeriesRepository repository;
  SaveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries){
    return repository.saveWatchList(tvSeries);
  }
}