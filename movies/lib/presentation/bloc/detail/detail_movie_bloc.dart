import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState>{
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()){
    on<OnFetchMovieDetail>((event, emit) async{
      emit(DetailMovieLoading());

      final movies = await _getMovieDetail.execute(event.id);
      movies.fold((failure){
        emit(DetailMovieError(failure.message));
      }, (moviesData){
        emit(DetailMovieHasData(moviesData));
      });
    });
  }
}