

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/generated/i18n.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';

import 'dart:async';


/*
#### keep track of their favorite restaurants
and show those in a separate list
*/

/*
```json
Favoriting Restaurants
So far, the BLoC pattern has been used to manage user input, but it can be used
 for so much more. Let’s say the user want to keep track of their favorite restaurants
and show those in a separate list. That too can be solved with the BLoC pattern.
```
*/


//Map<String, int> mapOneSize = new Map();

class FoodItemDetailsBloc /*with ChangeNotifier */ implements Bloc  {



  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


//  final Sink<int> _external;
//
//  Bloc(this._external);


  // can also use var _oneFoodItem = new FoodItemWithDocID() ;
//  FoodItemWithDocID _oneFoodItem = new FoodItemWithDocID() ;
  FoodItemWithDocIDViewModel _thisFoodItem ;
//  String _currentSize = 'normal';

//  var _currentSize = new Map<String ,double>(); // currentlyNotUsing.

//  Map<String,Dynamic>

  FoodItemWithDocIDViewModel get currentFoodItem => _thisFoodItem;

//  _thisFoodItem =thisFoodpriceModified;
//
//  _controller.sink.add(thisFoodpriceModified);

  List<NewIngredient> _allIngItemsDetailsBlock =[];


  List<NewIngredient> _defaultIngItems = [];
  List<NewIngredient> _unSelectedIngItems = [];
  List<FoodPropertyMultiSelect> _multiSelectForFood =[];
//  Order _currentSelectedFoodDetails ;
  SelectedFood _currentSelectedFoodDetails;


//  List <NewIngredient> ingItems = new List<NewIngredient>();



  // FOR location_bloc => final _locationController = StreamController<Location>();
  // [NORMAL STREAM, BELOW IS THE BROADCAST STREAM].

  // FOR location_bloc => Stream<Location> get locationStream => _locationController.stream;

  // getter that get's the stream with _locationController.stream;
  //  Stream<Location> get locationStream => _locationController.stream;

  // declartion and access.


  //  How it know's from the Restaurant array that this are favorite;

  // 1

  SelectedFood get getCurrentSelectedFoodDetails => _currentSelectedFoodDetails;
  List<NewIngredient> get allIngredients => _allIngItemsDetailsBlock;

  List<NewIngredient> get getDefaultIngredients => _defaultIngItems;
  List<NewIngredient> get unSelectedIngredients => _unSelectedIngItems;


  List<FoodPropertyMultiSelect> get getMultiSelectForFood => _multiSelectForFood;





  final _selectedFoodControllerFoodDetails = StreamController <SelectedFood>.broadcast();
  final _controller = StreamController <FoodItemWithDocIDViewModel>();

  // final _itemSizeController = StreamController<Map<String, double>>(); // currentlyNotUsing.

  final _allIngredientListController =  StreamController <List<NewIngredient>>();
//  final _allIngredientListController = StreamController <List<NewIngredient>>();


  final _unSelectedIngredientListController   =  StreamController <List<NewIngredient>>();
  final _defaultIngredientListController      =  StreamController <List<NewIngredient>>();

  final _multiSelectForFoodController      =  StreamController <List<FoodPropertyMultiSelect>>();


//  final _foodItemController = StreamController <List<FoodItemWithDocID>>();

  // INVOKER -> stream: bloc.favoritesStream,

  Stream<SelectedFood> get getCurrentSelectedFoodStream => _selectedFoodControllerFoodDetails.stream;
  Stream<FoodItemWithDocIDViewModel> get currentFoodItemsStream => _controller.stream;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;

  Stream<List<NewIngredient>> get getUnSelectedIngredientItemsStream => _unSelectedIngredientListController.stream;
  Stream<List<NewIngredient>> get getDefaultIngredientItemsStream => _defaultIngredientListController.stream;

  Stream<List<FoodPropertyMultiSelect>> get getMultiSelectStream => _multiSelectForFoodController.stream;



