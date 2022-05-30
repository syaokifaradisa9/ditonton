import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movies/domain/usecases/remove_movie_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist_movie.dart';

part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchlistMovieStatusBloc extends Bloc<WatchlistMovieStatusEvent, WatchlistMovieStatusState>{
  final GetWatchListMovieStatus _getWatchListMovieStatus;
  final SaveMovieWatchlist _saveMovieWatchlist;
  final RemoveMovieWatchlist _removeMovieWatchlist;

  WatchlistMovieStatusBloc(
      this._saveMovieWatchlist,
      this._removeMovieWatchlist,
      this._getWatchListMovieStatus
  ) : super(WatchlistMovieStatusEmpty()){

    on<OnFetchWatchlistStatus>((event, emit) async{
      emit(WatchlistMovieStatusLoading());

      final isAddedToWatchlist = await _getWatchListMovieStatus.execute(event.id);
      emit(WatchlistMovieStatusHasData(
        isAdded: isAddedToWatchlist,
        message: ''
      ));
    });

    on<OnAddedToWatchlist>((event, emit) async{
      emit(WatchlistMovieStatusLoading());

      final result = await _saveMovieWatchlist.execute(event.movie);

      await result.fold((failure) async {
        emit(WatchlistMovieStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListMovieStatus.execute(
          event.movie.id
        );

        emit(WatchlistMovieStatusHasData(
            isAdded: isAddedToWatchlist,
            message: successMessage
        ));
      });
    });

    on<OnRemoveFromWatchList>((event, emit) async{
      emit(WatchlistMovieStatusLoading());

      final result = await _removeMovieWatchlist.execute(event.movie);

      await result.fold((failure) async {
        emit(WatchlistMovieStatusError(failure.message));
      }, (successMessage) async {
        final isAddedToWatchlist = await _getWatchListMovieStatus.execute(
          event.movie.id
        );
        emit(WatchlistMovieStatusHasData(
          isAdded: isAddedToWatchlist,
          message: successMessage
        ));
      });
    });
  }
}