part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable{
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState{}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingHasData extends NowPlayingMoviesState{
  final List<Movie> movies;
  const NowPlayingHasData(this.movies);

  @override
  List<Object> get props => [movies];
}