  // // cheese items
  // List<CheeseItem> _allCheeseItemsDBloc =[];
  // List<CheeseItem> get getAllCheeseItems => _allCheeseItemsDBloc;
  // final _cheeseItemsController      =  StreamController <List<CheeseItem>>();
  // Stream<List<CheeseItem>> get getCheeseItemsStream => _cheeseItemsController.stream;
  //
  // // sauce items
  // List<SauceItem> _allSauceItemsDBloc =[];
  // List<SauceItem> get getAllSauceItems => _allSauceItemsDBloc;
  // final _sauceItemsController      =  StreamController <List<SauceItem>>();
  // Stream<List<SauceItem>> get getSauceItemsStream => _sauceItemsController.stream;
  //
  //
  // // selected Cheese Items
  //
  //
  // List<CheeseItem> _allSelectedCheeseItems =[];
  // List<CheeseItem> get getAllSelectedCheeseItems => _allSelectedCheeseItems;
  // Stream<List<CheeseItem>> get getSelectedCheeseItemsStream => _cheeseItemsController.stream;
  // final _selectedCheeseListController      =  StreamController <List<CheeseItem>>();
  //
  //
  //
  // // selected Sauce Items
  //
  //
  // List<SauceItem> _allSelectedSauceItems =[];
  // List<SauceItem> get getAllSelectedSauceItems => _allSelectedSauceItems;
  // Stream<List<SauceItem>> get getSelectedSauceItemsStream => _selectedSauceListController.stream;
  // final _selectedSauceListController      =  StreamController <List<SauceItem>>();


  // Stream<Map<String,double>> get CurrentItemSizePlusPrice => _itemSizeController.stream; // currentlyNotUsing.


  /*
  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  */





  void setallIngredients(List<NewIngredient> allIngredients){

    // print('setallIngredients : ___ ___ ___   $allIngredients');

    _allIngItemsDetailsBlock = allIngredients;
    _allIngredientListController.sink.add(_allIngItemsDetailsBlock);

//    List <FoodPropertyMultiSelect> multiSelectArray = _multiSelectForFood;


  }

  // CONSTRUCTOR BEGINS HERE.
  FoodItemDetailsBloc(FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped ) {


//    if(allIngsScoped==[]) return;

    // print("allIngsScoped: $allIngsScoped ");

    // I THOUTHT THIS _allIngItemsDetailsBlock WILL CONTAIN DATA SINCE I SET THEM FROM FOODGALLERY PAGE BEFORE CALLING THE
    // CONSTRUCTOR
    /*
     print("_allIngItemsDetailsBlock: $_allIngItemsDetailsBlock");
    allIngsScoped= _allIngItemsDetailsBlock;

    BUT THEY SHOW [].
     */




//    print(' 1 means from Food Gallery Page to Food Item Details Page');
//    print(' which IS NORMAL');

//    print("at the begin of Constructor [FoodItemDetailsBloc]");
//    print("oneFoodItem ===> ===> ===> $oneFoodItem");
    //  print("allIngsScoped _allIngItemsDetailsBlock ===> ===> ===> $_allIngItemsDetailsBlock");


//    _oneFoodItem = oneFoodItem;


    //  logger.w(" allIngsScoped: ", allIngsScoped);

    //  print(" allIngsScoped: $allIngsScoped ");

    /* Ordered Food Related codes starts here. */


    /*
    CustomerInformation oneCustomerInfo = new CustomerInformation(
      address: '',
      flatOrHouseNumber: '',
      phoneNumber: '',
      etaTimeInMinutes: -1,
//        CustomerInformation currentUser = _oneCustomerInfo;
//    currentUser.address = address;
//

    );

    Order constructorOrderFD = new Order(
      selectedFoodInOrder: [],
      selectedFoodListLength:0,
      orderTypeIndex: 0,
      paymentTypeIndex: 4,
      ordersCustomer: oneCustomerInfo,
    );


    _currentSelectedFoodDetails = constructorOrderFD;

    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
    */

    /* Ordered Food Related codes ends here. */


//    logger.e('oneFoodItem.discount: ${oneFoodItem.discount}');


    SelectedFood selectedFoodInConstructor = new SelectedFood(
      foodItemName:oneFoodItem.itemName,
      foodItemImageURL: oneFoodItem.imageURL,
      unitPrice: 0, // this value will be set when increment and decreemnt
      //button pressed from the UI.
      foodDocumentId: oneFoodItem.documentId,
      quantity:0,
      foodItemSize: 'normal', // to be set from the UI.
      selectedIngredients:_defaultIngItems,
      categoryName:oneFoodItem.categoryName,
      discount:oneFoodItem.discount,
      // selectedCheeseItems : _allSelectedCheeseItems,
      // selectedSauceItems:   _allSelectedSauceItems,
    );

    _currentSelectedFoodDetails = selectedFoodInConstructor;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);


