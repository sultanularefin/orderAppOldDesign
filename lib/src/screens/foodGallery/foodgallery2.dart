
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


// MODEL'S IMPORT BEGINS HERE.
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';

import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails2.dart';


import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';

import 'package:logger/logger.dart';


import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screen files.
import 'package:foodgallery/src/welcomePage.dart';


import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/newCategory.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';

import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';

import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

class FoodGallery2 extends StatefulWidget {


  final Widget child;


  FoodGallery2({Key key, this.child}) : super(key: key);

  _FoodGalleryState createState() => _FoodGalleryState();

}


class _FoodGalleryState extends State<FoodGallery2> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  _FoodGalleryState(/*{firestore} */);


  String _searchString = '';
  String _currentCategory = "pizza";
  String _firstTimeCategoryString = "";

//  this can be defined in Shopping cart page like old way
  int _totalCount = 0;
  List<SelectedFood> allSelectedFoodGallery = [];
  double totalPriceState = 0;

  Order orderFG = new Order(
    selectedFoodInOrder: [],
    selectedFoodListLength:0,
    orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
    paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
    orderingCustomer: null,
    totalPrice: 0,
    page:0,
  );



  double tryCast<num>(dynamic x, {num fallback }) {

    bool status = x is num;

    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }


  var logger = Logger(
    printer: PrettyPrinter(),
  );



  Future<void> logout(BuildContext context2) async {
    print('what i do is : ||Logout||');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();


    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {

          return BlocProvider<IdentityBloc>(
              bloc: IdentityBloc(),

              child: WelcomePage(fromWhicPage:'foodGallery2')
          );


        }),(Route<dynamic> route) => false);


  }







  @override
  Widget build(BuildContext context) {


    final blocG = BlocProvider.of<FoodGalleryBloc>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:
      Scaffold(
        key: _scaffoldKey,

        body:
        SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child:

                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[


//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.

                    Expanded(
                        child: Column(

                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[

                              Container(
                                height: displayHeight(context) / 14,
                                color: Color(0xffFFFFFF),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[

                                    // image and string JEDILINE BEGINS HERE.
                                    SizedBox(
                                      height: kToolbarHeight+6,
                                      width: 200,
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Container(

                                            height: displayHeight(context) / 15,
//                                            color:Colors.blue,
                                            child: Image.asset('assets/Path2008.png'),

                                          ),
                                          Container(

                                            margin: EdgeInsets.symmetric(
                                                horizontal: 0,
                                                vertical: 0),

//                                          width: displayWidth(context) / 6,
                                            height: displayHeight(context) / 15,
//                                            color:Colors.red,
                                            child:

//                                          Container(child: Image.asset('assets/Path2008.png')),
                                            Container(
                                              padding:EdgeInsets.fromLTRB(0,1,0,0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Jediline',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 30,
                                                        color: Color(0xff07D607),
                                                        fontFamily: 'Itim-Regular'),
                                                  ),
                                                  Text(
                                                    'Online Orders',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontSize: 16.42,color: Color(0xff07D607)),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ),

                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 3,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 25.0,
                                              // USER INPUT
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),

                                      ),
                                      // USER INPUT

                                      width: displayWidth(context) / 3.3,
                                      height: displayHeight(context) / 27,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

                                            height:displayWidth(context)/34,
//                                          height: 25,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0,right:15,bottom: 5),

                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.search,
//                                            size: 28,
                                              size: displayWidth(context)/24,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(

                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4.7,

                                            child: TextField(
                                              decoration: InputDecoration(

                                                border: InputBorder.none,


//                                        labelText: 'Search about meal.'
                                              ),
                                              onChanged: (text) {
//                                              logger.i('on onChanged of condition 4');

                                                setState(() =>
                                                _searchString = text);
                                                print(
                                                    "First text field from Condition 04: $text");
                                              },
                                              onTap: () {
                                                print('condition 4');
//                                              logger.i('on Tap of condition 4');
                                                setState(() {
                                                  _firstTimeCategoryString =
                                                  'PIZZA';
                                                });
                                              },

                                              onEditingComplete: () {
//                                              logger.i('onEditingComplete  of condition 4');
                                                print(
                                                    'called onEditing complete');
                                                setState(() =>
                                                _searchString = "");
                                              },

                                              onSubmitted: (String value) async {
                                                await showDialog<void>(
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Thanks!'),
                                                      content: Text(
                                                          'You typed "$value".'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),

                                          )


                                        ],
                                      ),
                                    ),

                                    Container(

                                      child: shoppingCartWidget(context), // CLASS TO WIDGET SINCE I NEED TO INVOKE THE

                                    ),


                                  ],
                                ),
                              ),



                              // CONTAINER FOR TOTAL PRICE CART ABOVE.
                              Container(
                                height: displayHeight(context) -
                                    MediaQuery
                                        .of(context)
                                        .padding
                                        .top -  displayHeight(context) / 14,
                                padding: EdgeInsets.fromLTRB(
                                    5, 0, 5, 0),
                                // FOR CATEGORY SERARCH.

                                child: foodList(_currentCategory,_searchString,
                                    context /*allIngredients:_allIngredientState */),

                              ),

                            ]
                        )
                    ),

                    Container(
                      height: displayHeight(context) -
                          MediaQuery
                              .of(context)
                              .padding
                              .top,


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: 20, right: 20, bottom: 0, left: 0),

                            height: displayHeight(context) / 14,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3.8,

                            color: Color(0xffFFE18E),

                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () async {
                                print(
                                    'Menu button pressed');


                              },
                              icon: const Icon(Icons.menu, size: 32.0),

                              color: Color(0xff54463E),

                              tooltip: MaterialLocalizations
                                  .of(context)
                                  .openAppDrawerTooltip,
                            ),

                          ),


                          Container(
                            height: displayHeight(context) -
                                MediaQuery
                                    .of(context)
                                    .padding
                                    .top - displayHeight(context) / 14,

                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 3.8,

                            color: Color(0xffFFE18E),

                            child: StreamBuilder<List<NewCategoryItem>>(

                                stream: blocG.categoryItemsStream,
                                initialData: blocG.allCategories,

                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, displayHeight(context) / 2, 0,
                                            0),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[

                                              Center(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: new CircularProgressIndicator(
                                                        backgroundColor: Colors
                                                            .lightGreenAccent)
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: new CircularProgressIndicator(
                                                      backgroundColor: Colors
                                                          .yellow,)
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: new CircularProgressIndicator(
                                                        backgroundColor: Colors
                                                            .redAccent)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      );
                                      break;
                                    case ConnectionState.active:
                                    default:
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: new LinearProgressIndicator());
                                      }
                                      else {
                                        final List allCategories = snapshot
                                            .data;

                                        final int categoryCount = allCategories
                                            .length;

                                        return (
                                            new ListView.builder
                                              (
                                                itemCount: categoryCount,

                                                itemBuilder: (_, int index) {



                                                  return _buildCategoryRow(
                                                      allCategories[index],
                                                      index);
                                                }
                                            )
                                        )
                                        ;
                                      }
                                  }
                                }
                            ),
                          ),

                        ],
                      ),
                    ),
                  ]
                  ,)

            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(/*DocumentSnapshot document*/
      NewCategoryItem oneCategory, int index) {

    final String categoryName = oneCategory.categoryName;

    if (_currentCategory.toLowerCase() == categoryName.toLowerCase()) {
      return

        ListTile(

          contentPadding: EdgeInsets.fromLTRB(10, 6, 5, 6),

          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                Text(categoryName.toLowerCase().length>8?categoryName.toLowerCase().substring(0,8)+'..':
                categoryName.toLowerCase()

                  , style:
                  TextStyle(

                    fontFamily: 'Itim-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.normal,

                    color: Color(0xff000000),
                  ),

                ), CustomPaint(size: Size(0, 19),
                  painter: MyPainter(),
                )
              ]
          ),
          onTap: () { // Add 9 lines from here...
            print('onTap pressed');
            print('index: $index');
            setState(() {
              _currentCategory = categoryName;
              _firstTimeCategoryString = categoryName;
              _searchString = '';
            });
          }, // ... to here.
        )
      ;
    }
    else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 6, 5, 6),

        title: Text(categoryName.toLowerCase(),

          style: TextStyle(

            fontFamily: 'Itim-Regular',

            fontSize: 24,
            fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
            color: Color(0xff000000),
          ),

        ),
        onTap: () { // Add 9 lines from here...
          print('onTap pressed');
          print('index: $index');
          setState(() {
            _currentCategory = categoryName;
            _firstTimeCategoryString = categoryName;
            _searchString = '';
          });
        }, // ... to here.
      );
    }
  }


  Widget drawerTest(BuildContext context) {
//    key: _drawerKey;
    return Scaffold(

      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),

      ),
    );
  }




  Widget shoppingCartWidget(BuildContext context){



    return Container(
//                                                                        width:60,
      width: displayWidth(
          context) / 13,
      height: displayHeight(context) / 25,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

      child: OutlineButton(
        onPressed: () async {
          if (_totalCount == 0) {
            return showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select some Food, please'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
//                        Text('you haven\'t selected any food yet, please select some food'),
                        Text('You need to select some food item in order to go to the shopping cart page.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Agree'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          else {
            print(
                ' method for old Outline button that deals with navigation to Shopping Cart Page');


            CustomerInformation oneCustomerInfo = new CustomerInformation(
              address: '',
              flatOrHouseNumber: '',
              phoneNumber: '',
              etaTimeInMinutes: -1,


            );


            orderFG.selectedFoodInOrder = allSelectedFoodGallery;

            orderFG.selectedFoodListLength = allSelectedFoodGallery.length;
            orderFG.totalPrice = totalPriceState;
            orderFG.orderingCustomer = oneCustomerInfo;
            print(

                'add_shopping_cart button pressed');

            logger.e('orderFG.selectedFoodInOrder ${orderFG.selectedFoodInOrder}');
            print('allSelectedFoodGallery[0].quantity: ${allSelectedFoodGallery[0].quantity} ');



            final Order orderWithDocumentId = await Navigator.of(context).push(

              PageRouteBuilder(
                opaque: false,
                transitionDuration: Duration(
                    milliseconds: 900),
                pageBuilder: (_, __, ___) =>
                    BlocProvider<ShoppingCartBloc>(
                      bloc: ShoppingCartBloc(
                          orderFG),


                      child: ShoppingCart(),

                    ),
                // fUTURE USE -- ANIMATION TRANSITION CODE.


              ),
            );



            if(orderWithDocumentId==null) {
              setState(() {
                _totalCount = 0;
                totalPriceState = 0;
                allSelectedFoodGallery = [];
                orderFG = new Order(
                  selectedFoodInOrder: [],
                  selectedFoodListLength: 0,
                  orderTypeIndex: 0,
                  // phone, takeaway, delivery, dinning.
                  paymentTypeIndex: 2,
                  //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                  orderingCustomer: null,
                  totalPrice: 0,
                  page: 0,
                  isCanceled: false,
                  orderdocId: '',

                );
              });
            }
            else if ((orderWithDocumentId.isCanceled != true) && (orderWithDocumentId.orderdocId=='')) {
              print('//   //    //    // THIS ELSE IS FOR BACK BUTTON =>');
              print('orderWithDocumentId.selectedFoodInOrder: ${orderWithDocumentId.selectedFoodInOrder}');
              print('allSelectedFoodGallery: ${orderWithDocumentId.selectedFoodInOrder}');
              print('allSelectedFoodGallery: ${orderWithDocumentId.selectedFoodInOrder}');

              print('_totalCount: $_totalCount');
              print('totalPriceState: $totalPriceState');

              setState((){

                allSelectedFoodGallery = orderWithDocumentId.selectedFoodInOrder;

              }
              );

              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("THIS ELSE IS FOR BACK BUTTON"),
                    duration: Duration(milliseconds: 8000),
                  ),);


            }

            else if ((orderWithDocumentId.paymentButtonPressed) &&
                (orderWithDocumentId.orderdocId != '')) {

              logger.e("Order received, id: ${orderWithDocumentId.orderdocId}");
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(
                    "Order received, id: ${orderWithDocumentId.orderdocId}"),
                    duration: Duration(milliseconds: 8000)
                )
                );


              setState(
                      () {
                    _totalCount = 0;
                    totalPriceState = 0;
                    allSelectedFoodGallery=[];
                    orderFG = new Order(
                      selectedFoodInOrder: [],
                      selectedFoodListLength:0,
                      orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
                      paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                      orderingCustomer: null,
                      totalPrice: 0,
                      page:0,
                      isCanceled: false,
                      orderdocId:'',
                    );
                  }
              );
            }


            else if (orderWithDocumentId.isCanceled == true) {

//              Order Cancelled by user.
              print("Order Cancelled by user,");
              print("orderWithDocumentId.paymentButtonPressed: ${orderWithDocumentId.paymentButtonPressed}");
              print("orderWithDocumentId.orderdocId == '': ${orderWithDocumentId.orderdocId}");

              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(
                    "Order Cancelled by user: ")));



              setState(
                      () {

                    _totalCount = 0;
                    totalPriceState = 0;
                    allSelectedFoodGallery=[];

                    orderFG = new Order(
                      selectedFoodInOrder: [],
                      selectedFoodListLength:0,
                      orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
                      paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                      orderingCustomer: null,
                      totalPrice: 0,
                      page:0,
                      isCanceled: false,
                      orderdocId:'',
                    );
                  }
              );
            }

            else{
              print('why this condition executed.');
              logger.e('why this condition executed.');
            }

          }
        },

        clipBehavior: Clip.hardEdge,
        splashColor: Color(0xffFEE295),

        highlightElevation: 12,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(35.0),
        ),

        borderSide: BorderSide(
          color: Color(0xffFEE295),
          style: BorderStyle.solid,
          width: 3.6,
        ),


        child:



        Center(
          child: Stack(
              children: <Widget>[ Center(
                child: Icon(

                  Icons.add_shopping_cart,
                  size: displayWidth(context)/19,
                  color: Color(0xff707070),
                ),
              ),

                Container(
                  width: displayWidth(context)/25,


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
                    _totalCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight
                          .normal,
                      fontSize: 20,
                    ),
                  ),

                ),

              ]
          ),
        ),

      ),
    );



  }



  String titleCase(var text) {

    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');


    }
  }


  String listTitleCase(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }



    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


    else {
      return stringList
          .map((word) => word.toString().split(' ')
          .map((word2) => titleCase(word2)).join(' '))
          .join(', ');

    }

  }


  Widget foodList(String categoryString,String searchString2,BuildContext context)  {


    final foodGalleryBloc = BlocProvider.of<FoodGalleryBloc>(context);



    return Container(
      child: StreamBuilder<List<FoodItemWithDocID>>(

        stream: foodGalleryBloc.foodItemsStream,

        initialData: foodGalleryBloc.allFoodItems,

        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                margin: EdgeInsets.fromLTRB(
                    0, displayHeight(context) / 2, 0, 0),
                child: Center(
                  child: Column(
                    children: <Widget>[

                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.lightGreenAccent)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                              backgroundColor: Colors.yellow,)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.redAccent)
                        ),
                      ),
                    ],
                  ),
                ),

              );
              break;
            case ConnectionState.active:

            default:
              if (!snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                      0, displayHeight(context) / 2, 0, 0),
                  child: Center(
                    child: Column(
                      children: <Widget>[

                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text('....')
                          ),
                        ),

                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: new CircularProgressIndicator(
                                  backgroundColor: Colors.redAccent)
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              }

              else {
                print(
                    'searchString  ##################################: $searchString2');
                print(
                    'categoryString  ##################################: $categoryString');


                final List<FoodItemWithDocID> allFoods = snapshot.data;


                if (searchString2 == '') {
//               filteredItemsByCategory;
                  List<FoodItemWithDocID> filteredItemsByCategory = allFoods
                      .where((oneItem) =>
                  oneItem.categoryName.
                  toLowerCase() ==
                      categoryString.toLowerCase()).toList();




                  final int categoryItemsCount = filteredItemsByCategory.length;
                  print('categoryItemsCount: $categoryItemsCount');
                  return

                    Column(
                      children: <Widget>[

                        Container(


                          height: displayHeight(context) / 20,
                          color: Color(0xffffffff),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Spacer(),
                                CustomPaint(size: Size(0, 19),
                                  painter: LongHeaderPainterBefore(context),
                                ),
                                Text('$_currentCategory'.toLowerCase(),
                                  style:
                                  TextStyle(

                                    fontFamily: 'Itim-Regular',
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,

                                    color: Color(0xff000000),
                                  ),
                                ),
                                CustomPaint(size: Size(0, 19),
                                  painter: LongHeaderPainterAfter(context),
                                ),
                                Spacer(),
                              ]
                          ),


                        ),
                        Container(

                          child: foodListByCategoryandNoSearch(
                              filteredItemsByCategory, context),
                        ),


                      ],

                    );
                }
                else {

                  final List<FoodItemWithDocID> filteredItems = allFoods.where((
                      oneItem) =>
                      oneItem.itemName.toLowerCase().
                      contains(
                          searchString2.toLowerCase())).toList();

                  return
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(


                            height: displayHeight(context) / 20,
                            color: Color(0xffffffff),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Spacer(),
                                  CustomPaint(size: Size(0, 19),
                                    painter: LongHeaderPainterBefore(context),
                                  ),
                                  Text('$searchString2'.toLowerCase(),
                                    style:
                                    TextStyle(

                                      fontFamily: 'Itim-Regular',
                                      fontSize: 30,
                                      fontWeight: FontWeight.normal,

                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  CustomPaint(size: Size(0, 19),
                                    painter: LongHeaderPainterAfter(context),
                                  ),
                                  Spacer(),
                                ]
                            ),


                          ),

                          Container(

                            child: foodListBySearchString(
                                filteredItems, context),
                          ),


                        ],
                      ),
                    );
                }
              }
          }



        },
      ),
    );
  }


  Widget foodListBySearchString(
      List<FoodItemWithDocID> filteredItemsBySearchString,
      BuildContext context)  {

    return Container(
      height: displayHeight(context) -
          MediaQuery
              .of(context)
              .padding
              .top - (displayHeight(context) / 14) -
          (displayHeight(context) / 20), /* displayHeight(context) / 20 is the header of category of search*/
      child: GridView.builder(
        itemCount: filteredItemsBySearchString.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
          crossAxisSpacing: 5,
          childAspectRatio: 140 / 180,


        ),
        shrinkWrap: false,

        itemBuilder: (_, int index) {

          final String foodItemName = filteredItemsBySearchString[index]
              .itemName;
          final String foodImageURL = filteredItemsBySearchString[index]
              .imageURL;


          final Map<String,
              dynamic> foodSizePrice = filteredItemsBySearchString[index]
              .sizedFoodPrices;


          final List<
              dynamic> foodItemIngredientsList = filteredItemsBySearchString[index]
              .ingredients;

          final bool foodIsAvailable = filteredItemsBySearchString[index]
              .isAvailable;
          final String foodCategoryName = filteredItemsBySearchString[index]
              .categoryName;
          final double discount = filteredItemsBySearchString[index]
              .discount;


          final dynamic euroPrice = foodSizePrice['normal'];


          double euroPrice2 = tryCast<double>(
              euroPrice, fallback: 0.00);

          String euroPrice3 = euroPrice2.toStringAsFixed(2);

          FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,
              sizedFoodPrices: foodSizePrice,


              ingredients: foodItemIngredientsList,

              isAvailable: foodIsAvailable,
              discount: discount

          );




          String stringifiedFoodItemIngredients = listTitleCase(
              foodItemIngredientsList);


          return
            Container(
              // `opacity` is alpha channel of this color as a double, with 0.0 being
              //  ///   transparent and 1.0 being fully opaque.
                color: Color(0xffFFFFFF),
                padding: EdgeInsets.symmetric(
                    horizontal: 4.0, vertical: 16.0),
                child: InkWell(
                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Container(child:
                      new Container(
                        width: displayWidth(context) / 7,
                        height: displayWidth(context) / 7,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(

                                color: Color(0xff707070),

                                blurRadius: 25.0,
                                spreadRadius: 0.10,
                                offset: Offset(0, 10)
                            )
                          ],
                        ),
                        child: Hero(
                          tag: foodItemName,
                          child:
                          ClipOval(
                            child: CachedNetworkImage(

                              imageUrl: foodImageURL,
                              fit: BoxFit.cover,
                              placeholder: (context,
                                  url) => new CircularProgressIndicator(),
                            ),
                          ),
                          placeholderBuilder: (context,
                              heroSize, child) {
                            return Opacity(
                              opacity: 0.5, child: Container(
                              width: displayWidth(context) /
                                  7,
                              height: displayWidth(context) /
                                  7,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(

                                      color: Color(
                                          0xffEAB45E),

                                      blurRadius: 25.0,
                                      spreadRadius: 0.10,
                                      offset: Offset(0, 10)
                                  )
                                ],
                              ),
                              child:
                              ClipOval(
                                child: CachedNetworkImage(

                                  imageUrl: foodImageURL,
                                  fit: BoxFit.cover,
                                  placeholder: (context,
                                      url) => new CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            );
                          },

                        ),

                      ),

                        padding: const EdgeInsets.fromLTRB(
                            0, 0, 0, 6),
                      ),



                      Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: <Widget>[
                            Text(

                              euroPrice3 + '\u20AC',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w600,
//                                          color: Colors.blue,
                                  color: Color.fromRGBO(
                                      112, 112, 112, 1),
                                  fontSize: 15),
                            ),

                            SizedBox(
                                width: displayWidth(context) /
                                    100),

                            Icon(
                              Icons.whatshot,
                              size: 24,
                              color: Colors.red,
                            ),
                          ]),


                      FittedBox(fit: BoxFit.fitWidth, child:
                      Text(

                        foodItemName,

                        style: TextStyle(
                          color: Color(0xff707070),


                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),)
                      ,
                      Container(

                          child: Text(

                            stringifiedFoodItemIngredients
                                .length == 0
                                ?
                            'EMPTY'
                                : stringifiedFoodItemIngredients
                                .length > 12 ?
                            stringifiedFoodItemIngredients
                                .substring(0, 12) + '...' :
                            stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5,
                              fontSize: 12,
                            ),
                          )
                      ),
//
//
                    ],
                  ),
                  onTap: () {
                    _navigateAndDisplaySelection(
                        context, oneFoodItem);
                  },


                )
            );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },

      ),
    );
  }
  Widget foodListByCategoryandNoSearch(List<FoodItemWithDocID> filteredItemsByCategory,BuildContext context)  {


    return Container(
      height: displayHeight(context) -
          MediaQuery
              .of(context)
              .padding
              .top - (displayHeight(context) / 14) -
          (displayHeight(context) / 20)-24,
      /* displayHeight(context) / 20 is the header of category of search || like pizza and /14 is the
      * container holding the logo*/
      child: GridView.builder(
        itemCount: filteredItemsByCategory.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
          crossAxisSpacing: 5,
          childAspectRatio: 140 / 180,


        ),
        shrinkWrap: false,

        itemBuilder: (_, int index) {

          final String foodItemName = filteredItemsByCategory[index]
              .itemName;
          final String foodImageURL = filteredItemsByCategory[index]
              .imageURL;

          final Map<String,
              dynamic> foodSizePrice = filteredItemsByCategory[index]
              .sizedFoodPrices;

          final List<
              dynamic> foodItemIngredientsList = filteredItemsByCategory[index]
              .ingredients;

          final bool foodIsAvailable = filteredItemsByCategory[index]
              .isAvailable;
          final String foodCategoryName = filteredItemsByCategory[index]
              .categoryName;
          final double discount = filteredItemsByCategory[index]
              .discount;

          final dynamic euroPrice = foodSizePrice['normal'];


          double euroPrice2 = tryCast<double>(euroPrice, fallback: 0.0);


          String euroPrice3 = euroPrice2.toStringAsFixed(2);

          FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,
              sizedFoodPrices: foodSizePrice,


              ingredients: foodItemIngredientsList,

              isAvailable: foodIsAvailable,
              discount: discount

          );

          String stringifiedFoodItemIngredients = listTitleCase(
              foodItemIngredientsList);


          return
            Container(
              // `opacity` is alpha channel of this color as a double, with 0.0 being
              //  ///   transparent and 1.0 being fully opaque.
                color: Color(0xffFFFFFF),
                padding: EdgeInsets.symmetric(
                    horizontal: 4.0, vertical: 16.0),
                child: InkWell(
                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Container(child:
                      new Container(
                        width: displayWidth(context) / 7,
                        height: displayWidth(context) / 7,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(

                                color: Color(0xff707070),

                                blurRadius: 25.0,
                                spreadRadius: 0.10,
                                offset: Offset(0, 10)
                            )
                          ],
                        ),
                        child: Hero(
                          tag: foodItemName,
                          child:
                          ClipOval(
                            child: CachedNetworkImage(

                              imageUrl: foodImageURL,
                              fit: BoxFit.cover,
                              placeholder: (context,
                                  url) => new CircularProgressIndicator(),
                            ),
                          ),
                          placeholderBuilder: (context,
                              heroSize, child) {
                            return Opacity(
                              opacity: 0.5, child: Container(
                              width: displayWidth(context) /
                                  7,
                              height: displayWidth(context) /
                                  7,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(
                                          0xffEAB45E),

                                      blurRadius: 25.0,
                                      spreadRadius: 0.10,
                                      offset: Offset(0, 10)
                                  )
                                ],
                              ),
                              child:
                              ClipOval(
                                child: CachedNetworkImage(

                                  imageUrl: foodImageURL,
                                  fit: BoxFit.cover,
                                  placeholder: (context,
                                      url) => new CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            );
                          },

                        ),

                      ),

                        padding: const EdgeInsets.fromLTRB(
                            0, 0, 0, 6),
                      ),



                      Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: <Widget>[
                            Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                              euroPrice3 + '\u20AC',
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w600,
//                                          color: Colors.blue,
                                  color: Color.fromRGBO(
                                      112, 112, 112, 1),
                                  fontSize: 15),
                            ),
//                                    SizedBox(width: 10),
                            SizedBox(
                                width: displayWidth(context) /
                                    100),

                            Icon(
                              Icons.whatshot,
                              size: 24,
                              color: Colors.red,
                            ),
                          ]),


                      FittedBox(fit: BoxFit.fitWidth, child:
                      Text(

                        foodItemName,

                        style: TextStyle(
                          color: Color(0xff707070),


                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),)
                      ,
                      Container(


                          child: Text(



                            stringifiedFoodItemIngredients
                                .length == 0
                                ?
                            'EMPTY'
                                : stringifiedFoodItemIngredients
                                .length > 12 ?
                            stringifiedFoodItemIngredients
                                .substring(0, 12) + '...' :
                            stringifiedFoodItemIngredients,

                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5,
                              fontSize: 12,
                            ),
                          )
                      ),
