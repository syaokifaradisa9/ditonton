import 'package:mockito/annotations.dart';
import 'package:tvseries/data/datasources/db/database_tv_series_helper.dart';
import 'package:tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:tvseries/data/datasources/tv_series_local_data_source.dart';
import 'package:tvseries/domain/repositories/tv_series_repository.dart';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  TvSeriesDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SLLClient>(as: #MockSSLClient),
])
void main() {}
