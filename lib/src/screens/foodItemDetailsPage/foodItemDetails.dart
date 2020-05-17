//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';
import 'package:logger/logger.dart';
import 'package:neumorphic/neumorphic.dart';


//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

import './../../DataLayer/FoodItemWithDocID.dart';
import './../../DataLayer/Order.dart';
//import './../../DataLayer/itemData.dart';


//import './../../shared/category_Constants.dart' as Constants;



final Firestore firestore = Firestore();





class FoodItemDetails extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;
  final FoodItemWithDocID oneFoodItemData;
  final Firestore firestore = Firestore.instance;

//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  FoodItemDetails({Key key, this.child,this.oneFoodItemData}) : super(key: key);

  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState(oneFoodItemData);



//  _FoodItemDetailsState createState() => _FoodItemDetailsState();



}


class _FoodItemDetailsState extends State<FoodItemDetails> {

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();





  double totalCartPrice = 0;
  String _currentSize = "normal";

  double initialPriceByQuantityANDSize;
  double priceByQuantityANDSize;


  int _itemCount= 1;


//  oneFoodItemData

  FoodItemWithDocID oneFoodItemandId;

  _FoodItemDetailsState(this.oneFoodItemandId);
  List<NewIngredient> defaultIngredientListForFood;

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  Order oneOrder = new Order();


  @override
  void initState() {


    setDetailForFood();
    retrieveIngredientsDefault();
    super.initState();

  }

  Future<void> retrieveIngredientsDefault() async {
    debugPrint("Entering in retrieveIngredients1");


    await retrieveIngredients2().then((onValue){

//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');
      setState(() {
        defaultIngredientListForFood = onValue;
//        ingredientlistUnSelected = onValue.sublist(4);
      }
      );

    }

    );


  }







  Future <List> retrieveIngredients2() async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

//    final List<dynamic> foodItemIngredientsList =

    List <NewIngredient> ingItems = new List<NewIngredient>();


    final List<dynamic> foodItemIngredientsList2 =  oneFoodItemandId.ingredients;
    List<String> test2 = dListFilteredToSList(foodItemIngredientsList2);

    if(test2.length!=0) {
      logger.i('test in retrieveIngredients2() : $test2');

//    firestore
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
//        .collection('ingredients').where(
//        'name', whereIn: test
//
//    ).snapshots(),


      var snapshot = await Firestore.instance.collection("restaurants")
          .document('USWc8IgrHKdjeDe9Ft4j')
          .collection('ingredients').where(
          'name', whereIn: test2)
          .getDocuments();

      //    firestore
      //        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
      //        .collection('ingredients').

      //    List docList = snapshot.documents;
      //    print('doc List at FoodDetails page (init State) :  ******************* <================ : $docList');

      // ingItems = snapshot.documents.map((documentSnapshot) => IngredientItem.fromMap
      //(documentSnapshot.data)).toList();

      ingItems = snapshot.documents.map((documentSnapshot) =>
          NewIngredient.fromMap
            (documentSnapshot.data, documentSnapshot.documentID)

      ).toList();


      List<String> documents = snapshot.documents.map((documentSnapshot) =>
      documentSnapshot.documentID
      ).toList();

      print('documents are: $documents');


      return ingItems;
    }
    else{
      NewIngredient c1 = new NewIngredient(
          ingredientName : 'None',
          imageURL: 'None',

          price: 0.01,
          documentId: 'None',
          ingredientAmountByUser :1000

      );

      ingItems.add(c1);

      return ingItems;

    }
  }



  // !(NOT) NECESSARY NOW.
  Future<void> setDetailForFood() async {
    debugPrint("Entering in retrieveIngredients1");
//    logger.i('ss',oneFoodItemandId);
//
//
//    logger.i('ss','sss');

//    final Map<String,dynamic> foodSizePrice = oneFoodItemandId.sizedFoodPrices;


    dynamic normalPrice = oneFoodItemandId.sizedFoodPrices['normal'];
    double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);



//    logger.i('euroPrice1 :',euroPrice1);
//    tryCast(normalPrice);


//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');
    setState(()
    {

      priceByQuantityANDSize = euroPrice1;
      initialPriceByQuantityANDSize = euroPrice1;
    }
    );



  }



//    final FoodItemWithDocID oneFoodItemandId;
//  _FoodItemDetailsState({this.oneFoodItemandId});



