import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/data/models/tv_series_table.dart';
import 'package:tvseries/domain/repositories/tv_series_repository.dart';
import '../datasources/tv_remote_data_source.dart';
import '../datasources/tv_series_local_data_source.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/entities/tv_series.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository{
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id) async {
    try{
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try{
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException{
      return const Left(ServerFailure(''));
    } on SocketException{
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try{
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async{
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchList(TvSeriesDetail tvSeries) async{
    try{
      final result = await localDataSource.removeWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    }on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchList(TvSeriesDetail tvSeries) async{
    try{
      final result = await localDataSource.insertWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    }on DatabaseException catch(e){
      return Left(DatabaseFailure(e.message));
    }catch(e){
      rethrow;
    }
  }
}
