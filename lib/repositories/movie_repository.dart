import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:src/core/api.dart';
import 'package:src/errors/movie_error.dart';
import 'package:src/models/movie_detail_model.dart';
import 'package:src/models/movie_response_model.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOptions);

  Future<Either<MovieError, MovieResponseModel>> fetchAllMovies(
      int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieResponseModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_message']!));
      } else {
        return Left(MovieRepositoryError(KServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final model = MovieDetailModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response!.data['status_massage']));
      } else {
        return Left(MovieRepositoryError(KServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}