    final Map<String, dynamic> foodSizePrice = oneFoodItem.sizedFoodPrices;

    /* INGREDIENTS HANDLING CODES STARTS HERE: */
    List<String> ingredientStringsForWhereInClause;



    //    oneFoodItem, List<NewIngredient> allIngsScoped

//    if(oneFoodItem==null){
//      foodItemIngredientsList2=null;
//
//    }

    // COUNTER MEASURES SINCE WE INVOKE APPBLOC FROM WELCOME PAGE WHERE THIS CONSTRUCTOR IS CALLED 1.
    // COUNTER MEASURE 01.

    //  print('^^  ^ ^^  oneFoodItem.itemName: ${oneFoodItem.itemName}');
    final List<dynamic> foodItemIngredientsList2 = oneFoodItem.itemName==null ? null:oneFoodItem.ingredients;

    // COUNTER MEASURE 02.
    List<String> listStringIngredients = oneFoodItem.itemName==null ? null:dynamicListFilteredToStringList(
        foodItemIngredientsList2);


//    logger.e(' I  I   I  I  any error until this line executed ** ');
//    print('listStringIngredients: $listStringIngredients');
//      logger.w('listStringIngredients at foodItem Details Block line # 160',
//          listStringIngredients);


//    List<NewIngredient> allIngsScoped = getAllIngredients();


    // DDD todo

//    print('allIng_s : $allIngsScoped');

    // COUNTER MEASURE 03. && (listStringIngredients!=null)

    // SHORT CIRCUIT WORKING HERE.
    if ((listStringIngredients != null) && (listStringIngredients.length != 0)) {

      print('(listStringIngredients != null) && (listStringIngredients.length != 0): '
          ''
          '${(listStringIngredients != null) && (listStringIngredients.length != 0)}');

      filterSelectedDefaultIngredients(allIngsScoped,
          listStringIngredients); // only default<NewIngredient>

      filterUnSelectedIngredients(allIngsScoped,
          listStringIngredients); // only default<NewIngredient>


    }

    else {
      print('at else statement:  ===> ===> ===> ===>');

      print('allIngsScoped.length  ===> ===> ===> ===> ${allIngsScoped
          .length}');
      List <NewIngredient> ingItems = new List<NewIngredient>();
      // ARE THIS TWO STATEMENTS WHERE I PUT A 'NONE' ITEM IN DEFAULT INGREDIENTS NECESSARY ???*/

      /*
      NewIngredient c1 = new NewIngredient(
          ingredientName: 'None',
          imageURL: 'None',

          price: 0.01,
          documentId: 'None',
          ingredientAmountByUser: 1000

      );

      ingItems.add(c1);
      */

//      _allIngItemsDetailsBlock = ingItems;

//      _allIngredientListController.sink.add(ingItems);

//      _unSelectedIngredientListController

      _defaultIngItems = ingItems;
      _defaultIngredientListController.sink.add(_defaultIngItems);


      List<NewIngredient> unSelectedDecremented =
      allIngsScoped.map((oneIngredient) =>
          NewIngredient.updateUnselectedIngredient(
              oneIngredient
          )).toList();

      print('unSelectedIngredientsFiltered ===>  ${unSelectedDecremented
          .length}');
      print(
          "length of unSelectedIngredientsFiltered ===>  =======> ========>> ==========> =========> ");
      _unSelectedIngItems = unSelectedDecremented;


      _unSelectedIngredientListController.sink.add(unSelectedDecremented);

//      return ingItems;

    }

    //DDDD todo

    /* INGREDIENTS HANDLING CODES ENDS HERE: */

    // COUNTER MEASURE 04.
    dynamic normalPrice = oneFoodItem.itemName==null ? 0 :foodSizePrice['normal'];



//    dynamic normalPrice = foodSizePrice['normal'];
//    if (!normalPrice ) {
//      print('price is is null');
//    }