//  final Map<String,dynamic> foodSizePrice = oneFoodItemandId.sizedFoodPrices;



  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;



  String convertDList(List<dynamic> dlist) {

    return dlist.map((name) =>

    "\'"+name.trim().toString()+"\'"
    ).join(', ');

  }



  String isIngredientExist(String inputString) {
    List<String> allIngredients = [
      'ananas',
      'aurajuusto',
      'aurinklkuivattu_tomaatti',
      'cheddar',
      'emmental_laktoositon',
      'fetajuusto',
      'herkkusieni',
      'jalapeno',
      'jauheliha',
      'juusto',
      'kana',
      'kanakebab',
      'kananmuna',
      'kapris',
      'katkarapu',
      'kebab',
      'kinkku',
      'mieto_jalapeno',
      'mozzarella',
      'oliivi',
      'paprika',
      'pekoni',
      'pepperoni',
      'persikka',
      'punasipuli',
      'rucola',
      'salaatti',
      'salami',
      'savujuusto_hyla',
      'simpukka',
      'sipuli',
      'suolakurkku',
      'taco_jauheliha',
      'tomaatti',
      'tonnikala',
      'tuore_chili',
      'tuplajuusto',
      'vuohejuusto'
    ];

// String s= allIngredients.where((oneItem) =>oneItem.toLowerCase().contains(inputString.toLowerCase())).toString();
//
// print('s , $s');

//firstWhere(bool test(E element), {E orElse()}) {
    String elementExists = allIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString.toLowerCase(),
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists;

//allIngredients.every(test(t)) {
//contains(
//    searchString2.toLowerCase())).toList();
  }

  List<String> dListFilteredToSList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
        ==
        isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

  }

  List<String> convertDList3(List<dynamic> dlist) {

    return dlist.map((name) =>

    "\'"+name.trim().toString()+"\'"
    ).toList();

  }

  @override
  Widget build(BuildContext context) {

    final Map<String,dynamic> foodSizePrice = oneFoodItemandId.sizedFoodPrices;



    




//    logger.i('euroPrice1 :',euroPrice1);
//    tryCast(normalPrice);


//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');






    List<String> ingredientStringsForWhereInClause;

    if (defaultIngredientListForFood == null) {
      return Center(child: new LinearProgressIndicator(

//            valueColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.purpleAccent,
      ));
    }

    else if (defaultIngredientListForFood[0].ingredientName == 'None') {
      ingredientStringsForWhereInClause = [];

      // final List<dynamic> foodItemIngredientsList = oneFoodItemandId.ingredients;


      logger.i(
          'ingredientStringsForWhereInClause: $ingredientStringsForWhereInClause');


      //QQQQ
      // FUTURE USE.
      /*
    final List<NewIngredient> orderedItemsIngredients = new List<NewIngredient> ();


    ingredientStringsForWhereInClause.forEach((doc) {
      NewIngredient oneIngredient = new NewIngredient(

          ingredientName:doc,
          imageURL:'',
          price:1,
          documentId:'ss',
          ingredientAmountByUser:1


      );

      orderedItemsIngredients.add(oneIngredient);
    });
    */

      // CONDITION 1 WHEN TEST [INGREDIENT LIST] IS EMPTY

      // TEST CODE.
      return GestureDetector(
        onTap: () {
//        FocusScopeNode currentFocus = FocusScope.of(context);
//
//        if (!currentFocus.hasPrimaryFocus) {
//          currentFocus.unfocus();
//        }

          FocusScope.of(context).unfocus();
        },
        child:
        Scaffold(
          body:
          SafeArea(child:
          SingleChildScrollView(

            child:
            // MAIN COLUMN FOR THIS PAGE.
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

//      1ST CONTAINER STARTS HERE || BELOW ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                Container(

//                color: Color.fromRGBO(239, 239, 239, 1.0),
//                color: Color.fromRGBO(239, 239, 239, 1.0),
                  color: Color(0xffF7F0EC),

//                height:100,/
//              FROM 100 TO DYNAMIC HEIGHT: april 04
//              later on the same day changed to 13 and it is good in a 10 inch emulator
                  height: displayHeight(context) / 13,
                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      // 1ST CONTAINER AND NAVIGATION TO PREVIOUS PAGE. BEGINS HERE.
//                    from 30 to 22 -- april 04 2020, settled to 18.
                      Container(
                        height: displayHeight(context) / 18,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.chevron_left, size: 32.0),
//                            color: Colors.grey,
                              color: Color(0xff707070),

                              tooltip: MaterialLocalizations
                                  .of(context)
                                  .openAppDrawerTooltip,
                            ),
                            FlatButton(
//                color: Colors.blue,

                              textColor: Colors.white,

                              disabledColor: Colors.grey,

                              disabledTextColor: Colors.black,

                              padding: EdgeInsets.all(8.0),
//                splashColor: Colors.blueAccent,

                              onPressed: () => Navigator.pop(context),

                              child: Text('Go back to menu', style: TextStyle(
                                  fontWeight: FontWeight.bold,
//                                color: Colors.grey,
                                  color: Color(0xff707070),
                                  fontSize: 22),
                              ),
                            )

                          ],
                        ),
                      ),

                      // 1ST CONTAINER AND NAVIGATION TO PREVIOUS PAGE. ENDS HERE.


                      // 2ND CONTAINER AND TOTAL PRICE CART AT THE TOP OF DETAILS PAGE BEGINS HERE.
                      Container(
//                      height: displayHeight(context)/18,
//                      color: Color.fromARGB(255, 255,255,255),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // CONTAINER FOR TOTAL PRICE CART BELOW.
                            Container(
                              margin: EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                  right: displayWidth(context) / 40,
                                  bottom: 0
                              ),
//                                horizontal:0,
//                                vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
//                                      color: Color.fromRGBO(250, 200, 200, 1.0),
                                        color: Color(0xff54463E),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 2.0))
                                  ],
//                                color: Colors.black54),
//                                color:Color.fromRGBO(112,112,112,1)),
                                  color: Color(0xff54463E)
                              ),

                              width: displayWidth(context) / 5,
//                            height: displayHeight(context)/40,
                              height: displayHeight(context) / 30,
                              padding: EdgeInsets.only(
                                left: displayWidth(context) / 80,
                                top: 3,
                                bottom: 3,
//                                right: 4.5
                                right: displayWidth(context) / 40,
                              ),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    height: 25,
                                    width: 25,
                                    margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
//                                Spacer(),
                                  Text(totalCartPrice.toStringAsFixed(2) +
                                      ' kpl',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
//                                Spacer(),

                                ],
                              ),
                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.


                          ],

                        ),
                      ),


                      // 2ND CONTAINER AND TOTAL PRICE CART AT THE TOP OF DETAILS PAGE ENDS HERE.


                    ],
                  ),
                ),

                //      1ST CONTAINER ENDS HERE || ABOVE ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                //                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(

//                color:Color.fromRGBO(239, 239, 239, 1.0),
                  color: Color(0xffF7F0EC),
                  height: displayHeight(context) -
                      MediaQuery
                          .of(context)
                          .padding
                          .top - 100,
                  //where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.


                  //                  height: displayHeight(context) -
                  //                      MediaQuery.of(context).padding.top -
                  //                      kToolbarHeight,

                  child:

                  Row(
                    children: <Widget>[

                      // 1ST CONTAINER OF THIS ROW HANDLES THE BIG DETAIL PAGE IMAGE.
                      Container(
//                      height: 900,
//                      color:Color(0xffCCCCCC),
                        color: Color(0xffF7F0EC),
                        width: displayWidth(context) * 0.43,
//                      height: displayHeight(context)*0.50,

                        alignment: Alignment.centerLeft,
                        child: FoodDetailImage(oneFoodItemandId.imageURL,oneFoodItemandId.itemName),

                      ),
                      Container(
//                        color:Color(0xff007BF5),
                          color: Color(0xffF7F0EC),
                          width: displayWidth(context) * 0.57,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            <Widget>[

                              // ITEM NAME BEGINS BEGINS HERE.
                              Container(

                                child: Text(oneFoodItemandId.itemName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFF6005), fontSize: 30),
                                ),
                              ),


                              SizedBox(height: 40),
                              // ITEM NAME ENDS HERE.

                              // SIZE CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 0, 9, 9),
//                              borderOnForeground: true,

                                child:
                                Container(
                                    color: Color(0xffF7F0EC),
//                                  color:Color(0xffDAD7C3),
                                    width: displayWidth(context) * 0.57,
                                    child: Column(children: <Widget>[
// 1st container outsource below:

                                      Container(

                                        //      color: Colors.yellowAccent,
                                        height: 40,
                                        width: displayWidth(context) * 0.57,

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                            Container(child:

                                            Container(

                                              alignment: Alignment.topLeft,


                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
//                                              color: Colors.black54,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius
                                                        .circular(60)),
//                                              border: Border.all(
//                                                  width: 3
//                                                  ,color: Colors.green,
//                                                  style: BorderStyle.solid
//                                              )
                                              ),


                                              width: displayWidth(context) / 5,
//                                          height: displayHeight(context)/40,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child:

                                                Text('SIZE',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white
                                                    )
                                                ),
                                              ),

                                            ),

                                            ),

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                            // ENDED HERE.

                                            // BLACK CONTAINER WILL BE DELETED LATER.
                                            // BLACK CONTAINER.


                                          ],
                                        ),
                                      ),


