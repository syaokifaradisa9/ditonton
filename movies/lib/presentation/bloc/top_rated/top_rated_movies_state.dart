part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMovieState extends Equatable{
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieEmpty extends TopRatedMovieState{}

class TopRatedMovieLoading extends TopRatedMovieState{}

class TopRatedMovieHasData extends TopRatedMovieState{
  final List<Movie> topRatedMovies;
  const TopRatedMovieHasData(this.topRatedMovies);

  @override
  List<Object> get props => [topRatedMovies];
}

class TopRatedMovieError extends TopRatedMovieState{
  final String message;
  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}