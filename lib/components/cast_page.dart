import 'package:flutter/material.dart';
import 'package:movie_app/model/cast_model.dart';

import '../service/api_service.dart';
import 'cast_list_item.dart';

class CastPage extends StatefulWidget {
  final int id;
  final ProgramType type;
  const CastPage({Key? key,required this.id,required this.type}) : super(key: key);

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CastModel> castModel = snapshot.data ?? [];

          return ListView.builder(
            itemBuilder: (context, index) {
              return CastListItem(castModel: castModel[index]);
            },
            itemCount: castModel.length,
            scrollDirection: Axis.horizontal,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      future: apiService.getCastlist(widget.id,widget.type),
    );
  }
}