//1st container.
                                      Container(

                                          child: GridView.builder(

//                                          itemCount: sizeConstantsList.length,
                                            itemCount: foodSizePrice.length,

                                            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 120,
//                                            maxCrossAxisExtent: 270,
//                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 0,
                                              // H  direction
//
                                              crossAxisSpacing: 0,


//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/Vertical
                                              childAspectRatio: 200 / 80,
//                                              crossAxisCount: 3
                                            ),

                                            itemBuilder: (_, int index) {
                                              String key = foodSizePrice.keys
                                                  .elementAt(index);
                                              dynamic value = foodSizePrice
                                                  .values.elementAt(index);
//                                            return new Row(
//                                              children: <Widget>[
//                                                new Text('${key} : '),
//                                                new Text(_countries[key])
//                                              ],
//                                            );

//                                            return _buildOneSize(/*sizeConstantsList[index]*/${key}, index);
                                              double valuePrice = tryCast<
                                                  double>(
                                                  value, fallback: 0.00);
                                              return _buildOneSize(
                                                  key, valuePrice, index);
                                            },

//                                new SliverGridDelegateWithMaxCrossAxisExtent(
//
//                                  maxCrossAxisExtent: 270,
//                                  mainAxisSpacing: 10, // H  direction
//                                  crossAxisSpacing: 0,
//
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
//                                  childAspectRatio: 220/200,
//
//
//                                ),


                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            shrinkWrap: true,

//                          childAspectRatio: 2.5, --bigger than 2.9


                                          )
                                      ),
                                    ],)

                                ),
                              ),

                              // SIZE CARD ENDS HERE.


                              SizedBox(height: 40),

                              // INGREDIENT CARD STARTS HERE.
                              Card(


                                margin: EdgeInsets.fromLTRB(0, 15, 9, 9),
//                              borderOnForeground: true,

                                child:
                                Container(

//                                  color:Color(0xffDAD7C3),
                                    color: Color(0xffF7F0EC),
                                    width: displayWidth(context) * 0.57,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
// 1st container outsource below:

                                        Container(

                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,

                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              Container(
                                                child:

                                                Container(

                                                  alignment: Alignment.topLeft,


                                                  decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                    color: Color.fromRGBO(
                                                        112, 112, 112, 1),
//                                              borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
////                                              )
                                                  ),


                                                  width: displayWidth(context) /
                                                      4.8,
//                                          height: displayHeight(context)/40,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child:

                                                    Text('INGREDIENTS',
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white
                                                        )
                                                    ),
                                                  ),

                                                ),


                                              ),

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              Container(

                                                decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                  color: Color(
                                                      0xffC27FFF),
                                                  borderRadius: BorderRadius
                                                      .circular(5),
                                                ),


//                                            color:Color(0xffC27FFF),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .lightbulb_outline,
                                                      size: 32.0,
                                                      color: Color(
                                                          0xffFFFFFF),),


                                                    Text(
                                                      'Long press to remove ingredient',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          color: Colors
                                                              .white,
                                                          fontSize: 15),
                                                    ),


                                                  ],
                                                ),

                                              ),



                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                              // ENDED HERE.

                                              // BLACK CONTAINER WILL BE DELETED LATER.
                                              // BLACK CONTAINER.


                                            ],
                                          ),
                                        ),


//1st container.


                                        // GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.


// GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.

                                        Container(
                                            color: Color(0xffF7F0EC),
                                            height: displayHeight(context) / 9,
                                            child:Container(alignment: Alignment.center,
                                              child:Text("No Ingredient"),
                                            )

//                                          LoadSelectedIngredients
//                                        child:LoadSelectedIngredients(firestore: firestore,)
//
//  =  filteredItems[index].ingredients;

                                        ),
                                        // Grid VIEW FOR INGREDIENT IMAGES ENDS HERE.

                                        // ADD MORE INGREDIENTS STARTS HERE.


                                        // ADD MORE INGREDIENTS STARTS HERE.

//                                    SizedBox(height:40),


                                        SizedBox(height: 10),
                                        Container(

                                          //      color: Colors.yellowAccent,
                                          height: displayHeight(context) / 30,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              Container(
                                                  child: GestureDetector(
//                                                onLongPress: (){
//                                                  print('at on Loong Press: ');
//                                                },
//                                                onLongPressUp: (){
//
//                                                },
                                                    onTap: () {
//        print('_handleRadioValueChange called from Widget categoryItem ');

//                                                  _handleRadioValueChange(index);

                                                      return Navigator.push(
                                                          context,

                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  MoreIngredients(
                                                                    oneFoodItemData1: oneFoodItemandId,
                                                                    onlyIngredientsNames1:ingredientStringsForWhereInClause,
                                                                  )
                                                            //oneFoodItem
//                                                          oneFoodItemandId
                                                          )
                                                      );
                                                    },
                                                    child: Container(
                                                      width: displayWidth(
                                                          context) * 0.33,
                                                      decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                        color: Color(
                                                            0xffFFFFFF),
                                                        borderRadius: BorderRadius
                                                            .circular(15),
                                                      ),


//                                            color:Color(0xffC27FFF),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.add,
                                                            size: 32.0,
                                                            color: Color
                                                                .fromRGBO(112,
                                                                112, 112, 1),
                                                            //        color: Color(0xffFFFFFF),
                                                          ),
                                                          Text(
                                                            'More Ingredients',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    112, 112,
                                                                    112, 1),
                                                                fontSize: 22),
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  )
                                              )


                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                              // ENDED HERE.

                                              // BLACK CONTAINER WILL BE DELETED LATER.
                                              // BLACK CONTAINER.


                                            ],
                                          ),
                                        ),
                                        // RRR
                                      ],)

                                ),
                              ),

                              // INGREDIENT CARD ENDS HERE.

                              SizedBox(height: 50),

                              // CHECKOUT CARD STARTS HERE.

                              // SIZE CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 15, 9, 9),

