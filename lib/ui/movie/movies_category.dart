import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/api_service.dart';

import '../../constants/constants.dart';
import 'components/movie_list_item.dart';

class MoviesCategory extends StatefulWidget {

  final MovieType movieType;
  final int movieID;

  const MoviesCategory({Key? key,required this.movieType,this.movieID = 0}) : super(key: key);

  @override
  State<MoviesCategory> createState() => _MoviesCategoryState();
}

class _MoviesCategoryState extends State<MoviesCategory> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieModel> moviemodel = snapshot.data ?? [];

          return ListView.builder(
            itemBuilder: (context, index) {
              return MovieListItem(movieModel: moviemodel[index]);
            },
            itemCount: moviemodel.length,
            scrollDirection: Axis.horizontal,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      future: apiService.getMovieData(widget.movieType,movieID: widget.movieID),
    );
  }
}