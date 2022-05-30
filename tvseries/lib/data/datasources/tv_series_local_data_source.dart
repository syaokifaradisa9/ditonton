import 'package:core/core.dart';
import 'package:tvseries/data/datasources/db/database_tv_series_helper.dart';
import 'package:tvseries/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource{
  Future<String> insertWatchlist(TvSeriesTable tvSeries);
  Future<String> removeWatchlist(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource{
  final TvSeriesDatabaseHelper databaseHelper;
  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async{
    final result = await databaseHelper.getTvSeriesById(id);
    if(result != null){
      return TvSeriesTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvSeriesTable tvSeries) async {
    try{
      await databaseHelper.insertWatchlist(tvSeries);
      return 'Added to Watchlist';
    }catch(e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeries) async {
    try{
      await databaseHelper.removeWatchlist(tvSeries);
      return 'Removed from Watchlist';
    }catch(e){
      throw DatabaseException(e.toString());
    }
  }
}