//                              borderOnForeground: true,

                                child:
                                Container(
                                    height: 230,
                                    color: Color(0xffF7F0EC),
//                                  color:Color(0xffDAD7C3),
                                    width: displayWidth(context) * 0.57,

                                    child: Column(
//                                    /sss///
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
// 1st container outsource below:

                                        // PRICE TEXT STARTS HERE . THE CORRESPONDING ROW IS BELOW.
                                        Container(


                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              Container(child:

                                              Container(

                                                alignment: Alignment.topLeft,


                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1),
//
                                                ),


                                                width: displayWidth(context) /
                                                    5,
//                                          height: displayHeight(context)/40,

                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child:

                                                  Text('PRICE',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                ),

                                              ),

                                              ),


                                            ],
                                          ),
                                        ),


                                        // PRICE AND INCREMENT BUTTONS ARE BELOW.
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 20),

                                          //      color: Colors.yellowAccent,
                                          height: displayHeight(context) / 18,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              //PPPPP


                                              Container(

                                                height: 45,
                                                // same as the heidth of increment decrement button.
                                                width: displayWidth(context) /
                                                    6,
                                                child:
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                      priceByQuantityANDSize
                                                          .toStringAsFixed(2) +
                                                          '\u20AC',
                                                      style: TextStyle(
                                                        fontSize: 30,
//                                                    color: Colors.white
//                                                    color:Color.fromRGBO(112,112,112,1),
                                                        color: Color(
                                                            0xff707070),

                                                        fontWeight: FontWeight
                                                            .bold,
                                                      )
                                                  ),),
//                                              margin:EdgeInsets.fromLTRB(
//                                                  20,15,0,0),

                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0),
                                              ),


                                              SizedBox(
                                                width: displayWidth(context) *
                                                    0.07,
                                              ),


                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0),

                                                width: displayWidth(context) /
                                                    5,
//                                              height: displayHeight(context) *0.11,
                                                height: 45,
                                                // same as the heidth of increment decrement button. // 45
                                                // later changed height to 40.
                                                decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                  color: Color(0xff8278FA),
                                                  borderRadius: BorderRadius
                                                      .circular(25),
                                                ),


//                                            color:Color(0xffC27FFF),
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      iconSize: 26,

                                                      tooltip: 'Increase product count by 1',
                                                      onPressed: () {
                                                        print(
                                                            'Add button pressed');
                                                        setState(() {
                                                          _itemCount =
                                                              _itemCount + 1;
                                                          priceByQuantityANDSize =

                                                              initialPriceByQuantityANDSize *
                                                                  _itemCount;
                                                        });
                                                      },
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      _itemCount.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .normal,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),

                                                    IconButton(
                                                      icon: Icon(Icons.remove),
                                                      iconSize: 26,
                                                      tooltip: 'Decrease product count by 1',
                                                      onPressed: () {
                                                        print(
                                                            'Decrease button pressed');
                                                        if (_itemCount > 1) {
                                                          setState(() {
                                                            _itemCount =
                                                                _itemCount - 1;
                                                            priceByQuantityANDSize =
                                                                initialPriceByQuantityANDSize *
                                                                    _itemCount;
                                                          });
                                                        }
                                                      },
//                              size: 24,
                                                      color: Colors.white,
                                                    ),
                                                  ],

                                                ),


                                              ),


                                            ],
                                          ),
                                        ),
                                        // PRICE AND INCREMENT BUTTONS ARE ABOVE.


                                        // add to CART BUTTONS ARE BELOW.
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 10),
//                                      alignment: Alignment.centerLeft,

                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.28,

                                          child: InkWell(
                                            onTap: () {
                                              print('_submitbuttonTapped()');
//                            _getAndScanImage();


                                            },
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            250, 200, 200, 1.0),
                                                        blurRadius: 10.0,
                                                        offset: Offset(0.0, 4.0)
                                                    )
                                                  ],
                                                  color: Colors.redAccent),
                                              width: 140.0,
//                                            height: 35.0,
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 3,
                                                  bottom: 3,
                                                  right: 4.5),
                                              child: Row(
                                                children: <Widget>[
                                                  Text('ADD TO CART',
                                                      style: TextStyle(
                                                          fontSize: 26,
                                                          color: Colors.white)),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // add to CART BUTTONS ARE ABOVE.

                                        // PRICE TEXT STARTS HERE . THE CORRESPONDING ROW IS ABOVE.


                                        // CHECKOUT AND CONTINUE BUTTON: STARTS HERE.


                                        // CHECKOUT AND CONTINUE BUTTON ENDS HERE.


                                      ],)

                                ),
                              ),

                              // SIZE CARD ENDS HERE.
                              // CHECKOUT CARD ENDS HERE

                              SizedBox(height: 20),


                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                height: 60,
//                                color:Color(0xffDAD7C3),
                                width: displayWidth(context) * 0.57,


                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      // CONTAINER  FOR CHECKOUT
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            print('_submitbuttonTapped()');
//                            _getAndScanImage();


                                          },
                                          child: Container(
                                              height: 47,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                color: Colors.white,

//                                            color: Color.fromRGBO(239, 239, 239, 0), // some kind of white.
                                              ),
//                                                color: Colors.redAccent),
                                              width: displayWidth(context) *
                                                  0.25,
//                                            width: 140.0,
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 20
                                              ),
//                                            height: 35.0,

                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text('CHECK OUT',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )


                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      // CONTAINER  FOR CONTINUE.


                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            print('_submitbuttonTapped()');
//                            _getAndScanImage();
                                          },
                                          child: Container(
                                            height: 47,


                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              color: Colors.white,

                                            ),
//                                            width: 140.0,
                                            width: displayWidth(context) * 0.25,
//                                            height: 35.0,
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                top: 0,
                                                bottom: 0,
                                                right: 20
                                            ),

                                            child: Container(
                                              alignment: Alignment.center,
                                              child:
                                              Text('CONTINUE',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ]
                                )
                                ,


//
                              )

                              ,
