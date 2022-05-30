library tvseries;

export 'data/datasources/db/database_tv_series_helper.dart';

export 'data/datasources/tv_remote_data_source.dart';
export 'data/datasources/tv_series_local_data_source.dart';

export 'data/repositories/tv_series_repository_impl.dart';
export 'domain/repositories/tv_series_repository.dart';

// Usecase
export 'domain/usecases/search_tv_series.dart';
export 'domain/usecases/save_watchlist_tv_series.dart';
export 'domain/usecases/remove_tv_series_watchlist.dart';
export 'domain/usecases/get_watchlist_tv_series_status.dart';
export 'domain/usecases/get_watchlist_tv_series.dart';
export 'domain/usecases/get_tv_series_recommendations.dart';
export 'domain/usecases/get_tv_series_detail.dart';
export 'domain/usecases/get_top_rated_tv_series.dart';
export 'domain/usecases/get_popular_tv_series.dart';
export 'domain/usecases/get_now_playing_tv_series.dart';

// Bloc
export 'presentation/bloc/detail/detail_tv_series_bloc.dart';
export 'presentation/bloc/now_playing/now_playing_tv_series_bloc.dart';
export 'presentation/bloc/popular/popular_tv_series_bloc.dart';
export 'presentation/bloc/recommendation/recommendation_tv_series_bloc.dart';
export 'presentation/bloc/top_rated/top_rated_tv_series_bloc.dart';
export 'presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
export 'presentation/bloc/watchlist_status/watchlist_tv_series_status_bloc.dart';
export 'presentation/bloc/search/search_tv_series_bloc.dart';

// pages
export 'presentation/pages/home_tv_series_page.dart';
export 'presentation/pages/now_playing_tv_series_page.dart';
export 'presentation/pages/popular_tv_series_page.dart';
export 'presentation/pages/search_tv_series_page.dart';
export 'presentation/pages/top_rated_tv_series_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/watchlist_tv_series_page.dart';