import 'package:flutter/material.dart';
import 'package:movie_app/model/tv_model.dart';
import 'package:movie_app/service/api_service.dart';
import 'package:movie_app/ui/tv/tv_category.dart';

import 'components/tv_carusel.dart';

class TVPage extends StatefulWidget {
  const TVPage({Key? key}) : super(key: key);

  @override
  State<TVPage> createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
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
                List<TVModel> tvModel = snapshot.data ?? [];
                return TVCarusel(
                  tvModelList: tvModel,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getTVData(TvType.airingTody),
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
                  "Popular TV",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TvCategory(
                    tvType: TvType.popular,
                  ),
                  height: 200,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Top Rated TV",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TvCategory(
                    tvType: TvType.topRated,
                  ),
                  height: 200,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "On The Air",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TvCategory(
                    tvType: TvType.onTheAir,
                  ),
                   height: 200,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
