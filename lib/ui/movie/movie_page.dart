import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/service/api_service.dart';
import 'package:movie_app/ui/movie/movies_category.dart';

import '../../constants/constants.dart';
import '../../model/movie_model.dart';
import 'components/movie_carousel.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MovieModel> moviemodel = snapshot.data ?? [];
                return MovieCarosel(movieModellist: moviemodel);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getMovieData(MovieType.nowPlaying),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    "Popular Movie",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: MoviesCategory(
                      movieType: MovieType.popular,
                    ),
                    height: 200,
                  ),
                  Text(
                    "Top Rated Movie",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: MoviesCategory(
                      movieType: MovieType.topRated,
                    ),
                    height: 200,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Upcoming Movie",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: MoviesCategory(
                      movieType: MovieType.upcoming,
                    ),
                    height: 200,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
