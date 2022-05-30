part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable{
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieEmpty extends DetailMovieState{}

class DetailMovieLoading extends DetailMovieState{}

class DetailMovieHasData extends DetailMovieState{
  final MovieDetail movie;
  const DetailMovieHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class DetailMovieError extends DetailMovieState{
  final String message;
  const DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}