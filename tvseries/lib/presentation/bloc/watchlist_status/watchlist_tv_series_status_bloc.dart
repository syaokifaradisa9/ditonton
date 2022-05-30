import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tvseries/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tv_series.dart';

part 'watchlist_tv_series_status_event.dart';
part 'watchlist_tv_series_status_state.dart';

class WatchlistTvSeriesStatusBloc extends Bloc<WatchlistTvSeriesStatusEvent, WatchlistTvSeriesStatusState>{
  final GetWatchListTvSeriesStatus _getWatchListTvSeriesStatus;
  final SaveTvSeriesWatchlist _saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist _removeTvSeriesWatchlist;

  WatchlistTvSeriesStatusBloc(
      this._saveTvSeriesWatchlist,
      this._removeTvSeriesWatchlist,
      this._getWatchListTvSeriesStatus
  ) : super(WatchlistTvSeriesStatusEmpty()){

    on<OnFetchWatchlistStatus>((event, emit) async{
      emit(WatchlistTvSeriesStatusLoading());

      final isAddedToWatchlist = await _getWatchListTvSeriesStatus.execute(
        event.id
      );
      emit(WatchlistTvSeriesStatusHasData(
        isAdded: isAddedToWatchlist,
        message: ''
      ));
    });

    on<OnAddedToWatchlist>((event, emit) async{
      emit(WatchlistTvSeriesStatusLoading());

      final result = await _saveTvSeriesWatchlist.execute(event.tvSeries);

      await result.fold((failure) async {
        emit(WatchlistTvSeriesStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListTvSeriesStatus.execute(
          event.tvSeries.id
        );

        emit(WatchlistTvSeriesStatusHasData(
            isAdded: isAddedToWatchlist,
            message: successMessage
        ));
      });
    });

    on<OnRemoveFromWatchList>((event, emit) async{
      emit(WatchlistTvSeriesStatusLoading());

      final result = await _removeTvSeriesWatchlist.execute(event.tvSeries);

      await result.fold((failure) async {
        emit(WatchlistTvSeriesStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListTvSeriesStatus.execute(
          event.tvSeries.id
        );
        emit(WatchlistTvSeriesStatusHasData(
          isAdded: isAddedToWatchlist,
          message: successMessage
        ));
      });
    });
  }
}