//
//
                    ],
                  ),
                  onTap: () {
                    _navigateAndDisplaySelection(
                        context, oneFoodItem);
                  },


                )
            );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },

      ),
    );
  }



  _navigateAndDisplaySelection(BuildContext context,FoodItemWithDocID oneFoodItem) async {


    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final blocG = BlocProvider.of<FoodGalleryBloc>(context);

    List<NewIngredient> tempIngs = blocG.getAllIngredientsPublicFGB2;


    final SelectedFood receivedSelectedFood = await
    Navigator.of(context).push(


      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(
            milliseconds: 900),
        pageBuilder: (_, __, ___) =>


        BlocProvider<FoodItemDetailsBloc>(
          bloc: FoodItemDetailsBloc(
              oneFoodItem,
              tempIngs,
          ),


          child: FoodItemDetails2()

          ,),



      ),
    );


    if(
    (receivedSelectedFood!=null) && (receivedSelectedFood.foodItemName!=null)
    ) {

      print('| | | | | | | |   receivedSelectedFood.selectedSauceItems: ${receivedSelectedFood.selectedSauceItems}');
      print('| | | | | | | |   receivedSelectedFood.selectedCheeseItems: ${receivedSelectedFood.selectedCheeseItems}');




      int currentFoodItemQuantity = receivedSelectedFood.quantity;
      double unitPricecurrentFood = receivedSelectedFood.unitPrice;

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("selected ${receivedSelectedFood.quantity} items")));


      setState(
              ()
          {
            _totalCount = _totalCount + receivedSelectedFood.quantity;
            allSelectedFoodGallery.add(receivedSelectedFood);
            totalPriceState =
                totalPriceState + currentFoodItemQuantity * unitPricecurrentFood;

          }
      );




    }
    else{
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("selected 0 items")));
    }

  }


  int test1(SelectedFood x) {


    return x.quantity ;
  }
}

class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){


    final p1 = Offset(50, 20);
    final p2 = Offset(5, 20);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongHeaderPainterAfter extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size){


    final p1 = Offset(displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}



class LongHeaderPainterBefore extends CustomPainter {


  final BuildContext context;
  LongHeaderPainterBefore(this.context);


  @override
  void paint(Canvas canvas, Size size){


    final p1 = Offset(-displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(-10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}