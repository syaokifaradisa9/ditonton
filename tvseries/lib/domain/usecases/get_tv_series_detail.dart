import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesDetail{
  final TvSeriesRepository repository;
  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id){
    return repository.getDetailTvSeries(id);
  }
}