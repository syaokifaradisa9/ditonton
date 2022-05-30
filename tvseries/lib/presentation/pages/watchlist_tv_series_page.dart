import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<WatchlistTvSeriesBloc>(context).add(
      OnFetchWatchlistTvSeries()
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() => BlocProvider.of<WatchlistTvSeriesBloc>(context).add(
      OnFetchWatchlistTvSeries()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
            builder: (context, state){
              if(state is WatchlistTvSeriesHasData){
                return ListView.builder(
                    itemCount: state.tvSeries.length,
                    itemBuilder: (context, index) {
                      final tvSeries = state.tvSeries[index];
                      return TvSeriesCard(tvSeries);
                    }
                );
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            }
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
