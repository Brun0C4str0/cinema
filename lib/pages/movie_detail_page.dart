import 'package:flutter/material.dart';
import 'package:src/controllers/movie_detail.controller.dart';
import 'package:src/widgets/centered_message.dart';
import 'package:src/widgets/centered_progress.dart';
import 'package:src/widgets/chip_date.dart';
import 'package:src/widgets/rate.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}
// sobrescreve o metodo createState(), que cria a instancia do estado associado a este widget

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  // atualiza o estado para indicar que os dados estao sendo carregados
  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovieById(widget.movieId);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller.movieDetail?.title ?? ''),
    );
  }

  // se os dados estao sendo carregados, retorna um widget que exibe um indicador de progresso centralizado
  _buildMovieDetail() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError?.message ?? '');
    }

    return ListView(
      children: [
        _buildCover(),
        _buildStatus(),
        _buildOverview(),
      ],
    );
  }

  _buildOverview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(_controller.movieDetail?.overview ?? '',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  // metodo que constroi a seção de status do filme
  _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Rate(_controller.movieDetail?.voteAverage ?? 0.0),
          ChipDate(date: _controller.movieDetail?.releaseDate),
        ],
      ),
    );
  }

  _buildCover() {
    return Image.network(
      'https://image.tmdb.org/t/p/w500${_controller.movieDetail?.backdropPath}',
    );
  }
}
