part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesDetail extends DetailTvSeriesEvent {
  final int id;
  const OnFetchTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}