//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
//import 'package:foodgallery/src/BLoC/app_bloc.dart';
//import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';
//import 'file:///C:/Users/Taxi/Progrms/linkup/lib/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';
//import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
//import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';
//import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';
import 'package:logger/logger.dart';
//import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
//import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
//import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
//import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
//import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import './../../DataLayer/itemData.dart';


//import './../../shared/category_Constants.dart' as Constants;


// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

// final Firestore firestore = Firestore();



class FoodItemDetails2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;
//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  FoodItemDetails2({Key key, this.child}) : super(key: key);
  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();

//  _FoodItemDetailsState createState() => _FoodItemDetailsState();

}


class _FoodItemDetailsState extends State<FoodItemDetails2> {


  String _currentSize;

  double priceBasedOnCheeseSauceIngredientsSizeState = 0.0;




  double tryCast<num>(dynamic x, {num fallback }) {

//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;



  @override
  Widget build(BuildContext context) {

//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    logger.e('blocD: $blocD');
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    List<NewIngredient> unSelectedIngredients = blocD.unSelectedIngredients;



    if (unSelectedIngredients == null) {
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    else {


      return Container(

          child: StreamBuilder<FoodItemWithDocIDViewModel>(


              stream: blocD.currentFoodItemsStream,
              initialData: blocD.currentFoodItem,

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: new LinearProgressIndicator());
                  // from LinearProgressIndicator() to CircularProgressIndicator();
                  // checking which function progress indicator is executed from pop from foodDetails page to foodGallery page.
                }
                else {
                  //   print('snapshot.hasData FDetails: ${snapshot.hasData}');

                  final FoodItemWithDocIDViewModel oneFood = snapshot
                      .data;

                  final Map<String, dynamic> foodSizePrice = oneFood
                      .sizedFoodPrices;


                  double priceByQuantityANDSize = 0.0;
                  //            priceBasedOnCheeseSauceIngredientsSizeState = oneFood.itemSize;

//                  priceBasedOnCheeseSauceIngredientsSizeState = oneFood.itemPrice;

                  priceBasedOnCheeseSauceIngredientsSizeState =  oneFood.priceBasedOnCheeseSauceIngredientsSize;

                  priceByQuantityANDSize = oneFood.itemPrice;

                  _currentSize = oneFood.itemSize;


                  return GestureDetector(
                    onTap: () {
                      print('s');
                      print('navigating to FoodGallery 2 again with block');

                      FocusScopeNode currentFocus = FocusScope.of(
                          context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
//                  Navigator.pop(context);

                      }



                      final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD =
//                          BlocProvider2.of(context).getFoodItemDetailsBlockObject;



                      SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

                      print('temp is $temp');

                      print('temp.selectedIngredients: ${temp.selectedIngredients}');
                      print('temp.selectedCheeseItems: ${temp.selectedCheeseItems}');
                      print('temp.selectedSauceItems:  ${temp.selectedSauceItems}');



                      SelectedFood tempSelectedFood = (temp == null)? new SelectedFood():
                      temp /*.selectedFoodInOrder.first*/;



                      // WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
                      // WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
                      // FROM FOOD ITEM PAGE.



                      blocD.clearSubscription();

                      return Navigator.pop(context,tempSelectedFood);




                    },
                    child:
                    Scaffold(

                      backgroundColor: Colors.white.withOpacity(0.05),
                      // this is the main reason of transparency at next screen.
                      // I am ignoring rest implementation but what i have achieved is you can see.

                      body: SafeArea(

                        // smaller container containing all modal FoodItem Details things.
                        child: Container(
                            height: displayHeight(context) -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).padding.bottom,
//                            kToolbarHeight

                            child: GestureDetector(
                              onTap: () {
                                print('GestureDetector for Stack working');
                                print('no navigation now');


                              },
                              child: Stack(
                                children: <Widget>[
                                  // todo==>
                                  // showUnSelectedIngredients displayHeight(context)/16
                                  AnimatedPositioned(
                                    // height:  displayHeight(context) / 3,

                                      child: AnimatedContainer(

                                        decoration: BoxDecoration(
//                                        color: Colors.lightGreen,
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(25),
//                                        borderRadius: BorderRadius.all(20),
                                        ),
                                        // Define how long the animation should take.
                                        duration: Duration(seconds: 1),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.fastOutSlowIn,
//                                      color:Colors.blueAccent,
//                                         height:  displayHeight(context) / 2.2,
                                        // height: displayHeight(context)/2.1,
                                        width: displayWidth(context)/1.01,
                                        height:  displayHeight(context) / 3,

                                        margin: EdgeInsets.fromLTRB(
                                            12, 0, 0, 0),
                                        padding: EdgeInsets.fromLTRB(0, 24, 0, 20),

                                        child:StreamBuilder(
                                          stream: blocD.getUnSelectedIngredientItemsStream,
                                          initialData: blocD.unSelectedIngredients,

                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(child: new LinearProgressIndicator());
                                            }
                                            else {

                                              List<NewIngredient> unSelectedIngredients = snapshot.data;
                                              return GridView.builder(
                                                itemCount: unSelectedIngredients
                                                    .length,
                                                itemBuilder: (_, int index) {
                                                  return _buildOneUNSelected
                                                    (
                                                      unSelectedIngredients[index],
                                                      index/*, unSelectedIngredients*/
                                                  );
                                                },
                                                gridDelegate:
//                                            new SliverGridDelegateWithFixedCrossAxisCount(
//                                              crossAxisCount: 3,
                                                new SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 180,

                                                  mainAxisSpacing: 0,
                                                  // H  direction
                                                  crossAxisSpacing: 0,

                                                  ///childAspectRatio:
                                                  /// The ratio of the cross-axis to the main-axis extent of each child.
                                                  /// H/V
                                                  childAspectRatio: 300 / 340,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                                                  // horizontal / vertical
//                                              childAspectRatio: 280/360,

                                                ),


                                                controller: new ScrollController(
                                                    keepScrollOffset: false),

                                                shrinkWrap: false,


                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 500),
                                      top: showUnSelectedIngredients
                                          ? displayHeight(context)/16
                                          /*THIS IS TOP MARGIN */ - MediaQuery
                                              .of(context)
                                              .padding
                                              .top /*THIS IS SAFE AREA. AT THE TOP.*/ +
                                          displayHeight(context) /1.65
                                      // displayHeight(context)/3.2
                                      // displayHeight(context)/3.2
                                          :  /*displayHeight(context)/16*/
                                      displayHeight(context)/3.2


                                    //  top:displayHeight(context) / 2,
                                  ),

                                  Container(

                                    height: displayHeight(context) / 1.7,
                                    // FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
                                    width: displayWidth(context)/1.01,
//                  color:Colors.lightGreen,
                                    margin: EdgeInsets.fromLTRB(
                                        12, displayHeight(context)/16, 0, 5),

                                    decoration:
                                    new BoxDecoration(
                                      borderRadius: new BorderRadius
                                          .circular(
                                          10.0),
//                                    color: Colors.purple,
                                      color: Colors.white,
                                    ),


                                    child:
                                    Neumorphic(
                                      curve: Neumorphic.DEFAULT_CURVE,
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape
                                            .concave,
                                        depth: 8,
                                        lightSource: LightSource
                                            .topLeft,
                                        color: Colors.white,
                                        boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)),
                                        ),
                                      ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(

                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[

                                            Container(

//                                            color: Colors.redAccent,
                                              color: Colors.white,
                                              height:displayHeight(context)/18,
//                                              width: displayWidth(context)*0.57,
                                              width: displayWidth(context)/1.01,
                                              // /1.07 is the width of this
                                              // uppper container.


                                              child: Row(

                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[



                                                  // YELLOW NAME AND PRICE BEGINS HERE.
                                                  Container(
                                                    width: displayWidth(context)/3.9 +  displayWidth(context)/8,
                                                    // width: displayWidth(context)/1.01,


                                                    decoration: BoxDecoration(
                                                      color:Color(0xffFFE18E),
                                                      borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
//
                                                    ),


                                                    height:displayHeight(context)/18,
//                                          height: displayHeight(context)/40,

                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                      children: <Widget>[
                                                        Container(
                                                          width: displayWidth(context)/3.9,
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              10, 0, 0,
                                                              0),
                                                          child:

                                                          Text(
                                                              '${oneFood
                                                                  .itemName}',
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: 'Itim-Regular',

                                                              )
                                                          ),
                                                        ),

                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              0, 4, displayWidth(context)/40,
                                                              0),
                                                          child:

                                                          Text(
                                                              '${priceBasedOnCheeseSauceIngredientsSizeState.toStringAsFixed(2)}' +
                                                                  '\u20AC',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight
                                                                    .normal,
//                                                      color: Colors.white
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: 'Itim-Regular',

                                                              )
                                                          ),
                                                        ),

                                                      ],
                                                    ),



                                                  ),

                                                  // YELLOW NAME AND PRICE ENDS HERE.



                                                  // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                                  // ENDED HERE.

                                                  // BLACK CONTAINER WILL BE DELETED LATER.
                                                  // BLACK CONTAINER.






                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(0, 5, displayWidth(context)/40, 5),
//                                                      padding::::
                                                    color:Colors.white,
//                                                   color:Colors.red,
                                                    width: displayWidth(context) /1.8,
                                                    // width: displayWidth(context) /1.5,
//                                                        height: 45,
//                                                   height: displayHeight(context)/27,
                                                    height: displayHeight(context)/14,
//                                                  width: displayWidth(context) /1.80,
                                                    child: _buildMultiSelectOptions(),
//                                                      Card(child: _buildMultiSelectOptions()),

                                                    // Text('_buildMultiSelectOptions()')

                                                  ),
                                                ],
                                              ),

                                            ),




                                            // 2nd ROW CONTAINING IMAGE CONTAINER
                                            // AS ONE CHILD AND SIZED COMPONENTS ADN
                                            // DEFAULT INGREDIENTS IN ANOTHER PLACE.
                                            Container(
                                                // color:Colors.deepPurpleAccent,

                                                // height: displayHeight(context) / 7 +
                                                //     displayHeight(context) / 6.6
                                                //     + displayHeight(context) / 8,

                                                height: displayHeight(context)/2.3,

                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                                                    // , 2ND PART(ROW) HANDLES THE
                                                    // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.


                                                    Container(
                                                      width: displayWidth(context)/2.33,
                                                      height: displayHeight(context)/2.3,
                                                      // color:Colors.deepPurple,
                                                      child:
                                                      Container(
                                                        child: Container(

                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              0, 0, 0,
                                                              0),

                                                          child: FoodDetailImage(
                                                              oneFood
                                                                  .imageURL,
                                                              oneFood
                                                                  .itemName),
                                                        ),

                                                      ),

                                                    ),

                                                    // SIZED COMPONENTS AND
                                                    // DEFAULT INGREDIENTS IN ANOTHER PLACE. BEGINS.
                                                    // HERE.

                                                    // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:

                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(0,20,0,0),
                                                      // color:Colors.redAccent,
                                                      height: displayHeight(context)/2.1,

                                                      // width: displayWidth(context) /1.39,
                                                      // width: displayWidth(context) /2.2,
                                                      width: displayWidth(context) /1.8,

                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          //pppp




                                                          Container(
//                                                                  color: Colors.pink,

                                                              padding: EdgeInsets.fromLTRB(0, 10, displayWidth(context)/40, 5),
                                                              // height: displayHeight(context) / 8.8,
                                                              height: displayHeight(context) / 4.8,
//                                                        width: displayWidth(context) /1.80,
//                                                                   width: displayWidth(context) /1.70,
                                                              width: displayWidth(context) /1.8,
                                                              child: _buildProductSizes(
                                                                  context,
                                                                  foodSizePrice)

                                                          ),




                                                          Container(
                                                            width: displayWidth(context) /1.8,
                                                            height: displayHeight(
                                                                context) / 20,
                                                            // color: Color(0xffffffff),
                                                            // color:Colors.greenAccent,
                                                            color:Colors.white,

                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[

                                                                  Container(
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                          10, 10, 0, 10),
                                                                      alignment: Alignment
                                                                          .center,
                                                                      child: Text('Default'.toUpperCase(),
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontSize: 20,
                                                                          fontFamily: 'Itim-Regular',
                                                                          color: Color(0xff707070),
                                                                        ),
                                                                      )
                                                                  ),

                                                                  CustomPaint(
                                                                    size: Size(0, 19),
                                                                    painter: LongHeaderPainterAfterShoppingCartPage(
                                                                        context),
                                                                  ),


                                                                ]
                                                            ),

                                                          ),



                                                          Container(
//                                                            height: displayHeight(context) / 10,
                                                              height: displayHeight(context) / 7,
                                                              width: displayWidth(context) /1.8,
                                                              margin: EdgeInsets.fromLTRB(0,10,0,0),
//                                                            width: displayWidth(context) * 0.57,
//                                                            color: Color(0xfff4444aa),
//                                                            color:Colors.lightBlueAccent,
//                                                        alignment: Alignment.center,
                                                              child: buildDefaultIngredients(context)
                                                            //Text('buildDefaultIngredients('
                                                            //    'context'
                                                            //')'),
                                                          ),

                                                          // 911_1_this_to_be_below








                                                        ],
                                                      ),
                                                    ),




                                                  ],
                                                )

                                            ),


                                            Container(
                                              padding:EdgeInsets.fromLTRB(0,30,0,0),
                                              width: displayWidth(context) / 1.01,
                                              height: displayHeight(context) / 12,
                                              color: Color(0xffffffff),

                                              // color: Colors.pink,

                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[


                                                  Container(
                                                      width: displayWidth(context)/4,
                                                      color:Colors.blue,

                                                      child: pressToContinueInitialDetailPage()
                                                  ),



                                                  Container(
                                                    // color:Colors.green,
                                                    width: displayWidth(context)/3,
                                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                                                    child:animatedWidgetMoreIngredientsButton(),


                                                  ),


                                                  Container(
//                                                          color:Colors.lightBlueAccent,
                                                    child: StreamBuilder<SelectedFood>(

                                                        stream: blocD.getCurrentSelectedFoodStream,
                                                        initialData: blocD.getCurrentSelectedFoodDetails,
                                                        builder: (context, snapshot) {
                                                          if ((snapshot.hasError) || (!snapshot.hasData)) {
                                                            return Center(
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                child: Text('WRNG'),
                                                              ),
                                                            );
                                                          }
                                                          else {

                                                            SelectedFood incrementCurrentFoodProcessing = snapshot.data;


                                                            int itemCountNew;


                                                            print('incrementCurrentFoodProcessing==null ${incrementCurrentFoodProcessing==null}');


                                                            if(incrementCurrentFoodProcessing==null){
                                                              itemCountNew=0;
                                                            }
                                                            else {
                                                              itemCountNew = incrementCurrentFoodProcessing.quantity;
                                                            }

                                                            return Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 0),

                                                              width: displayWidth(context)/4,
//                height: 45,
                                                              height: displayHeight(context) / 21,

//                                            color:Color(0xffC27FFF),
                                                              child:
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[

//p1
                                                                  IconButton(

                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 0, vertical: 0),
                                                                    icon: Icon(Icons.add_circle_outline,color: Color(0xff85B20A),),
                                                                    iconSize: 48,

                                                                    tooltip: 'Increase product count by 1 ',
                                                                    onPressed: () {


                                                                      SelectedFood incrementCurrentFoodProcessing = snapshot.data;


                                                                      if(incrementCurrentFoodProcessing.quantity == 0){
                                                                        print(' JJJJ at lengthOfSelectedItemsLength  == 0 ');

                                                                        print('itemCountNew JJJJ $itemCountNew');

                                                                        int initialItemCount = 0;

                                                                        int quantity =1;
                                                                        // INITIAL CASE FIRST ITEM FROM ENTERING THIS PAGE FROM FOOD GALLERY PAGE.
                                                                        SelectedFood oneSelectedFoodFD = new SelectedFood(
                                                                          foodItemName: blocD
                                                                              .currentFoodItem.itemName,
                                                                          foodItemImageURL: blocD
                                                                              .currentFoodItem.imageURL,
                                                                          unitPrice: priceBasedOnCheeseSauceIngredientsSizeState,
                                                                          // unitPriceWithoutCheeseIngredientSauces: priceBySize,
                                                                          foodDocumentId: blocD
                                                                              .currentFoodItem.documentId,
                                                                          quantity: quantity,
                                                                          foodItemSize: _currentSize,
                                                                          categoryName:blocD
                                                                              .currentFoodItem.categoryName,
                                                                          discount:blocD
                                                                              .currentFoodItem.discount,
                                                                          // index or int value not good enought since size may vary best on Food Types .
                                                                        );

                                                                        blocD
                                                                            .incrementOneSelectedFoodForOrder(
                                                                            oneSelectedFoodFD, initialItemCount);
                                                                      }
                                                                      else{
                                                                        print(' at else RRRRR');

                                                                        int oldQuantity = incrementCurrentFoodProcessing.quantity;

                                                                        int newQuantity = oldQuantity + 1;

                                                                        SelectedFood oneSelectedFoodFD = new SelectedFood(
                                                                          foodItemName: blocD
                                                                              .currentFoodItem.itemName,
                                                                          foodItemImageURL: blocD
                                                                              .currentFoodItem.imageURL,
                                                                          unitPrice: priceBasedOnCheeseSauceIngredientsSizeState,
//                                                                                unitPrice: priceBasedOnCheeseSauceIngredientsSizeState,
//                                                                           unitPriceWithoutCheeseIngredientSauces: priceBySize,
                                                                          foodDocumentId: blocD
                                                                              .currentFoodItem.documentId,
                                                                          quantity: newQuantity,
                                                                          foodItemSize: _currentSize,
                                                                          categoryName:blocD
                                                                              .currentFoodItem.categoryName,
                                                                          discount:blocD
                                                                              .currentFoodItem.discount,
                                                                          // index or int value not good enought since size may vary best on Food Types .
                                                                        );


                                                                        //incrementCurrentFoodProcessing.quantity= newQuantity;

                                                                        // TODO TODO TODO.
                                                                        // TO DO SOME CODES CAN BE OMITTED HERE, LIKE WE DON'T NEED TO PASS THIS PARAMETER OR
                                                                        // NEITHER NEED TO RECREATE IT ABOVE, WE NEED TO PASS BUT NOT CREATE IT ABOVE.
                                                                        blocD
                                                                            .incrementOneSelectedFoodForOrder(oneSelectedFoodFD /*
                                      THIS oneSelectedFoodFD WILL NOT BE USED WHEN SAME ITEM IS INCREMENTED AND

                                      QUANTITY IS MORE THAN ONE.
                                      */,oldQuantity);
                                                                      }

                                                                    },
                                                                    color: Color(0xff707070),
                                                                  ),

                                                                  Container(
//                                                                        width:60,
                                                                    width: displayWidth(
                                                                        context) / 12,
                                                                    height: displayHeight(context) / 22,
                                                                    alignment: Alignment.center,
                                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),



                                                                    child:Container(
                                                                      child: Stack(
                                                                          children: <Widget>[ Center(
                                                                            child: Icon(

                                                                                Icons.add_shopping_cart,
                                                                                size: displayHeight(context)/20,
                                                                                color:
                                                                                Color(0xff85B20A)
//                    Color(0xff707070),
                                                                            ),


                                                                          ),
                                                                            Container(
                                                                              padding: EdgeInsets.fromLTRB(
                                                                                  10,0,0,25),
                                                                              width: 60,
                                                                              height: 70,

                                                                              child: Container(

//                                              color:Colors.red,
                                                                                width: 40,

//                                            alignment: Alignment.centerRight,
                                                                                decoration: new BoxDecoration(
                                                                                  color: Colors.redAccent,

                                                                                  border: new Border.all(
                                                                                      color: Colors.green,
                                                                                      width: 1.0,
                                                                                      style: BorderStyle.solid
                                                                                  ),
                                                                                  shape: BoxShape.circle,

                                                                                ),

                                                                                alignment: Alignment.center,
                                                                                child: Text(

                                                                                  itemCountNew.toString(),
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight
                                                                                        .normal,
                                                                                    fontSize: 20,
                                                                                  ),
                                                                                ),

                                                                              ),
                                                                            ),



                                                                          ]
                                                                      ),
                                                                    ),
                                                                  ),





                                                                  IconButton(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 0, vertical: 0),
                                                                    icon: Icon(Icons.remove_circle_outline, color: Color(0xffF50303)),
//                                                                            icon: Icon(Icons.remove),
                                                                    iconSize: 48,
                                                                    tooltip: 'Decrease product count by 1',
                                                                    onPressed: () {
                                                                      final foodItemDetailsbloc = BlocProvider.of<
                                                                          FoodItemDetailsBloc>(context);
                                                                      print(
                                                                          'Decrease button pressed related to _itemCount');
                                                                      if (itemCountNew >= 1) {
//                                if (itemCountNew == 1) {
                                                                        print(
                                                                            'itemCountNew== $itemCountNew');


                                                                        foodItemDetailsbloc
                                                                            .decrementOneSelectedFoodForOrder(itemCountNew);

                                                                      }
                                                                    },
//                              size: 24,
                                                                    color: Color(0xff707070),
                                                                  ),


                                                                ],

                                                              ),

                                                            );
                                                          }
                                                        }
                                                    ),
                                                  ),

