import 'package:flutter/material.dart';

import '../models/category/category_model.dart';
import '../shared/custom_widgets/custom_texts.dart';

class CategoryItemCircle extends StatelessWidget {
  const CategoryItemCircle({Key? key, this.model}) : super(key: key);
  final CategoryItemModel? model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              '${model!.image}',
            ),
          ),
          BodySmallText(
            '${model!.name}',
            maxLines: 1,
            overFlow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
