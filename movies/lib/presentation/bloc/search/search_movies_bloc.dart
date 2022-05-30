import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState>{
  final SearchMovies _searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchMovieBloc(this._searchMovies) : super(SearchMovieEmpty()){
    on<OnQueryMovieChanged>((event, emit) async{
      emit(SearchMovieLoading());

      final movies = await _searchMovies.execute(event.query);
      movies.fold((failure){
        emit(SearchMovieError(failure.message));
      }, (moviesData){
        emit(SearchMovieHasData(moviesData));
      });
    },
    transformer: debounce(const Duration(milliseconds: 500)));
  }
}