//                                                   Container(
// //                                                          width: displayWidth(context)/1.07- displayWidth(context)/20,
//                                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//
//                                                     child:animatedWidgetMoreIngredientsButton(),
//
//
//
//                                                   ),



                                                ],
                                              ),
                                            ),

                                            // SIZED COMPONENTS AND
                                            // DEFAULT INGREDIENTS IN ANOTHER PLACE. BEGINS.
                                            // HERE.

                                            // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:



                                          ]
                                      ),

                                    ),

                                    /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */





                                  ),

                                ],
                              ),
                            )


                        ),
                      ),
                    ),
                  );
                }
              }
          )
      );
    }
  }


  Widget continueShoppingButton() {
    ///sdfsdfsdf
    return RaisedButton(
        color: Color(0xff5D9EFF),
        highlightColor: Color(0xff525FFF),
        splashColor: Color(0xffB47C00),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        highlightElevation: 12,
        child: Container(
          width: displayWidth(context) / 4,
          height: displayHeight(context) / 24,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //  SizedBox(width: 5,),

              Text(
//                'jatka'.toUpperCase(),
                /*'continue shopping'.toUpperCase(),*/
                'buy more'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontWeight: FontWeight.normal,
//                    color: Color(0xffF50303),
                  color: Colors.white,

                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ),
        onPressed: () {

          var logger = Logger(
            printer: PrettyPrinter(),
          );
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

          SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

          logger.i('temp.multiSelct.length: ${temp.multiSelct.length}');

          print('temp.unitPrice:  ${temp.unitPrice}');
          // print('temp.unitPriceWithoutCheeseIngredientSauces: '
          //     ' ${temp.unitPriceWithoutCheeseIngredientSauces}');
          print('temp.quantity:  ${temp.quantity}');

          print('temp.foodItemSize:  ${temp.foodItemSize}');
          print('temp.subTotalPrice:  ${temp.subTotalPrice}');

          SelectedFood tempSelectedFood = (temp == null)
              ? new SelectedFood()
              : temp /*.selectedFoodInOrder.first*/;

          // WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
          // WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
          // FROM FOOD ITEM PAGE.

          print('CLEAR SUBSCRIPTION ... before going to food gallery page..');
          blocD.clearSubscription();

          return Navigator.pop(context, tempSelectedFood);
        });
  }



  Widget pressToContinueInitialDetailPage() {
    return Container(
      width: displayWidth(context) / 4,
//            child: moreIngredientsButton(),

      child: continueShoppingButton(),
    );
  }





  Widget animatedWidgetPressToFinish(){
    return

      RaisedButton(
          color:Colors.redAccent,
          highlightColor: Color(0xff525FFF),
          splashColor: Color(0xffB47C00),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          highlightElevation: 12,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: Color(0xff707070),
//               style: BorderStyle.solid,
// //            width: 1,
//             ),
//             borderRadius: BorderRadius.circular(30.0),
//           ),

          child:Container(

            // width:displayWidth(context)/3.5,
              width: displayWidth(context)/3,
              // height: displayHeight(context)/28,
              height: displayHeight(context) / 24,
              color: Color(0xff5D9EFF),
              padding: EdgeInsets.fromLTRB(0,12,0,0),

              child:
              Container(

                // padding: EdgeInsets.fromLTRB(0,3,0,0),
                // padding: EdgeInsets.fromLTRB(2,8,0,0),
                child:Text(
                  // 'press to FINISH'.toLowerCase(),
                  'press to FINISH'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight
                          .bold,
                      color: Color(0xffFFFFFF),
                      // fontFamily: 'Itim-Regular',
                      // fontSize: 18,
                      fontFamily: 'poppins',
                      fontSize: 22
                  ),
                ),
              )


          ),
          onPressed: () {
//



            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//            final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//            final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
            blocD.moreDefaultIngredientItems(/*oneSelected,index*/);

            setState(() {

              showUnSelectedIngredients = !showUnSelectedIngredients;
              showPressWhenFinishButton = !showPressWhenFinishButton;


//                ::::A
//                          myAnimatedWidget1 = myAnimatedWidget2;

            });
          });

  }

  Widget moreIngredientsButton(){

    return
      RaisedButton(

          color: Color(0xff5D9EFF),
          highlightColor: Color(0xff525FFF),
          splashColor: Color(0xffB47C00),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          // highlightElevation: 12,
          // splashColor: Color(0xffFEE295),

          highlightElevation: 12,

          // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

          // shape: RoundedRectangleBorder(
          //
          //   borderRadius: BorderRadius.circular(35.0),
          // ),

          // borderSide: BorderSide(
          //   color: Colors.lightGreenAccent,
          //   style: BorderStyle.solid,
          //   width: 3.6,
          // ),

          child:Container(

            // width:displayWidth(context)/3.5,
            width: displayWidth(context)/3,
            // height: displayHeight(context)/28,
            height: displayHeight(context) / 24,
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <
                  Widget>[
                //  SizedBox(width: 5,),
                Container(
                  padding: EdgeInsets.fromLTRB(0,3,0,0),
                  child: Icon(
                    Icons.add,
                    size: 25.0,

                    // color: Color(0xff5D9EFF),
                    color:Colors.white,

                    //        color: Color(0xffFFFFFF),
                  ),
                ),
                Text(
                  'more ingredients'.toUpperCase(),
                  textAlign: TextAlign.center,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight
                        .bold,
                    color:Colors.white,
                    // color: Color(0xffF50303),
                    // fontSize: 22,
                    // fontFamily: 'Itim-Regular',
                    fontSize: 22,
                    fontFamily: 'poppins',


                  ),
                ),
              ],
            ),
          ),
          onPressed: () {

            setState(() {

              showUnSelectedIngredients = !showUnSelectedIngredients;
              showPressWhenFinishButton = !showPressWhenFinishButton;

            });
            print(
                'xyz');
          }
      );
  }

  Widget animatedWidgetMoreIngredientsButton(){

    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
    return
      Container(



        // height: displayHeight(context) / 40,
        height: displayHeight(context) / 24,

        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),

          child: showPressWhenFinishButton? animatedWidgetPressToFinish():
          moreIngredientsButton(),

        ),



      );
  }

  Widget _buildOneUNSelected(NewIngredient unSelectedOneIngredient, int index
      /*,
      List<NewIngredient> allUnSelected */
      ) {

//    print('index : $index');

//    print('unSelectedOneIngredient: ${unSelectedOneIngredient.ingredientName}');
//
//    logger.i("unSelectedOneIngredient: ",unSelectedOneIngredient.ingredientAmountByUser);


    int currentAmount = unSelectedOneIngredient.ingredientAmountByUser;

    String imageURLFinalNotSelected = unSelectedOneIngredient.imageURL;

    // String imageURLFinalNotSelected = (unSelectedOneIngredient.imageURL == '') ?
    // 'https://thumbs.dreamstime.com/z/smiling-orange-fruit-'
    //     'cartoon-mascot-character-holding-blank-sign-smiling-orange-'
    //     'fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
    //     : storageBucketURLPredicate + Uri.encodeComponent(unSelectedOneIngredient.imageURL) + '?alt=media';

//    logger.i("imageURLFinalNotSelected: ",imageURLFinalNotSelected);


    return Container(
        color: Color.fromRGBO(239, 239, 239, 0),
        padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
            horizontal: 2.0, vertical: 2.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//                              SizedBox(height: 10),

            Container(

              width: displayWidth(context) /9,
              height: displayWidth(context) /8.8,
              padding:EdgeInsets.symmetric(vertical: 2,horizontal: 0),
//                                    height: displayWidth(context) * 0.19,

              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: imageURLFinalNotSelected,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => new LinearProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.network(
                          'https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg'),
//                    https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg
//                    https://img.freepik.com/free-vector/404-error-page-found-with-donut_114341-54.jpg?size=626&ext=jpg

//                    errorWidget:(context,imageURLFinalNotSelected,'Error'),
                ),
              ),
            ),

            Container(
// TO Be
//          height:45, // same as the heidth of increment decrement button.
              width: displayWidth(context) /6.5,
              height: displayHeight(context) /36,

//              height:45,
//              alignment: Alignment.center,
              // pp ToDOPPP

              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:


//              stringifiedFoodItemIngredients.length==0?
//              'EMPTY':  stringifiedFoodItemIngredients.length>12?
//              stringifiedFoodItemIngredients.substring(0,12)+'...':
//              stringifiedFoodItemIngredients,
//

              /*
              Text(
//                unSelectedOneIngredient.ingredientName,
                unSelectedOneIngredient.ingredientName.length==0?
                'EMPTY':  unSelectedOneIngredient.ingredientName.length>10?
                unSelectedOneIngredient.ingredientName.substring(0,10)+'...':
                unSelectedOneIngredient.ingredientName,
                style: TextStyle(
                  color:Color(0xff707070),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),

              ),
              */
              Text(unSelectedOneIngredient.ingredientName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:Color(0xff707070),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,

                  fontSize: 14,
                ),

              ),
            ),
            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- BELOW.
            Container(
              margin:EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0
              ),