    /*
    logger.e('normalPrice: $normalPrice');

    if (normalPrice is double) {
      print('price double at foodItemDetails bloc');
    }


    else if (normalPrice is num) {
      print('price num at foodItemDetails bloc');
    }


    else if (normalPrice is int) {
      print('price int at foodItemDetails bloc');
    }

    else {
      print('normalPrice is dynamic: ${normalPrice is dynamic}');
      print('price dynamic at foodItemDetails bloc');
    }
    */



    double normalPriceCasted = tryCast<double>(normalPrice, fallback: 0.00);

    FoodItemWithDocIDViewModel thisFood =
    FoodItemWithDocIDViewModel.customCastFrom(
        oneFoodItem, 'normal', normalPriceCasted);

//    FoodItemWithDocIDViewModel thisFood = new FoodItemWithDocIDViewModel(
//      itemName: oneFoodItem.itemName,
//      categoryName: oneFoodItem.categoryName,
//      sizedFoodPrices: oneFoodItem.sizedFoodPrices,
//      uploadDate: oneFoodItem.uploadDate,
//      imageURL: oneFoodItem.imageURL,
//      content: oneFoodItem.content,
//      ingredients: oneFoodItem.ingredients,
//      itemId: oneFoodItem.itemId,
//      indicatorValue: oneFoodItem.indicatorValue,
//      isAvailable: oneFoodItem.isAvailable,
//      isHot: oneFoodItem.isHot,
//      uploadedBy: oneFoodItem.uploadedBy,
//      documentId: oneFoodItem.documentId,
//      itemSize: 'normal',
//      itemPrice: normalPriceCasted,
//    );


    /*
    * INITIATE MULTISELECT FOODiTEM OPTIONS*/


    _thisFoodItem =
        thisFood; // important otherwise => The getter 'sizedFoodPrices' was called on null.


    initiateAllMultiSelectOptions();

    _controller.sink.add(_thisFoodItem);
  }

  // CONSTRUCTOR ENDS HERE.

//  List<FoodPropertyMultiSelect> initiateAllMultiSelectOptions()
  void initiateAllMultiSelectOptions()
  {

    FoodPropertyMultiSelect _org = new FoodPropertyMultiSelect(
      borderColor: '0xff739DFA',
      index: 4,
      isSelected: false,
      itemName: 'ORG',
      itemTextColor: '0xff739DFA',
    );

    FoodPropertyMultiSelect _vs = new FoodPropertyMultiSelect(
      borderColor: '0xff95CB04',
      index: 3,
      isSelected: false,
      itemName: 'VS',
      itemTextColor: '0xff95CB04',
    );


//     0xffFEE295 false
    FoodPropertyMultiSelect _vsm = new FoodPropertyMultiSelect(
      borderColor: '0xff34720D',
      index: 2,
      isSelected: false,
      itemName: 'VSM',
      itemTextColor: '0xff34720D',
    );


    FoodPropertyMultiSelect _m = new FoodPropertyMultiSelect(
      borderColor: '0xffB47C00',
      index: 1,
      isSelected: false,
      itemName: 'M',
      itemTextColor: '0xffB47C00',
    );


    List <FoodPropertyMultiSelect> multiSelectArray = new List<FoodPropertyMultiSelect>();

    multiSelectArray.addAll([_org,_vs,_vsm,_m]);

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _multiSelectForFoodController.sink.add(_multiSelectForFood);

  }

  /*  Below ARE OrderedFoodItem related codes decrement increment( SET) */
  void decrementOneSelectedFoodForOrder(/* SelectedFood oneSelectedFoodFD,
   first arg IS NOT REQUIRED FOR DECREMENT */itemCount){



    print('/// ////         // itemCount at DEC : $itemCount');
    int numberOFSelectedFoods;
//    Order tempOrderDecrementOperation = _currentSelectedFoodDetails;

    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;

    if(itemCount==1){

      print('_currentSelectedFoodDetails.selectedFoodInOrder[0].quantity:'
          '${_currentSelectedFoodDetails.quantity}');


//      int newSelectedFoodOrderLength = tempOrderDecrementOperation.selectedFoodListLength-1;


      // from 1 to 0 and passed as parameter.
//      tempOrderDecrementOperation.selectedFoodInOrder.removeAt(newSelectedFoodOrderLength);
      tempSelectedFood.quantity =tempSelectedFood.quantity-1;

      // remove at 0 means first item.

      //      List x=[1,2,3,4];
//      print('List(0) $List(0)');


//      tempOrderDecrementOperation.selectedFoodListLength= 0;

      _currentSelectedFoodDetails = tempSelectedFood;

//      print('_currentSelectedFoodDetails.selectedFoodInOrder.length:'
//          +'${_currentSelectedFoodDetails.selectedFoodInOrder.length} ');

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
    }
    else{

      tempSelectedFood.quantity = itemCount-1;

      _currentSelectedFoodDetails = tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);


    }





