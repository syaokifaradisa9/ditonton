import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState>{
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchlistMovies) : super(WatchlistMovieEmpty()){
    on<OnFetchWatchlistMovie>((event, emit) async{
      emit(WatchlistMovieLoading());

      var result = await _getWatchlistMovies.execute();
      result.fold((failure){
        emit(WatchlistMovieError(failure.message));
      }, (moviesData){
        emit(WatchlistMovieHasData(moviesData));
      });
    });
  }
}