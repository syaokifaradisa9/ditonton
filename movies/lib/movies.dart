library movies;

export 'data/datasources/db/database_movie_helper.dart';

export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';

export 'data/repositories/movie_repository_impl.dart';
export 'domain/repositories/movie_repository.dart';

export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/search_movies.dart';
export 'domain/usecases/save_watchlist_movie.dart';
export 'domain/usecases/remove_movie_watchlist.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_movie_status.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_now_playing_movies.dart';

export 'presentation/bloc/now_playing/now_playing_movies_bloc.dart';
export 'presentation/bloc/top_rated/top_rated_movies_bloc.dart';
export 'presentation/bloc/popular/popular_movies_bloc.dart';
export 'presentation/bloc/search/search_movies_bloc.dart';
export 'presentation/bloc/detail/detail_movie_bloc.dart';
export 'presentation/bloc/recommendation/recommendation_movie_bloc.dart';
export 'presentation/bloc/watchlist/watchlist_movies_bloc.dart';
export 'presentation/bloc/watchlist_status/watchlist_movie_status_bloc.dart';

export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/search_movie_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';