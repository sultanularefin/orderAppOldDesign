


import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodImageInShoppingCart extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  final List<NewIngredient> selectedIngredients;
  final double price;
  final int index;

//  OrderedFoodImageURL,OrderedFoodItemName,selectedIngredients,price
  FoodImageInShoppingCart(
      this.imageURLBig,
      this.foodItemName,
      this.selectedIngredients,
      this.price,
      this.index,
      );

  @override
  Widget build(BuildContext context) {

//    final List<String, dynamic> foodSizePrice = oneFood
//        .sizedFoodPrices;
    if(index==0) {
      return Container(
        color: Color(0xffF4F6CE),
//      height: displayHeight(context)/4,
        height: displayWidth(context) / 3,
        width:displayWidth(context)/5,
        margin: EdgeInsets.fromLTRB(
            0,  0, 12, 0),

//        margin: EdgeInsets.fromLTRB(
//            displayWidth(context)/17, 0, 12, 0),
//      padding: EdgeInsets.fromLTRB(
//          0, 12, 12, 5),


        child: Column(

          children: <Widget>[
            Container(
              child:Row(
                children: <Widget>[


                  Container(
                    width:90,
                    height: 170,
//                  width:displayWidth(context) / 15,
//                    color:Colors.purpleAccent,
//                    color: Colors
                    color: Color(0xffF4F6CE),
                    padding: EdgeInsets.fromLTRB(
                        0, 12, 0, 12),
                    //  child: Card(

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
                    // -displayWidth(context)/9
                    child: Transform.translate(
                      offset: Offset(-displayWidth(context) / 49, 0),
                      // offset (-x,y) =(-50,0) =
                      child:


                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            width: displayWidth(context) / 3,
                            height: displayWidth(context) / 3.5,

                            // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

                            decoration: new BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,

                            child:
                            ClipOval(
                              child: CachedNetworkImage(
                                width: displayWidth(context) / 3,
                                height: displayWidth(context) / 3.5,
                                imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                                fit: BoxFit.fill,
//
                                placeholder: (context,
                                    url) => new CircularProgressIndicator(),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),

                  ),

                  Container(
//                    color:Colors.redAccent,
                    color: Color(0xffF4F6CE),

                    width: 70,
                    alignment: Alignment.topLeft,
                    child:Text(price.toStringAsFixed(2)+
                        '\u20AC',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight
                              .bold,
//                                                      color: Colors.white
                          color: Color(0xff707070),

                        )),
                  )
//                    ),


                ],
              ),
            ),


//            stringifiedFoodItemIngredients
//                .length > 12 ?
//            stringifiedFoodItemIngredients
//                .substring(0, 12) + '...' :
//            stringifiedFoodItemIngredients,
            Container(
//              color:Colors.redAccent,
              color: Color(0xffF4F6CE),

              width: 130,
              alignment: Alignment.centerLeft,
              child:foodItemName.length >18?
              Text('${foodItemName.substring(0, 16)}'+ '...' ,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  )):
              Text('$foodItemName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  )),
              /*Text('$foodItemName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  ))*/
            ),

            Container(

//              color: Colors.green,
              color: Color(0xffF4F6CE),

              margin: EdgeInsets.fromLTRB(
                  0, 10, 0, 0),
              width: 130,
              height: 20,
//              alignment: Alignment.centerLeft,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                reverse: false,

                shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: selectedIngredients.length,

                itemBuilder: (_, int index) {
                  return Text('${selectedIngredients[index].ingredientName}'+ ', ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight
                          .bold,
//                                                      color: Colors.white
                      color: Color(0xff707070),
                    ),
                  );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);
                },
              ),
              /*
              child: GridView.builder(
                gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
//                new SliverGridDelegateWithMaxCrossAxisExtent(

                  //Above to below for 3 not 2 Food Items:
//                  maxCrossAxisExtent: 120,
                  mainAxisSpacing: 0, // H  direction
                  crossAxisSpacing: 0,
                  childAspectRatio: 40 / 140,
                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                  // horizontal / vertical
//                                              childAspectRatio: 280/360,


                ),
                scrollDirection: Axis.horizontal,
                reverse: false,

                shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: selectedIngredients.length,

                itemBuilder: (_, int index) {
                  return Text('${selectedIngredients[index].ingredientName}'+ ', ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight
                          .bold,
//                                                      color: Colors.white
                      color: Color(0xff707070),
                    ),);
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);
                },
              ),
              */



            )




          ],

        ),
      );
    }

    else{
      return Container(
//        color: Color(0xFFffffff),
        color: Color(0xffF4F6CE),
//      height: displayHeight(context)/4,
        height:displayWidth(context)/3.8,
//        height: displayWidth(context) / 3,
        width:displayWidth(context)/5,
        margin: EdgeInsets.fromLTRB(
            displayWidth(context)/17, 0, 12, 0),





//      padding: EdgeInsets.fromLTRB(
//          0, 12, 12, 5),


        child: Column(

          children: <Widget>[
            Container(
              child:Row(
                children: <Widget>[


                  Container(
                    width:90,
                    height: 170,
//                  width:displayWidth(context) / 15,
//                    color:Colors.white,
                    color: Color(0xffF4F6CE),
                    padding: EdgeInsets.fromLTRB(
                        0, 12, 0, 12),
                    //  child: Card(

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
                    // -displayWidth(context)/9
                    child: ClipRect(
//        child: Transform.translate(
//        offset:Offset(-displayWidth(context)/15,0),
                      child: Container(
                        child: Transform.translate(
                          offset: Offset(-displayWidth(context) / 49, 0),
                          // offset (-x,y) =(-50,0) =
                          child:


                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                width: displayWidth(context) / 3,
                                height: displayWidth(context) / 3.5,

                                // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

                                decoration: new BoxDecoration(
//                                  color: Colors.white,
                                  color: Color(0xffF4F6CE),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,

                                child:
                                ClipOval(
                                  child: CachedNetworkImage(
                                    width: displayWidth(context) / 3,
                                    height: displayWidth(context) / 3.5,
                                    imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                                    fit: BoxFit.fill,
//
                                    placeholder: (context,
                                        url) => new CircularProgressIndicator(),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ),

                  Container(
//                    color:Colors.white,
                    color: Color(0xffF4F6CE),

                    width: 70,
                    alignment: Alignment.topLeft,
                    child:Text(price.toStringAsFixed(2)+
                        '\u20AC',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight
                              .bold,
//                                                      color: Colors.white
                          color: Color(0xff707070),

                        )),
                  )
//                    ),


                ],
              ),
            ),


            Container(
//              color:Colors.redAccent,
              color: Color(0xffF4F6CE),

              width: 130,
              alignment: Alignment.centerLeft,
              child:foodItemName.length >18?
              Text('${foodItemName.substring(0, 16)}'+ '...' ,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  )):
              Text('$foodItemName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  )),
              /*Text('$foodItemName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight
                        .bold,
//                                                      color: Colors.white
                    color: Color(0xff707070),

                  ))*/
            ),

            Container(

//              color: Colors.green,
//              color: Colors.white,

              color: Color(0xffF4F6CE),

              margin: EdgeInsets.fromLTRB(
                  0, 10, 0, 0),
              width: 130,
              height: 20,
//              alignment: Alignment.centerLeft,
              child: ListView.builder
                (
                  scrollDirection: Axis.horizontal,

                  reverse: false,

                  shrinkWrap: false,
                  itemCount: selectedIngredients.length,

                  itemBuilder: (_, int index) {
                    return Text('${selectedIngredients[index].ingredientName}' + ', ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight
                            .bold,
//                                                      color: Colors.white
                        color: Color(0xff707070),
                      ),
                    );
                  }
              ),
              /*
              child: GridView.builder(
                gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
//                new SliverGridDelegateWithMaxCrossAxisExtent(

                  //Above to below for 3 not 2 Food Items:
//                  maxCrossAxisExtent: 120,
                  mainAxisSpacing: 0, // H  direction
                  crossAxisSpacing: 0,
                  childAspectRatio: 40 / 140,
                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                  // horizontal / vertical
//                                              childAspectRatio: 280/360,


                ),
                scrollDirection: Axis.horizontal,
                reverse: false,

                shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: selectedIngredients.length,

                itemBuilder: (_, int index) {
                  return Text('${selectedIngredients[index].ingredientName}'+ ', ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight
                          .bold,
//                                                      color: Colors.white
                      color: Color(0xff707070),
                    ),);
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);
                },
              ),
              */


            )




          ],

        ),
      );
    }
  }
}



class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width/2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}