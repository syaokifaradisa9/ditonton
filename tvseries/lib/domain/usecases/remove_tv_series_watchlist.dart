import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class RemoveTvSeriesWatchlist {
  final TvSeriesRepository repository;
  RemoveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeriesDetail) {
    return repository.removeWatchList(tvSeriesDetail);
  }
}