//

                            ],
                          )
                      )

                    ],
                  ),
                ),


              ],
            )
            ,)

          ),
        ),
      );
    }


    else {
      // CONDITION 2 WHEN TEST [INGREDIENT LIST IS NOT EMPTY]


      ingredientStringsForWhereInClause =
          defaultIngredientListForFood.map((oneIngredient)=> oneIngredient.ingredientName).toList();


      print('at else where $ingredientStringsForWhereInClause is not empty');

      return GestureDetector(
        onTap: () {
//        FocusScopeNode currentFocus = FocusScope.of(context);
//
//        if (!currentFocus.hasPrimaryFocus) {
//          currentFocus.unfocus();
//        }

          FocusScope.of(context).unfocus();
        },
        child:
        Scaffold(
          body:
          SafeArea(child:
          SingleChildScrollView(

            child:
            // MAIN COLUMN FOR THIS PAGE.
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

//      1ST CONTAINER STARTS HERE || BELOW ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                Container(

//                color: Color.fromRGBO(239, 239, 239, 1.0),
//                color: Color.fromRGBO(239, 239, 239, 1.0),
                  color: Color(0xffF7F0EC),

//                height:100,/
//              FROM 100 TO DYNAMIC HEIGHT: april 04
//              later on the same day changed to 13 and it is good in a 10 inch emulator
                  height: displayHeight(context) / 13,
                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      // 1ST CONTAINER AND NAVIGATION TO PREVIOUS PAGE. BEGINS HERE.
//                    from 30 to 22 -- april 04 2020, settled to 18.
                      Container(
                        height: displayHeight(context) / 18,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.chevron_left, size: 32.0),
//                            color: Colors.grey,
                              color: Color(0xff707070),

                              tooltip: MaterialLocalizations
                                  .of(context)
                                  .openAppDrawerTooltip,
                            ),
                            FlatButton(
//                color: Colors.blue,

                              textColor: Colors.white,

                              disabledColor: Colors.grey,

                              disabledTextColor: Colors.black,

                              padding: EdgeInsets.all(8.0),
//                splashColor: Colors.blueAccent,

                              onPressed: () => Navigator.pop(context),

                              child: Text('Go back to menu', style: TextStyle(
                                  fontWeight: FontWeight.bold,
//                                color: Colors.grey,
                                  color: Color(0xff707070),
                                  fontSize: 22),
                              ),
                            )

                          ],
                        ),
                      ),

                      // 1ST CONTAINER AND NAVIGATION TO PREVIOUS PAGE. ENDS HERE.


                      // 2ND CONTAINER AND TOTAL PRICE CART AT THE TOP OF DETAILS PAGE BEGINS HERE.
                      Container(
//                      height: displayHeight(context)/18,
//                      color: Color.fromARGB(255, 255,255,255),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // CONTAINER FOR TOTAL PRICE CART BELOW.
                            Container(
                              margin: EdgeInsets.only(
                                  left: 0,
                                  top: 0,
                                  right: displayWidth(context) / 40,
                                  bottom: 0
                              ),
//                                horizontal:0,
//                                vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
//                                      color: Color.fromRGBO(250, 200, 200, 1.0),
                                        color: Color(0xff54463E),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 2.0))
                                  ],
//                                color: Colors.black54),
//                                color:Color.fromRGBO(112,112,112,1)),
                                  color: Color(0xff54463E)
                              ),

                              width: displayWidth(context) / 5,
//                            height: displayHeight(context)/40,
                              height: displayHeight(context) / 30,
                              padding: EdgeInsets.only(
                                left: displayWidth(context) / 80,
                                top: 3,
                                bottom: 3,
//                                right: 4.5
                                right: displayWidth(context) / 40,
                              ),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    height: 25,
                                    width: 25,
                                    margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
//                                Spacer(),
                                  Text(totalCartPrice.toStringAsFixed(2) +
                                      ' kpl',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
//                                Spacer(),

                                ],
                              ),
                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.


                          ],

                        ),
                      ),


                      // 2ND CONTAINER AND TOTAL PRICE CART AT THE TOP OF DETAILS PAGE ENDS HERE.


                    ],
                  ),
                ),

                //      1ST CONTAINER ENDS HERE || ABOVE ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                //                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(

//                color:Color.fromRGBO(239, 239, 239, 1.0),
                  color: Color(0xffF7F0EC),
                  height: displayHeight(context) -
                      MediaQuery
                          .of(context)
                          .padding
                          .top - 100,
                  //where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.


                  //                  height: displayHeight(context) -
                  //                      MediaQuery.of(context).padding.top -
                  //                      kToolbarHeight,

                  child:

                  Row(
                    children: <Widget>[

                      // 1ST CONTAINER OF THIS ROW HANDLES THE BIG DETAIL PAGE IMAGE.
                      Container(
//                      height: 900,
//                      color:Color(0xffCCCCCC),
                        color: Color(0xffF7F0EC),
                        width: displayWidth(context) * 0.43,
//                      height: displayHeight(context)*0.50,

                        alignment: Alignment.centerLeft,
                        child: FoodDetailImage(oneFoodItemandId.imageURL,oneFoodItemandId.itemName),

                      ),
                      Container(
//                        color:Color(0xff007BF5),
                          color: Color(0xffF7F0EC),
                          width: displayWidth(context) * 0.57,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            <Widget>[

                              // ITEM NAME BEGINS BEGINS HERE.
                              Container(

                                child: Text(oneFoodItemandId.itemName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFF6005), fontSize: 30),
                                ),
                              ),


                              SizedBox(height: 40),
                              // ITEM NAME ENDS HERE.

                              // SIZE CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 0, 9, 9),
//                              borderOnForeground: true,

                                child:
                                Container(
                                    color: Color(0xffF7F0EC),
//                                  color:Color(0xffDAD7C3),
                                    width: displayWidth(context) * 0.57,
                                    child: Column(children: <Widget>[
// 1st container outsource below:

                                      Container(

                                        //      color: Colors.yellowAccent,
                                        height: 40,
                                        width: displayWidth(context) * 0.57,

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                            Container(child:

                                            Container(

                                              alignment: Alignment.topLeft,


                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
//                                              color: Colors.black54,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius
                                                        .circular(60)),
//                                              border: Border.all(
//                                                  width: 3
//                                                  ,color: Colors.green,
//                                                  style: BorderStyle.solid
//                                              )
                                              ),


                                              width: displayWidth(context) / 5,
//                                          height: displayHeight(context)/40,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child:

                                                Text('SIZE',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white
                                                    )
                                                ),
                                              ),

                                            ),

                                            ),

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                            // ENDED HERE.

                                            // BLACK CONTAINER WILL BE DELETED LATER.
                                            // BLACK CONTAINER.


                                          ],
                                        ),
                                      ),


