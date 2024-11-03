import 'package:dartz/dartz.dart';
import 'package:src/errors/movie_error.dart';
import 'package:src/models/movie_model.dart';
import 'package:src/models/movie_response_model.dart';
import 'package:src/repositories/movie_repository.dart';

class MovieController {
  // instancia responsavel por obter dados sobre filmes
  final _repository = MovieRepository();

  MovieResponseModel? movieResponseModel; // modelo que contem a resposta de filmes
  MovieError? movieError;                 // modelo para representar erros
  bool loading = true;                    // indica que os dados estao sendo carregados

  List<MovieModel> get movies => movieResponseModel?.movies ?? <MovieModel>[];

  int get moviesCount => movies.length; // retorna a quantidade de filmes na lista
  bool get hasMovies => moviesCount != 0; // verifica se a filmes na lista, retornando moviesCount se for diferente de 0
  int get totalPages => movieResponseModel?.totalPages ?? 1; // getter que retorna o total de paginas de filmes
  int get currentPage => movieResponseModel?.page ?? 1; 

  // declara um metodo assincrono fetchAllMovies, usa Either para retornar um erro ou uma pagina de resposta de filme
  Future<Either<MovieError, MovieResponseModel>> fetchAllMovies(
      {int page = 1}) async {
    movieError = null;
    final result = await _repository.fetchAllMovies(page);
    result.fold(
          (error) => movieError = error,
          (movie) {
        if (movieResponseModel == null) {
          movieResponseModel = movie;
        } else {
          movieResponseModel!.page = movie.page;
          movieResponseModel!.movies!.addAll(movie.movies as List<MovieModel>);
        }
      },
    );
    return result;
  }
}
