import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMovieEvent, NowPlayingMoviesState>{
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(NowPlayingMoviesEmpty()){
    on<OnFetchNowPlayingMovies>((event, emit) async{
      emit(NowPlayingMoviesLoading());

      final movies = await _getNowPlayingMovies.execute();
      movies.fold((failure){
        emit(NowPlayingMoviesError(failure.message));
      }, (moviesData){
        emit(NowPlayingHasData(moviesData));
      });
    });
  }
}