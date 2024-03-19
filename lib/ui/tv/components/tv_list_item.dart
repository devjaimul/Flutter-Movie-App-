import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/tv_model.dart';
import 'package:movie_app/ui/tv/tv_details.dart';

import '../../../constants/constants.dart';

class TvListItem extends StatelessWidget {
  final TVModel tvModel;
  const TvListItem({Key? key,required this.tvModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TVDetails(
                  tvModel: tvModel,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: 120,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 140,
                //width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: kmoviedbImageURL + tvModel.posterPath.toString(),
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              tvModel.originalName.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
            ),
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
                SizedBox(width: 5,),
                Text(
                  tvModel.voteAverage == null ? "" : tvModel.voteAverage.toString(),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