//                                              height: displayHeight(context) *0.11,
              height:displayHeight(context) /35,
              width: displayWidth(context) /6.9,
              // same as the heidth of increment decrement button. // 45
              // later changed height to 40.
              decoration: BoxDecoration(
//                                              color: Colors.black54,
                color:Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(25),

              ),


//                                            color:Color(0xffC27FFF),

              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                    icon: Icon(Icons.add),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {


                      print('Add button pressed in unselected Ing');


                      final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                      final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                      blocD.incrementThisIngredientItem(unSelectedOneIngredient,index);


//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                    },
                    color: Color(0xff707070),
                  ),



//      double.parse(doc['priceinEuro'])
//          .toStringAsFixed(2);
                  Text(
                    currentAmount.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),




                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                    icon: Icon(Icons.remove),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {
                      print('Minus button pressed in unselected ing');
                      print('Decrease button pressed InkResponse');

                      if (currentAmount >=1) {
//                      if(currentAmount>=2)
//                      City c1 = new City()..name = 'Blum'..state = 'SC';

                        /*
                          NewIngredient c1 = new NewIngredient(
                              ingredientName: unSelectedOneIngredient
                                  .ingredientName,
                              imageURL: unSelectedOneIngredient.imageURL,

                              price: unSelectedOneIngredient.price,
                              documentId: unSelectedOneIngredient.documentId,
                              ingredientAmountByUser: unSelectedOneIngredient
                                  .ingredientAmountByUser - 1
                          );


                          allUnSelected[index] = c1;

                          */

                        final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                        final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                        final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                        blocD.decrementThisIngredientItem(unSelectedOneIngredient,index);

                        /*
                          setState(() {
                            // _ingredientlistUnSelected = allUnSelected;
                          });
                          */


//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                      }
                      else{
                        print('decrease button pressed '
                            'but nothing will happen since it is less than 1');
                      }
                    },
                    color: Color(0xff707070),
                  ),
                ],

              ),
            ),
            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- ABOVE.

          ],
        )

    );
  }

  Widget _buildMultiSelectOptions(){
//   height: 40,
//   width: displayWidth(context) /2.5,


//    BlocProvider.of<FoodItemDetailsBloc>
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocD.getMultiSelectStream,
        initialData:blocD.getMultiSelectForFood,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Text('multiSelect option ! found.');
          }
          else {
            List<FoodPropertyMultiSelect> foodItemPropertyOptions = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,

              reverse: true,

              shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
              itemCount: foodItemPropertyOptions.length,

              itemBuilder: (_, int index) {
                return oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
                    index);
              },
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );

  }

  Widget _buildProductSizes(BuildContext context, Map<String,dynamic> allPrices) {
    final Map<String, dynamic> foodSizePrice = allPrices;

    Map<String, dynamic> listpart1 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart2 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart3 = new Map<String, dynamic>();
    // odd

    int len = foodSizePrice.length;
    print('len: $len');





    for (int i = 0; i < len; i++) {
      print('i: $i');
      String keyTest = foodSizePrice.keys
          .elementAt(i);
      dynamic value = foodSizePrice
          .values.elementAt(i);
//
      double valuePrice = tryCast<
          double>(value, fallback: 0.0);


      if((valuePrice!=0.0)&&(valuePrice!=0.00)) {
        listpart1[keyTest] = valuePrice;
      }
    }




    if(allPrices==null){
      return Container(
        height: displayHeight(context) / 9.8,
//          height:190,
        width: displayWidth(context) * 0.57,

        color: Color(0xFFffffff),
        alignment: Alignment.center,

        // PPPPP

        child:
        Text('No prices found.'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Itim-Regular',
            color: Colors.white,

          ),


        ),
      );
    }
    else {

      return
        /*Directionality(
        textDirection: TextDirection.rtl,
        child:  */GridView.builder(
        itemCount: listpart1.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20, // H  direction
          // crossAxisSpacing: 20,
          childAspectRatio: 170 / 70, /* (h/vertical)*/


        ),
        shrinkWrap: true,

//        reverse: true,
        itemBuilder: (_, int index) {


          String key = listpart1.keys
              .elementAt(index);
          double valuePrice = listpart1
              .values.elementAt(index);
//

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
          return _buildOneSize(
              key, valuePrice, index);
        },

      );


      // Todo DefaultItemsStreamBuilder


    }
  }


  Widget oneMultiSelectInDetailsPage (FoodPropertyMultiSelect x,int index){


    String color1 = x.itemTextColor.replaceAll('#', '0xff');

    Color c1 = Color(int.parse(color1));

    String itemName = x.itemName;


    return Container(



      child:  x.isSelected == true  ?
      Container(
        // width:displayWidth(context)/8,
        width:displayWidth(context)/9.9,
        height:displayHeight(context)/48,

        margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
        child:
        RaisedButton(
          color: c1,

          elevation: 2.5,
          shape: RoundedRectangleBorder(

            side: BorderSide(
              color:c1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child:Container(


            child: Text(
              itemName.toUpperCase(), style:
            TextStyle(
                color:Colors.white,

                fontWeight: FontWeight.bold,
                fontSize: 18),
            ),
          ),
          onPressed: () {


            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
            blocD.setMultiSelectOptionForFood(x,index);

          },



        ),
      )


          :

      Container(
        // width:displayWidth(context)/11,
        // width:displayWidth(context)/8,
        width:displayWidth(context)/9.9,
        height:displayHeight(context)/48,

        margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
        child: OutlineButton(

//          clipBehavior: Clip.hardEdge,
          splashColor: c1,

          highlightElevation: 12,


          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(35.0),
          ),

          borderSide: BorderSide(
            color: c1,
            style: BorderStyle.solid,
            width: 3.6,
          ),

          child: Container(

            child: Text(

              itemName.toUpperCase(), style:
            TextStyle(
                color: c1,

                fontWeight: FontWeight.bold,
                fontSize: 20),
            ),
          ),
          onPressed: () {

            print('$itemName pressed');
            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.setMultiSelectOptionForFood(x,index);
          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

        ),
      ),




    );
  }

  //now now
  /* DEAFULT INGREDIENT ITEMS BUILD STARTS HERE.*/

//  buildCheeseItems





  Widget buildDefaultIngredients(BuildContext context /*,List<NewIngredient> defaltIngs*/){


//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);


    return StreamBuilder(
        stream: blocD.getDefaultIngredientItemsStream,
        initialData: blocD.getDefaultIngredients,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 10,
              height: displayHeight(context) / 14,
//          height:190,
              width: displayWidth(context) /2,

              color: Color(0xFFffffff),
              alignment: Alignment.center,

              // PPPPP

              child:
              Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  // fontFamily: 'Itim-Regular',
                  fontFamily: 'poppins',
                  color: Colors.white,

                ),


              ),
            );
          }

          else {

//            print('snapshot.hasData and else statement at FDetailS2');
            List<NewIngredient> selectedIngredients = snapshot.data;

            if( (selectedIngredients.length ==1)&&
                (selectedIngredients[0].ingredientName.toLowerCase()=='none')){

              return Container(
//                  height: displayHeight(context) / 10,
                  height: displayHeight(context) / 14,
//          height:190,
                  width: displayWidth(context) /2,

                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'poppins',
                          // fontFamily: 'Itim-Regular',
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }
            else if(selectedIngredients.length==0){
              return Container(
//                  height: displayHeight(context) / 10,
                  height: displayHeight(context) / 14,
//          height:190,
                  width: displayWidth(context) /2,

                  color: Color(0xffFFFFFF),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          // fontFamily: 'Itim-Regular',
                          fontFamily: 'poppins',
                          color: Colors.grey,
                        ),
                      )
                  )
              );
            }
            else{

              return Container(
//                color: Colors.green,
                padding:EdgeInsets.fromLTRB(0,10,0,0),
                child: ListView.builder(


                  /*
                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(


                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 8, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 160 / 180,
                    // H/V


                  ),
                  */

                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,

                  itemCount: selectedIngredients
                      .length,
                  itemBuilder: (_, int index) {
                    return oneDefaultIngredient(selectedIngredients[index],
                        index);
                  },
                ),
              );
            }
          }
        }
    );
  }



  Widget oneDefaultIngredient(NewIngredient oneIngredient,int index){
    final String ingredientName = oneIngredient.ingredientName;




    final dynamic ingredientImageURL = oneIngredient.imageURL;


    // final String ingredientName = oneIngredient.ingredientName;

    // final dynamic ingredientImageURL = oneIngredient.imageURL;



    return Container(
      height: displayHeight(context) / 11,
      width: displayWidth(context) / 8,
      decoration: BoxDecoration(
        color: Color(0xffFCF5E4),
        borderRadius: BorderRadius.all(Radius.circular(5)),
//
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GestureDetector(

          onLongPressUp: (){

            print(
                'at Long Press UP: ');

            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);


            blocD.removeThisDefaultIngredientItem(oneIngredient,index);

          },


          // onLongPressUp: () {
          //   print('at Long Press UP: ');
          //
          //   final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
          //
          //   blocD.removeThisDefaultIngredientItem(oneIngredient, index);
          // },


          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                height: displayHeight(context) / 14,
                width: displayWidth(context) / 10, //S

//                      width: displayWidth(context) /10,
//                      height: displayWidth(context) /9,
//                  padding:EdgeInsets.symmetric(vertical: 0,horizontal: 0),

                child: ClipOval(
                  child: CachedNetworkImage(
//                        color: Colors.deepOrangeAccent,
//                        colorBlendMode: BlendMode.overlay ,
                    imageUrl: ingredientImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    new LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),

//                              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(top: 12),
                width: displayWidth(context) / 8,
                child: Text(
                  ingredientName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
//                                    color: Colors.blueGrey[800],

                    fontWeight: FontWeight.normal,
                    fontSize: 17,
//                    decoration: TextDecoration.underline,
//                    decorationStyle:TextDecorationStyle.double,
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            print('for future use');
          }),
    );

    /*
    return
      Container(

        padding: EdgeInsets.symmetric(

            horizontal: 18, vertical: 0),
        child: GestureDetector(

            onLongPressUp: (){

              print(
                  'at Long Press UP: ');

              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);


              blocD.removeThisDefaultIngredientItem(oneIngredient,index);

            },

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Neumorphic(
                  curve: Neumorphic.DEFAULT_CURVE,
                  style: NeumorphicStyle(
                    shape: NeumorphicShape
                        .concave,
                    depth: 8,
                    border: NeumorphicBorder(
                      isEnabled: false,
                      color: Color(0x33000000),
                      width: 0.8,
                    ),
                    lightSource: LightSource.top,
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    shadowDarkColor: Color(0xff525FFF),

                  ),
                  child:Container(

                    height: displayHeight(context) / 24,
                    width: displayWidth(context) /16.5,

                    padding:EdgeInsets.symmetric(vertical: 0,horizontal: 0),

                    child: ClipOval(

                      child: CachedNetworkImage(
                        imageUrl: ingredientImageURL,
                        fit: BoxFit.cover,
                        placeholder: (context,
                            url) => new LinearProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                      ),
                    ),
                  ),
                ),

                Container(
                  width: displayWidth(context) / 9,
                  child: Text(
                    ingredientName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Color(0xff707070),

                      fontWeight: FontWeight.normal,
                      fontSize: 14,

                    ),
                  ),
                )
                ,


              ],
            ),
            onTap: () {
              print('for future use');

            }
        ),


      );

    */
  }



  Widget _buildOneSize(String oneSize,double onePriceForSize, int index) {

    return Container(
//        color:Colors.yellow,

//        margin: EdgeInsets.fromLTRB(0, 0,5,5),
//        height:displayHeight(context)/50,


        child:  oneSize.toLowerCase() == _currentSize  ?

        Container(
//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12,2,12,5),
//          padding: EdgeInsets.fromLTRB(12,2,12,5),
          width: displayWidth(context)/3.6,
          child:
          RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
//          color: Colors.lightGreen,
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,

              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff54463E),

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 13),
              ),
            ),
            onPressed: () {

//              logger.i('onePriceForSize: ',onePriceForSize);

              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);



            },



          ),
        )


            :

        Container(

//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12, 5,12,5),
          width: displayWidth(context)/3.6,
          child:
          OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1.6,
            ),
            shape:RoundedRectangleBorder(


              borderRadius: BorderRadius.circular(35.0),
            ),
            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff54463E),

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 13),
              ),
            ),
            onPressed: () {



              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);

            },
          ),
        )
    );
  }


}


//  FoodDetailImage









//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.9, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff707070)
//          Colors.white
      ..strokeWidth = 1.6;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}
