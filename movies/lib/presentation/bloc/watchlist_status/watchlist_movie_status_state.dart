part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusState extends Equatable{
  const WatchlistMovieStatusState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieStatusEmpty extends WatchlistMovieStatusState{}

class WatchlistMovieStatusLoading extends WatchlistMovieStatusState{}

class WatchlistMovieStatusError extends WatchlistMovieStatusState{
  final String message;
  const WatchlistMovieStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieStatusHasData extends WatchlistMovieStatusState{
  bool isAdded;
  String message;
  WatchlistMovieStatusHasData({required this.isAdded, required this.message});

  @override
  List<Object> get props => [isAdded, message];
}