//1st container.
                                      Container(

                                          child: GridView.builder(

//                                          itemCount: sizeConstantsList.length,
                                            itemCount: foodSizePrice.length,

                                            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 120,
//                                            maxCrossAxisExtent: 270,
//                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 0,
                                              // H  direction
//
                                              crossAxisSpacing: 0,


//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/Vertical
                                              childAspectRatio: 200 / 80,
//                                              crossAxisCount: 3
                                            ),

                                            itemBuilder: (_, int index) {
                                              String key = foodSizePrice.keys
                                                  .elementAt(index);
                                              dynamic value = foodSizePrice
                                                  .values.elementAt(index);
//                                            return new Row(
//                                              children: <Widget>[
//                                                new Text('${key} : '),
//                                                new Text(_countries[key])
//                                              ],
//                                            );

//                                            return _buildOneSize(/*sizeConstantsList[index]*/${key}, index);
                                              double valuePrice = tryCast<
                                                  double>(
                                                  value, fallback: 0.00);
                                              return _buildOneSize(
                                                  key, valuePrice, index);
                                            },

//                                new SliverGridDelegateWithMaxCrossAxisExtent(
//
//                                  maxCrossAxisExtent: 270,
//                                  mainAxisSpacing: 10, // H  direction
//                                  crossAxisSpacing: 0,
//
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
//                                  childAspectRatio: 220/200,
//
//
//                                ),


                                            controller: new ScrollController(
                                                keepScrollOffset: false),
                                            shrinkWrap: true,

//                          childAspectRatio: 2.5, --bigger than 2.9


                                          )
                                      ),
                                    ],)

                                ),
                              ),

                              // SIZE CARD ENDS HERE.


                              SizedBox(height: 40),

                              // INGREDIENT CARD STARTS HERE.
                              Card(


                                margin: EdgeInsets.fromLTRB(0, 15, 9, 9),
//                              borderOnForeground: true,

                                child:
                                Container(

//                                  color:Color(0xffDAD7C3),
                                    color: Color(0xffF7F0EC),
                                    width: displayWidth(context) * 0.57,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
// 1st container outsource below:

                                        Container(

                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,

                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              Container(
                                                child:

                                                Container(

                                                  alignment: Alignment.topLeft,


                                                  decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                    color: Color.fromRGBO(
                                                        112, 112, 112, 1),
//                                              borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
////                                              )
                                                  ),


                                                  width: displayWidth(context) /
                                                      4.8,
//                                          height: displayHeight(context)/40,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child:

                                                    Text('INGREDIENTS',
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white
                                                        )
                                                    ),
                                                  ),

                                                ),


                                              ),

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              Container(

                                                decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                  color: Color(
                                                      0xffC27FFF),
                                                  borderRadius: BorderRadius
                                                      .circular(5),
                                                ),


//                                            color:Color(0xffC27FFF),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .lightbulb_outline,
                                                      size: 32.0,
                                                      color: Color(
                                                          0xffFFFFFF),),


                                                    Text(
                                                      'Long press to remove ingredient',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          color: Colors
                                                              .white,
                                                          fontSize: 15),
                                                    ),


                                                  ],
                                                ),

                                              ),

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                              // ENDED HERE.

                                              // BLACK CONTAINER WILL BE DELETED LATER.
                                              // BLACK CONTAINER.


                                            ],
                                          ),
                                        ),


//1st container.


                                        // GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.


// GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.

                                        Container(
                                          color: Color(0xffF7F0EC),
                                          height: displayHeight(context) / 9,
//                                            child: LoadSelectedIngredients(
//                                                firestore: firestore,
//                                                oneFoodItemandId: oneFoodItemandId
//                                            )

                                          child:
                                          StreamBuilder<QuerySnapshot>(
//        stream: firestore
//            .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
//            .collection('ingredients').where(
//            'name', whereIn: [a1,a2,a3,a4]
//
//        ).snapshots(),

                                            stream: firestore
                                                .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
                                                .collection('ingredients').where(
                                                'name', whereIn: ingredientStringsForWhereInClause

                                            ).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Center(child: new LinearProgressIndicator(

//            valueColor: Colors.deepOrangeAccent,
                                                  backgroundColor: Colors.purpleAccent,
                                                ));

                                              else {
                                                final int ingredientCount = snapshot.data.documents.length;
                                                print('ingredientCount: $ingredientCount');
                                                return (

                                                    GridView.builder(
                                                      itemCount: ingredientCount,

                                                      gridDelegate:
                                                      new SliverGridDelegateWithMaxCrossAxisExtent(

                                                        maxCrossAxisExtent: 180,
                                                        mainAxisSpacing: 6, // Vertical  direction
                                                        crossAxisSpacing: 5,
                                                        childAspectRatio: 200/240,

                                                        /*
                                                            mainAxisSpacing: 5,
                                                            // H  direction
//
                                                            crossAxisSpacing: 10,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                                                            // horizontal / vertical
                                                            childAspectRatio: 220 / 450,

                                                            crossAxisCount: 4

                                                             */
                                                      ),


//              new SliverGridDelegateWithMaxCrossAxisExtent(
//                maxCrossAxisExtent: 270,
//                mainAxisSpacing: 20, // H  direction
//                crossAxisSpacing: 0,
//
//                ///childAspectRatio:
//                /// The ratio of the cross-axis to the main-axis extent of each child.
//                /// H/V
//                childAspectRatio: 160/220,
//
//              ),
                                                      shrinkWrap: false,

                                                      itemBuilder: (_, int index) {
                                                        final DocumentSnapshot document = snapshot.data
                                                            .documents[index];
                                                        final dynamic ingredientName = document['name'];
//                  final dynamic ingredientImageURL = document['image'];
                                                        final num ingredientPrice = document['price'];

                                                        final dynamic ingredientImageURL = document['image'] == '' ?
                                                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
                                                            :
                                                        storageBucketURLPredicate +
                                                            Uri.encodeComponent(document['image'])

                                                            + '?alt=media';

                                                        final NewIngredient ingredientItemTest = new NewIngredient(
//                FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(

                                                          ingredientName: ingredientName,

                                                          imageURL: ingredientImageURL,
                                                          price: ingredientPrice.toDouble(),
//                    ingredientId:ingredientItemId,
//
//                    isAvailable: ingredientIsAvailable,
                                                          documentId: document.documentID,

                                                        );


//                                                        logger.i('ingredientImageURL: ',ingredientImageURL);

                                                        return
                                                          Container(
                                                            color: Color.fromRGBO(239, 239, 239, 0),
                                                            padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
                                                                horizontal: 4.0, vertical: 15.0),
                                                            child: GestureDetector(
                                                                onLongPress: () {
                                                                  print(
                                                                      'at Long Press: ');
                                                                },
                                                                onLongPressUp: (){
                                                                  logger.i('test.length',ingredientStringsForWhereInClause.length);
                                                                  print('at Long Press UP');
                                                                  ingredientStringsForWhereInClause.removeAt(index);
                                                                  logger.i('test.length after removing: ',
                                                                      ingredientStringsForWhereInClause.length);
                                                                  defaultIngredientListForFood.removeAt(index);
                                                                  Order initialOrder = new Order(
                                                                    foodItemName: oneFoodItemandId.itemName,
                                                                    foodItemImageURL:oneFoodItemandId.imageURL,
                                                                    unitPrice:initialPriceByQuantityANDSize,
                                                                    foodDocumentId:oneFoodItemandId.documentId,
                                                                    quantity:_itemCount,
                                                                    foodItemSize:_currentSize,
//                                                                    foodItemOrderID:,
                                                                    ingredients:defaultIngredientListForFood,
                                                                  );


//                                                                  TO DO UPDATE WITH setState(() ) call the current
//                                                                Order
                                                                  setState(() {
                                                                    oneOrder= initialOrder;

//                                                                    _itemCount =
//                                                                        _itemCount + 1;
//                                                                    priceByQuantityANDSize =
//
//                                                                        initialPriceByQuantityANDSize *
//                                                                            _itemCount;
                                                                  });
                                                                },
                                                                child: Column(
                                                                  children: <Widget>[

                                                                    new Container(

                                                                      width: displayWidth(context) * 0.09,
                                                                      height: displayWidth(context) * 0.11,

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
//                              SizedBox(height: 10),
                                                                    Text(

                                                                      ingredientName,

                                                                      style: TextStyle(
                                                                        color: Color.fromRGBO(112, 112, 112, 1),
//                                    color: Colors.blueGrey[800],

                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 18,
                                                                      ),
                                                                    )
                                                                    ,


                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  print('for future use');
//                            return Navigator.push(context,
//
//                                MaterialPageRoute(builder: (context)
//                                => FoodItemDetails())
//                            );
                                                                }
                                                            ),
                                                          );
                                                      },

                                                    )

                                                );
                                              }
                                            },





                                          ),

//                                          LoadSelectedIngredients
//                                        child:LoadSelectedIngredients(firestore: firestore,)

//

//  =  filteredItems[index].ingredients;

                                        ),
                                        // Grid VIEW FOR INGREDIENT IMAGES ENDS HERE.

                                        // ADD MORE INGREDIENTS STARTS HERE.


                                        // ADD MORE INGREDIENTS STARTS HERE.