//    x.selectedFoodInOrder.add(constructorSelectedFoodFD);
  }

  void incrementOneSelectedFoodForOrder(SelectedFood oneSelectedFoodFD,
      int  initialItemCount  /*ItemCount */){





    print('_   _    _ itemCount _   _   _:$initialItemCount');



    if( initialItemCount == 0 ) {

      print( '>>>> initialItemCount == 0  <<<< ');


      SelectedFood tempSelectedFood = oneSelectedFoodFD ;

      // REQUIRED ...
      oneSelectedFoodFD.selectedIngredients = _defaultIngItems;
      // oneSelectedFoodFD.selectedCheeseItems = _allSelectedCheeseItems;
      // oneSelectedFoodFD.selectedSauceItems  = _allSelectedSauceItems;




      _currentSelectedFoodDetails =tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

    }
    else{



      SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;

      tempSelectedFood.quantity = tempSelectedFood.quantity +1;

      _currentSelectedFoodDetails = tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);


    }


  }

  /*  ABOVE ARE OrderedFoodItem related codes*/

  void setMultiSelectOptionForFood(FoodPropertyMultiSelect x, int index){


    List <FoodPropertyMultiSelect> multiSelectArray = _multiSelectForFood;

    x.isSelected= !x.isSelected;
    multiSelectArray[index]=x;

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


    _multiSelectForFoodController.sink.add(_multiSelectForFood);
  }



  void incrementThisIngredientItem(NewIngredient unSelectedOneIngredient,int index){

    print('reached here: incrementThisIngredientItem ');

//                          NewIngredient c1 = oneUnselectedIngredient;


    print('modified ingredientAmountByUser at begin: ${_unSelectedIngItems[index].
    ingredientAmountByUser}');

    NewIngredient c1 = new NewIngredient(
        ingredientName: unSelectedOneIngredient
            .ingredientName,
        imageURL: unSelectedOneIngredient.imageURL,

        price: unSelectedOneIngredient.price,
        documentId: unSelectedOneIngredient.documentId,
        ingredientAmountByUser: unSelectedOneIngredient
            .ingredientAmountByUser + 1
    );



    List<NewIngredient> allUnselectedbutOneDecremented = _unSelectedIngItems;
    print('_unSelectedIngItems.length: ${allUnselectedbutOneDecremented.length}');

    allUnselectedbutOneDecremented[index] = c1;


    _unSelectedIngItems= allUnselectedbutOneDecremented;
    print('_unSelectedIngItems.length: ${_unSelectedIngItems.length}');
    print('modified ingredientAmountByUser at end: ${_unSelectedIngItems[index].
    ingredientAmountByUser}');


//   _thisFoodItem =thisFoodpriceModified;

    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

//    notifyListeners();

    //THIS LINE MIGHT NOT BE NECESSARY.
  }


  void removeThisDefaultIngredientItem(NewIngredient unSelectedOneIngredient,int index){
    print('reached here ==> : <==  remove This Default Ingredient Item ');

    List<NewIngredient> allDefaultIngredientItems = _defaultIngItems;

    NewIngredient temp =  allDefaultIngredientItems[index];

    allDefaultIngredientItems.removeAt(index);

//    _unSelectedIngItems.add(_defaultIngItems[index]);

//    allUnselectedbutOneDecremented[index] = c1;
    _defaultIngItems= allDefaultIngredientItems;
//    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _defaultIngredientListController.sink.add(_defaultIngItems);


    //  NOW ADD PART BEGINS HERE

    List<NewIngredient> allUnSelectedIngredientItems = _unSelectedIngItems;

    allUnSelectedIngredientItems.add(temp);


    _unSelectedIngItems  = allUnSelectedIngredientItems;
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

    setNewPriceforSauceItemCheeseItemIngredientUpdate();
//    setNewPriceBySelectedSauceItems(_allSelectedSauceItems);
    // pqr.


  }












  void moreDefaultIngredientItems(/*NewIngredient unSelectedOneIngredient,int index*/){
    print('reached here ==> : <==  update Default IngredientItem ');

    List<NewIngredient> allDefaultIngredientItems = _defaultIngItems;

    List<NewIngredient> allPreviouslyUnSelectedIngredientItems = _unSelectedIngItems;

    List <NewIngredient> valueIncrementedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser >0).toList();


