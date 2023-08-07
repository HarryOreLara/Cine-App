import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDataSource{

  Future<List<Movie>> getNowPlay({int page = 1});


}