//                                    SizedBox(height:40),


                                        SizedBox(height: 10),
                                        Container(

                                          //      color: Colors.yellowAccent,
                                          height: displayHeight(context) / 30,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              Container(
                                                  child: GestureDetector(
//                                                onLongPress: (){
//                                                  print('at on Loong Press: ');
//                                                },
//                                                onLongPressUp: (){
//
//                                                },
                                                    onTap: () {
//        print('_handleRadioValueChange called from Widget categoryItem ');

//                                                  _handleRadioValueChange(index);

                                                      return Navigator.push(
                                                          context,

                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  MoreIngredients(
                                                                    oneFoodItemData1: oneFoodItemandId,
                                                                    onlyIngredientsNames1:ingredientStringsForWhereInClause,
                                                                  )
                                                            //oneFoodItem
//                                                          oneFoodItemandId
                                                          )
                                                      );
                                                    },
                                                    child: Container(
                                                      width: displayWidth(
                                                          context) * 0.33,
                                                      decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                        color: Color(
                                                            0xffFFFFFF),
                                                        borderRadius: BorderRadius
                                                            .circular(15),
                                                      ),


//                                            color:Color(0xffC27FFF),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.add,
                                                            size: 32.0,
                                                            color: Color
                                                                .fromRGBO(112,
                                                                112, 112, 1),
                                                            //        color: Color(0xffFFFFFF),
                                                          ),
                                                          Text(
                                                            'More Ingredients',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    112, 112,
                                                                    112, 1),
                                                                fontSize: 22),
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  )
                                              )


                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                              // ENDED HERE.

                                              // BLACK CONTAINER WILL BE DELETED LATER.
                                              // BLACK CONTAINER.


                                            ],
                                          ),
                                        ),
                                        // RRR
                                      ],)

                                ),
                              ),

                              // INGREDIENT CARD ENDS HERE.

                              SizedBox(height: 50),

                              // CHECKOUT CARD STARTS HERE.

                              // SIZE CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 15, 9, 9),

//                              borderOnForeground: true,

                                child:
                                Container(
                                    height: 230,
                                    color: Color(0xffF7F0EC),
//                                  color:Color(0xffDAD7C3),
                                    width: displayWidth(context) * 0.57,

                                    child: Column(
//                                    /sss///
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
// 1st container outsource below:

                                        // PRICE TEXT STARTS HERE . THE CORRESPONDING ROW IS BELOW.
                                        Container(


                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              Container(child:

                                              Container(

                                                alignment: Alignment.topLeft,


                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1),
//
                                                ),


                                                width: displayWidth(context) /
                                                    5,
//                                          height: displayHeight(context)/40,

                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child:

                                                  Text('PRICE',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                ),

                                              ),

                                              ),


                                            ],
                                          ),
                                        ),


                                        // PRICE AND INCREMENT BUTTONS ARE BELOW.
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 20),

                                          //      color: Colors.yellowAccent,
                                          height: displayHeight(context) / 18,
                                          width: displayWidth(context) * 0.57,

                                          child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[

                                              // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                              // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                              //PPPPP


                                              Container(

                                                height: 45,
                                                // same as the heidth of increment decrement button.
                                                width: displayWidth(context) /
                                                    6,
                                                child:
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                      priceByQuantityANDSize
                                                          .toStringAsFixed(2) +
                                                          '\u20AC',
                                                      style: TextStyle(
                                                        fontSize: 30,
//                                                    color: Colors.white
//                                                    color:Color.fromRGBO(112,112,112,1),
                                                        color: Color(
                                                            0xff707070),

                                                        fontWeight: FontWeight
                                                            .bold,
                                                      )
                                                  ),),
//                                              margin:EdgeInsets.fromLTRB(
//                                                  20,15,0,0),

                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0),
                                              ),


                                              SizedBox(
                                                width: displayWidth(context) *
                                                    0.07,
                                              ),


                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                    vertical: 0),

                                                width: displayWidth(context) /
                                                    5,
//                                              height: displayHeight(context) *0.11,
                                                height: 45,
                                                // same as the heidth of increment decrement button. // 45
                                                // later changed height to 40.
                                                decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                  color: Color(0xff8278FA),
                                                  borderRadius: BorderRadius
                                                      .circular(25),
                                                ),


//                                            color:Color(0xffC27FFF),
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      iconSize: 26,

                                                      tooltip: 'Increase product count by 1',
                                                      onPressed: () {
                                                        print(
                                                            'Add button pressed');
                                                        setState(() {
                                                          _itemCount =
                                                              _itemCount + 1;
                                                          priceByQuantityANDSize =

                                                              initialPriceByQuantityANDSize *
                                                                  _itemCount;
                                                        });
                                                      },
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      _itemCount.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .normal,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),

                                                    IconButton(
                                                      icon: Icon(Icons.remove),
                                                      iconSize: 26,
                                                      tooltip: 'Decrease product count by 1',
                                                      onPressed: () {
                                                        print(
                                                            'Decrease button pressed');
                                                        if (_itemCount > 1) {
                                                          setState(() {
                                                            _itemCount =
                                                                _itemCount - 1;
                                                            priceByQuantityANDSize =
                                                                initialPriceByQuantityANDSize *
                                                                    _itemCount;
                                                          });
                                                        }
                                                      },
//                              size: 24,
                                                      color: Colors.white,
                                                    ),
                                                  ],

                                                ),


                                              ),


                                            ],
                                          ),
                                        ),
                                        // PRICE AND INCREMENT BUTTONS ARE ABOVE.


                                        // add to CART BUTTONS ARE BELOW.
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 10),
//                                      alignment: Alignment.centerLeft,

                                          //      color: Colors.yellowAccent,
                                          height: 40,
                                          width: displayWidth(context) * 0.28,

                                          child: InkWell(
                                            onTap: () {
                                              print('_submitbuttonTapped()');
//                            _getAndScanImage();


                                            },
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            250, 200, 200, 1.0),
                                                        blurRadius: 10.0,
                                                        offset: Offset(0.0, 4.0)
                                                    )
                                                  ],
                                                  color: Colors.redAccent),
                                              width: 140.0,
