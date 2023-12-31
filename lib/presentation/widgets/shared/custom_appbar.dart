import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Cine en Tiempo Real',
                style: titleStyle,
              ),
              const Spacer(), //Para separar los widgets

              IconButton(
                  onPressed: () {
                    final movieRepository = ref.read(movieRepositoryProvider);

                    showSearch<Movie?>(
                            context: context,
                            delegate: SearchMovieDelegate(
                                searchMovies: movieRepository.searchMovies))
                        .then((movie) {
                      if (movie == null) return;

                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