//    logger.e('valueIncrementedUNselectedIngredient: $valueIncrementedUNselectedIngredient');


    List <NewIngredient> valueUnChangedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser == 0).toList();


//    List<String> stringList = List<String>.from(dlist);
//    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
//    ==
//    isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

//    logger.e('valueUnChangedUNselectedIngredient: $valueUnChangedUNselectedIngredient');



    allDefaultIngredientItems.addAll(valueIncrementedUNselectedIngredient);

    _defaultIngItems = allDefaultIngredientItems;
//    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _defaultIngredientListController.sink.add(_defaultIngItems);

    // --- price update invocation.

    setNewPriceByIngredientAdd(_defaultIngItems);
//    setNewPriceBySelectedIngredientItems();


    //  NOW ADD PART BEGINS HERE

    List<NewIngredient> allUnSelectedIngredientItems = valueUnChangedUNselectedIngredient;


    _unSelectedIngItems  = allUnSelectedIngredientItems;
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);


  }


  void decrementThisIngredientItem(NewIngredient unSelectedOneIngredient,int index){

    print('reached here: decrementThisIngredientItem ');

//                          NewIngredient c1 = oneUnselectedIngredient;


    NewIngredient c1 = new NewIngredient(
        ingredientName: unSelectedOneIngredient
            .ingredientName,
        imageURL: unSelectedOneIngredient.imageURL,

        price: unSelectedOneIngredient.price,
        documentId: unSelectedOneIngredient.documentId,
        ingredientAmountByUser: unSelectedOneIngredient
            .ingredientAmountByUser - 1
    );





    List<NewIngredient> allUnselectedbutOneDecremented = _unSelectedIngItems;
    allUnselectedbutOneDecremented[index] = c1;

    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

    //THIS LINE MIGHT NOT BE NECESSARY.


  }



  void setNewSizePlusPrice(String sizeKey) {
    final Map<String,dynamic> foodSizePrice = _thisFoodItem.sizedFoodPrices;

    print("_thisFoodItem.sizedFoodPrices: ${_thisFoodItem.sizedFoodPrices}");

//    logger.i('sizeKey: ',sizeKey);

    dynamic changedPrice1 = foodSizePrice[sizeKey];

    print('changedPrice1: $changedPrice1');

    double changedPriceDouble = tryCast<double>(changedPrice1, fallback: 0.00);


    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;
    thisFoodpriceModified.itemSize = sizeKey;
    thisFoodpriceModified.itemPrice =  changedPriceDouble;
    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = changedPriceDouble;


    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);



  }

  // HELPER METHOD tryCast Number (1)
  double test1(NewIngredient x) {


    return x.price ;
  }

  void setNewPriceByIngredientAdd(List<NewIngredient> defaultIngredients) {

//    List<NewIngredient> defaultIngredientsLaterAdded = defaultIngredients.map((oneDefaultIngredient))

    List<NewIngredient> defaultIngredientsLaterAdded = defaultIngredients.where((oneDefaultIngredient) =>
    oneDefaultIngredient.isDefault!=true).toList();


    double addedIngredientItemsPrice= defaultIngredientsLaterAdded.fold(0, (t, e) => t + e.price);
    print('addedIngredientItemsPrice : $addedIngredientItemsPrice');

    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;
    print('previous  price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice + addedIngredientItemsPrice;


//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);

  }

  void setNewPriceBySelectedCheeseItems(List<CheeseItem> cheeseItems) {

    double addedCheeseItemsPrice = cheeseItems.fold(0, (t, e) => t + e.price);
    print('addedCheeseItemsPrice : $addedCheeseItemsPrice');

    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;

    print('previous CheeseItem price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice + addedCheeseItemsPrice;

    print('modified price for new Cheese Item addition or remove: '
        '${thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize}');

//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);


  }

  void setNewPriceforSauceItemCheeseItemIngredientUpdate(/*List<SauceItem> sauceItems*/) {

//    _allSelectedCheeseItems = cheeseItems.where((element) =>
//    (element.isSelected==true && element.isDefaultSelected!=true)).toList();


    // List<SauceItem> onlyNewSelectedSauceItems = _allSelectedSauceItems.where((element) =>((element.isSelected==true)
    //     && (element.isDefaultSelected!=true))).toList();

    // List<CheeseItem> onlyNewSelectedCheeseItems = _allSelectedCheeseItems.where((element) =>((element.isSelected==true)
    //     && (element.isDefaultSelected!=true))).toList();

    List<NewIngredient> onlyNewSelectedIngredients = _defaultIngItems.where((element) =>((element.isDefault= false)
    )).toList();



    // double addedSauceItemsPrice = onlyNewSelectedSauceItems.fold(0, (t, e) => t + e.price);
    // double addedCheeseItemsPrice = onlyNewSelectedCheeseItems.fold(0, (t, e) => t + e.price);
    //

    double addedIngredientsItemsPrice = onlyNewSelectedIngredients.fold(0, (t, e) => t + e.price);

    // print('addedSauceItemsPrice : $addedSauceItemsPrice');
    // print('addedCheeseItemsPrice : $addedCheeseItemsPrice');
    print('addedIngredientsItemsPrice : $addedIngredientsItemsPrice');


    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

//    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;
    double previousPrice = _thisFoodItem.itemPrice;

    print('previous  price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice +
        /*addedSauceItemsPrice
        + addedCheeseItemsPrice*/ addedIngredientsItemsPrice;

    print('modified price for new SauceItem addition or remove: '
        '${thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize}');

//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);

  }


  // HELPER METHOD tryCast Number (1)
  double tryCast<num>(dynamic x, {num fallback }) {

    print(" at tryCast");
    print('x: $x');

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

  // HELPER METHOD  dynamicListFilteredToStringList Number (2)

  List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);


    return stringList;

  }

  // helper method 04 filterSelectedDefaultIngredients
  filterSelectedDefaultIngredients(List<NewIngredient> allIngList ,
      List<String> listStringIngredients2) {
// foox

//    logger.w("at filterSelectedDefaultIngredients","filterSelectedDefaultIngredients");



//    print("allIngList: $allIngList");

    print("listStringIngredients2: $listStringIngredients2");
    print('allIngList.length: ${allIngList.length}');

    allIngList.map((oneElement)=> print('oneElement.ingredientName:'
        ' ${oneElement.ingredientName}'));
    var mappedFruits2 = allIngList.map((oneElement)=> '${oneElement.ingredientName==''}').toList();
    print('mappedFruits2.length: ${mappedFruits2.length}');


    var mappedFruits = allIngList.map((oneElement)=> '${oneElement.ingredientName}').toList();

    print('mappedFruits: $mappedFruits');
    print('mappedFruits: ${mappedFruits.length}');



    List<NewIngredient> default2 =[];

//    List<NewIngredient> y = [];
    NewIngredient toBeDeleted= NewIngredient(
        ingredientName: 'None',
        imageURL: 'None',

        price: 0.001,
        documentId: 'None',
        ingredientAmountByUser: -1000

    );

    listStringIngredients2.forEach((stringIngredient) {

      /*
      NewIngredient elementExists = allIngList.where(
              (oneItem) => oneItem.ingredientName.trim().toLowerCase()
              == stringIngredient.trim().toLowerCase()).first;


      */

      NewIngredient elementExists = allIngList.firstWhere(
              (oneItem) => oneItem.ingredientName.trim().toLowerCase() == stringIngredient.trim().toLowerCase(),
          orElse: () => toBeDeleted);








//      print('elementExists: $elementExists');




//      print('elementExists: $elementExists');
      // WITHOUT THE ABOVE PRINT STATEMENT SOME TIMES THE APPLICATION CRUSHES.

      if(elementExists.ingredientName!='None') {
        default2.add(elementExists);
      }

    });

    default2.map((oneIngredient) =>
        NewIngredient.updateSelectedIngredient(
            oneIngredient
        )).toList();


    print('defaultingredients lenght: ${default2.length}');

    _defaultIngItems = default2;
    _defaultIngredientListController.sink.add(default2);



//    return default2;

//    logger.i('_defaultIngItems: ',_defaultIngItems);

  }

  // #### helper method 05 filterUnSelectedIngredients
  //
  filterUnSelectedIngredients (
      List<NewIngredient> allIngList , List<String> listStringIngredients2
      ) {
// foox

//    logger.w("at filterUnSelectedIngredients ","filterUnSelectedIngredients");

//    print("at allIngList ${allIngList.length}");

//    print("allIngList: $allIngList");

//    print("listStringIngredients2: ${listStringIngredients2.length}");

    List <NewIngredient> allUnSelected;

//    Set<NewIngredient> elementUNSelected = new Set<NewIngredient>();
//    listStringIngredients2.forEach((stringIngredient) {
//
//      print('ingredient in foreach loop $stringIngredient');

    List<NewIngredient> unSelectedIngredientsFiltered = allIngList.where(
            (oneItem) => oneItem.ingredientName.trim().toLowerCase() !=
            checkThisIngredientInDefatultStringIngredient(
                oneItem,listStringIngredients2
            )
    ).toList();


    unSelectedIngredientsFiltered.forEach((oneUnSelected) {


      print('oneUnSelected.imageURL: ${oneUnSelected.imageURL}');


    });


    // forEach
//      print('elementUNSelected: $elementUNSelected');


    List<NewIngredient> unSelectedDecremented =
    unSelectedIngredientsFiltered.map((oneIngredient)=>
        NewIngredient.updateUnselectedIngredient(
            oneIngredient
        )).toList();



    _unSelectedIngItems = unSelectedDecremented;

    _unSelectedIngredientListController.sink.add(unSelectedDecremented);

  }



  // HELPER METHOD 06 checkThisIngredientInDefatultStringIngredient

  String checkThisIngredientInDefatultStringIngredient(NewIngredient x, List<String> ingredientsString) {

//    print('ingredientsString: $ingredientsString');
//    print('.ingredientName.toLowerCase().trim(): ${x.ingredientName.toLowerCase().trim()}');

//    List<String> foodIngredients =ingredientsString;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);


    String elementExists = ingredientsString.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == x.ingredientName.toLowerCase().trim(),
        orElse: () => '');

//    print('elementExists: Line # 612:  $elementExists');

    return elementExists.toLowerCase();

  }

  void clearSubscription(){



//    _curretnOrder=null;
//    _expandedSelectedFood =[];
//    _orderType =[];
//    _paymentType =[];


//    _orderController.sink.add(_curretnOrder);
//    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
//    _orderTypeController.sink.add(_orderType);
//    _paymentTypeController.sink.add(_paymentType);


    _thisFoodItem = null;
    _currentSelectedFoodDetails = null;
    _allIngItemsDetailsBlock = [];
    _defaultIngItems = [];
    _unSelectedIngItems = [];
    _multiSelectForFood = [];
    // _allSauceItemsDBloc = [];
    // _allCheeseItemsDBloc = [];


    _controller.sink.add(_thisFoodItem);
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
    _allIngredientListController.sink.add(_allIngItemsDetailsBlock);
    _defaultIngredientListController.sink.add(_defaultIngItems);
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);
    _multiSelectForFoodController.sink.add(_multiSelectForFood);
    // _sauceItemsController.sink.add(_allSauceItemsDBloc);
    // _cheeseItemsController.sink.add(_allCheeseItemsDBloc);

  }





  @override
  void dispose() {

    _controller.close();
    _selectedFoodControllerFoodDetails.close();
    _allIngredientListController.close();
    _defaultIngredientListController.close();
    _unSelectedIngredientListController.close();
    _multiSelectForFoodController.close();
    // _sauceItemsController.close();
    // _cheeseItemsController.close();
    // _selectedSauceListController.close();
    // _selectedCheeseListController.close();
  }
}
