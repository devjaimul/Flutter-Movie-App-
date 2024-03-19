import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/tv_model.dart';
import 'package:movie_app/ui/tv/tv_category.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/cast_page.dart';
import '../../constants/constants.dart';
import '../../model/video_model.dart';
import '../../service/api_service.dart';

class TVDetails extends StatelessWidget {
  final TVModel tvModel;

  const TVDetails({Key? key, required this.tvModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(tvModel.originalName.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: kmoviedbImageURL + tvModel.posterPath.toString(),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];

                        if(videos.isNotEmpty) {
                          return CircleAvatar(
                            child: IconButton(
                              icon: Icon(
                                Icons.play_circle,
                              ),
                              onPressed: () async {
                                if (videos.isNotEmpty) {
                                  if (!await launchUrl(Uri.parse(
                                      'https://www.youtube.com/embed/${videos[0]
                                          .key}'))) {
                                    throw Exception(
                                        'Could not launch ${videos[0].key}');
                                  }
                                }
                              },
                            ),
                          );
                        }
                      }
                      return Container();
                    },
                    future: apiService.getVideo(tvModel.id ?? 0, ProgramType.tv),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                tvModel.originalName.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: tvModel.voteAverage ?? 0,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        tvModel.voteAverage == null
                            ? ""
                            : tvModel.voteAverage.toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    "Released: " + tvModel.firstAirDate.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                tvModel.overview.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),

              SizedBox(
                height: 10,
              ),

              Text(
                "Cast",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                child: CastPage(
                  id: tvModel.id ?? 0,
                  type: ProgramType.tv,
                ),
                height: 200,
              ),
              Text(
                "Similar Program",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                child: TvCategory(
                  tvType: TvType.similar,
                  tvID: tvModel.id ?? 0,
                ),
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
