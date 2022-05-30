import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState>{
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()){
    on<OnFetchTopRatedMovie>((event, emit) async{
      emit(TopRatedMovieLoading());

      final movies = await _getTopRatedMovies.execute();
      movies.fold((failure){
        emit(TopRatedMovieError(failure.message));
      }, (moviesData){
        emit(TopRatedMovieHasData(moviesData));
      });
    });
  }
}