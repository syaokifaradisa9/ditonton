part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMovieEvent extends Equatable{
  const NowPlayingMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowPlayingMovies extends NowPlayingMovieEvent{}