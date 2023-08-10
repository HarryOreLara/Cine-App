import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();
  @override
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends ConsumerState<_HomeView> {


  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProviders.notifier).loadNexPage();
    ref.read(popularMoviesProvider.notifier).loadNexPage();
    ref.read(upcomingMoviesProvider.notifier).loadNexPage();
    ref.read(topRatedMoviesProvider.notifier).loadNexPage();

    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProviders);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upcomingMoviesProvider);


    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideshow(movies: slideShowMovies),

              MovieHorizonalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes 20',
                loadNexPage: () {
                  ref.read(nowPlayingMoviesProviders.notifier).loadNexPage();
                },
              ),
              MovieHorizonalListview(
                movies: upComingMovies,
                title: 'Proximamente',
                subTitle: 'Este mes',
                loadNexPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNexPage();
                },
              ),
              MovieHorizonalListview(
                movies: popularMovies,
                title: 'Populares',
                // subTitle: 'En este mes',
                loadNexPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNexPage();
                },
              ),
              MovieHorizonalListview(
                movies: topRatedMovies,
                title: 'Mejor calificadas',
                subTitle: 'De siempre',
                loadNexPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNexPage();
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1),
      )
    ]);
  }
}
