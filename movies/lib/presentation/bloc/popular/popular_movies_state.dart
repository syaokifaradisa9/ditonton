part of 'popular_movies_bloc.dart';

abstract class PopularMovieState extends Equatable{
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieEmpty extends PopularMovieState{}

class PopularMovieLoading extends PopularMovieState{}

class PopularMovieHasData extends PopularMovieState{
  final List<Movie> popularMovies;
  const PopularMovieHasData(this.popularMovies);

  @override
  List<Object> get props => [popularMovies];
}

class PopularMovieError extends PopularMovieState{
  final String message;
  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}