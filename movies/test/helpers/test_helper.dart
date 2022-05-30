import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movies/data/datasources/db/database_movie_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SLLClient>(as: #MockSSLClient),
])
void main() {}
