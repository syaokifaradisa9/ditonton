part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends DetailMovieEvent {
  final int id;
  const OnFetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}