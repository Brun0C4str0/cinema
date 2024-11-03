import 'package:dartz/dartz.dart';
import 'package:src/errors/movie_error.dart';
import 'package:src/models/movie_detail_model.dart';
import 'package:src/repositories/movie_repository.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieDetailModel? movieDetail;
  MovieError? movieError;

  bool loading = true;

  // define um metodo assincrono que busca os detalhes de um filme pela ID
  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    movieError = null;
    final result = await _repository.fetchMovieById(id);
    result.fold(
            (error) => movieError = error, (detail) => movieDetail = detail);
    return result;
  }
}