//                                            height: 35.0,
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 3,
                                                  bottom: 3,
                                                  right: 4.5),
                                              child: Row(
                                                children: <Widget>[
                                                  Text('ADD TO CART',
                                                      style: TextStyle(
                                                          fontSize: 26,
                                                          color: Colors.white)),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // add to CART BUTTONS ARE ABOVE.

                                        // PRICE TEXT STARTS HERE . THE CORRESPONDING ROW IS ABOVE.


                                        // CHECKOUT AND CONTINUE BUTTON: STARTS HERE.


                                        // CHECKOUT AND CONTINUE BUTTON ENDS HERE.


                                      ],)

                                ),
                              ),

                              // SIZE CARD ENDS HERE.
                              // CHECKOUT CARD ENDS HERE

                              SizedBox(height: 20),


                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                height: 60,
//                                color:Color(0xffDAD7C3),
                                width: displayWidth(context) * 0.57,


                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      // CONTAINER  FOR CHECKOUT
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            print('_submitbuttonTapped()');
//                            _getAndScanImage();


                                          },
                                          child: Container(
                                              height: 47,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                color: Colors.white,

//                                            color: Color.fromRGBO(239, 239, 239, 0), // some kind of white.
                                              ),
//                                                color: Colors.redAccent),
                                              width: displayWidth(context) *
                                                  0.25,
//                                            width: 140.0,
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 20
                                              ),
//                                            height: 35.0,

                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text('CHECK OUT',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )


                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      // CONTAINER  FOR CONTINUE.


                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            print('_submitbuttonTapped()');
//                            _getAndScanImage();
                                          },
                                          child: Container(
                                            height: 47,


                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              color: Colors.white,

                                            ),
//                                            width: 140.0,
                                            width: displayWidth(context) * 0.25,
//                                            height: 35.0,
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                top: 0,
                                                bottom: 0,
                                                right: 20
                                            ),

                                            child: Container(
                                              alignment: Alignment.center,
                                              child:
                                              Text('CONTINUE',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ]
                                )
                                ,


//
                              )

                              ,
//

                            ],
                          )
                      )

                    ],
                  ),
                ),


              ],
            )
            ,)

          ),
        ),
      );
    }

  }







  Widget _buildOneSize(String oneSize,double onePriceForSize, int index) {



//    logger.i('oneSize: $oneSize');
//    logger.i('onePriceForSize: $onePriceForSize');

    return InkWell(
      onTap: () {

        setState(() {
          initialPriceByQuantityANDSize = onePriceForSize;
          priceByQuantityANDSize = onePriceForSize;
          _currentSize= oneSize;
        });
//        print('_handleRadioValueChange called from Widget categoryItem ');

//        _handleRadioValueChange(index);
      },
      child:Container(

        height:displayHeight(context)/30,
        width:displayWidth(context)/10,

        child:  oneSize.toLowerCase() == _currentSize  ?
        (
            Card(

              color: Colors.lightGreenAccent,
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

                alignment: Alignment.center,
                child: Text(
                  oneSize.toUpperCase(), style:
                TextStyle(
                    color:Color(0xff707070),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                ),
              ),
            )
        ):
        (
            Card(

              color: Color(0xffFEE295),
              borderOnForeground: true,

              elevation: 2.5,
              clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
              shape:RoundedRectangleBorder(

                side: BorderSide(
                  color: Color(0xffF7F0EC),
                  style: BorderStyle.solid,
                ),
//                BorderStyle(
//                  BorderStyle.solid,
//                )
                borderRadius: BorderRadius.circular(35.0),
              ),
              child:Container(

                alignment: Alignment.center,
                child: Text(
                  oneSize.toUpperCase(), style:
                TextStyle(
                    color:Color(0xff707070),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                ),
              ),
            )
        ),



      ),
    );
  }
//  child:MessageList(firestore: firestore),

}


//  FoodDetailImage




class FoodDetailImage extends StatelessWidget {


  final String imageURLBig;
  final String foodItemName;
  FoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {


    return Transform.translate(
      offset:Offset(-displayWidth(context)/22,0),

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
      // -displayWidth(context)/9

      child:NeuCard(
        // State of Neumorphic (may be convex, flat & emboss)
        curveType: CurveType.concave,
//            padding: EdgeInsets.symmetric(horizontal: 3,vertical:0),
//        margin: EdgeInsets.fromLTRB(12, 0, 5, 0),

        // Elevation relative to parent. Main constituent of Neumorphism
//            bevel: 12,

        // Specified decorations, like `BoxDecoration` but only limited
        decoration: NeumorphicDecoration(
//          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.circle,
          clipBehavior: Clip.antiAlias,
          color: Color(0xffFFFFFF),
        ),child:

      Hero(
        tag: foodItemName,
        child:

        ClipOval(child:
        Container(
          color:Color(0xffFFFFFF),
          alignment:Alignment.centerLeft,
//        width: 600,
          height:650,
          child:
          ClipOval(
            child: CachedNetworkImage(
              height:630,
              imageUrl: imageURLBig,
//            fit: BoxFit.fitHeight,
              fit: BoxFit.cover,

              placeholder: (context, url) => new CircularProgressIndicator(),

            ),
          ),
        ),
        ),
      ),
      ),

//                Image.network(imageURLBig)

    );


  }


}


class CustomRect extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    print('at get Clip');
//    Rect rect = Rect.fromLTRB(100, 0.0, size.width, size.height);
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    return rect;
    // TODO: implement getClip
  }
  @override
  bool shouldReclip(CustomRect oldClipper) {
    // TODO: implement shouldReclip
    //    return true;
    return false;
  }
}


class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0); // (x,h) =(width,0)
    path.lineTo(size.width - 1, size.height- 1);
    path.lineTo(size.width - 2, size.height- 2);
    path.lineTo(size.width - 3, size.height- 3);
    path.lineTo(size.width - 4, size.height- 4);
    path.lineTo(size.width - 5, size.height- 5);
    path.lineTo(size.width - 6, size.height- 6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}


