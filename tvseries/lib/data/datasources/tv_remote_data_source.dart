import 'dart:convert';
import 'package:core/core.dart';
import 'package:tvseries/data/models/tv_series_model.dart';
import 'package:tvseries/data/models/tv_series_response.dart';
import '../models/tv_series_detail_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource{
  final API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  final BASE_URL = 'https://api.themoviedb.org/3';
  final SLLClient client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')
    );
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if(response.statusCode == 200){
      return TvSeriesDetailResponse.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')
    );

    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }
}