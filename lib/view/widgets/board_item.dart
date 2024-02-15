import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import 'package:shoppy/res/styles/colors.dart';

import '../../models/home/on_boarding_model.dart';

class BoardItem extends StatelessWidget {
  final BoardingModel model;
  const BoardItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleLargeText(model.title,
                color: Colors.black54,
                maxLines: 3,
                shadow: const [
                  Shadow(
                      // bottomLeft
                      offset: Offset(2, 0),
                      color: primaryColor,
                      blurRadius: 5),
                  Shadow(
                      // bottomLeft
                      offset: Offset(0, 0),
                      color: secColor,
                      blurRadius: 5),
                ]),
          ),
          Expanded(
            child: Stack(
              //fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 100,
                        color: Color(0xff9EB7E5),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  model.img,
                  fit: BoxFit.fitWidth,
                  //height: 400,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
