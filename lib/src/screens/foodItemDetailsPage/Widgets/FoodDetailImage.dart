import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';

//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodDetailImage extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  FoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {



    return
      Container(

        // color:Colors.blueGrey,
        height: displayHeight(context)/2.3,
        // height: displayWidth(context)/2,
        child: Hero(
          tag: foodItemName,
          // child: NeuCard(
          //   curveType: CurveType.concave,
          //   bevel: 12,
          //   decoration: NeumorphicDecoration(
          //     shape:  BoxShape.circle,
          //   ),
            child: ClipOval(
              clipper: MyClipper22(),
              child: CachedNetworkImage(
                imageUrl: imageURLBig,
                fit: BoxFit.fill,
                placeholder: (context, url) => new CircularProgressIndicator(),
              ),
            ),
          ),
        // ),
      );


  }
}


class MyClipper22 extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(90,260), radius: 251);
    // x= 247 =120, y = 247-255== 8 which are spacs.
    // return Rect.fromCircle(center: Offset(/*50 from top --- (0,0)*/, 270), radius: 240);

  }

  @override
  bool shouldReclip(oldClipper) => false;
}