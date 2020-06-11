
//import 'package:flutter/material.dart';
//import 'package:zomatoblock/BLoC/bloc_provider.dart';
//import 'package:zomatoblock/BLoC/location_bloc.dart';
//import 'package:zomatoblock/BLoC/location_query_bloc.dart';
//
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';

//MODELS
//import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
//import 'package:foodgallery/src/DataLayer/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocIDViewModel.dart';

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

class FoodItemDetailsBloc implements Bloc {



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

  List<NewIngredient> _allIngItems=[];

  List<NewIngredient> _defaultIngItems = [];
  List<NewIngredient> _unSelectedIngItems = [];
  List<FoodPropertyMultiSelect> _multiSelectForFood =[];
  Order _currentOrderFoodDetails ;


//  List <NewIngredient> ingItems = new List<NewIngredient>();



  // FOR location_bloc => final _locationController = StreamController<Location>();
  // [NORMAL STREAM, BELOW IS THE BROADCAST STREAM].

  // FOR location_bloc => Stream<Location> get locationStream => _locationController.stream;

  // getter that get's the stream with _locationController.stream;
  //  Stream<Location> get locationStream => _locationController.stream;

  // declartion and access.


  //  How it know's from the Restaurant array that this are favorite;

  // 1

  Order get getCurrentOrderFoodDetails => _currentOrderFoodDetails;
  List<NewIngredient> get allIngredients => _allIngItems;

  List<NewIngredient> get getDefaultIngredients => _defaultIngItems;
  List<NewIngredient> get unSelectedIngredients => _unSelectedIngItems;


  List<FoodPropertyMultiSelect> get getMultiSelectForFood => _multiSelectForFood;





  final _orderControllerFoodDetails = StreamController <Order>.broadcast();
  final _controller = StreamController <FoodItemWithDocIDViewModel>();

  // final _itemSizeController = StreamController<Map<String, double>>(); // currentlyNotUsing.

  final _allIngredientListController =  StreamController <List<NewIngredient>>();
//  final _allIngredientListController = StreamController <List<NewIngredient>>();


  final _unSelectedIngredientListController   =  StreamController <List<NewIngredient>>();
  final _defaultIngredientListController      =  StreamController <List<NewIngredient>>();

  final _multiSelectForFoodController      =  StreamController <List<FoodPropertyMultiSelect>>();


//  final _foodItemController = StreamController <List<FoodItemWithDocID>>();

  // INVOKER -> stream: bloc.favoritesStream,

  Stream<Order> get getCurrentOrderStream => _orderControllerFoodDetails.stream;
  Stream<FoodItemWithDocIDViewModel> get currentFoodItemsStream => _controller.stream;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;

  Stream<List<NewIngredient>> get getUnSelectedIngredientItemsStream => _unSelectedIngredientListController.stream;
  Stream<List<NewIngredient>> get getDefaultIngredientItemsStream => _defaultIngredientListController.stream;

  Stream<List<FoodPropertyMultiSelect>> get getMultiSelectStream => _multiSelectForFoodController.stream;


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





  void getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

//    print('Ingredient documents are: $documents');


    _allIngItems = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }

  // CONSTRUCTOR BEGINS HERE.


  FoodItemDetailsBloc(FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped, {int fromWhichPage=1} ) {
//    getAllIngredients();

//    List<NewIngredient> allIngsScoped= _allIngItems;

//      IdentityBloc x = new IdentityBloc();
//      List<NewIngredient> p= x.allIngredients();

    if (fromWhichPage == 0) {

      print('0 means from welcome page');
      print('fromWhichPage == 0');

    }

    else if(fromWhichPage == 2){

      allIngsScoped = _allIngItems;
//      oneFoodItem= _thisFoodItem;

      FoodItemWithDocIDViewModel _thisFoodItem ;


//      List<NewIngredient> _allIngItems=[];

//      List<NewIngredient> _defaultIngItems = [];
//      List<NewIngredient> _unSelectedIngItems = [];
//      List<FoodPropertyMultiSelect> _multiSelectForFood =[];
//      Order _currentOrderFoodDetails ;


//      Order get getCurrentOrderFoodDetails => _currentOrderFoodDetails;
//      List<NewIngredient> get allIngredients => _allIngItems;
//
//      List<NewIngredient> get getDefaultIngredients => _defaultIngItems;
//      List<NewIngredient> get unSelectedIngredients => _unSelectedIngItems;
//
//
//      List<FoodPropertyMultiSelect> get getMultiSelectForFood => _multiSelectForFood;


//

      print('2 means from Food Item Details page to FoogGallery2 page [ pop ] '); // pop
      print('fromWhichPage == 2');
    }
    else {

      print(' 1 means from Food Gallery Page to Food Item Details Page');
      print(' which IS NORMAL');

      print("at the begin of Constructor [FoodItemDetailsBloc]");
      print("oneFoodItem ===> ===> ===> $oneFoodItem");
      print("allIngsScoped ===> ===> ===> $allIngsScoped");

//    _oneFoodItem = oneFoodItem;


      //  logger.w(" allIngsScoped: ", allIngsScoped);

      //  print(" allIngsScoped: $allIngsScoped ");

      /* Ordered Food Related codes starts here. */

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
        deliveryTypeIndex: 0,
        paymentTypeIndex: 4,
        ordersCustomer: oneCustomerInfo,
      );


      _currentOrderFoodDetails = constructorOrderFD;

      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);

      /* Ordered Food Related codes ends here. */


      final Map<String, dynamic> foodSizePrice = oneFoodItem.sizedFoodPrices;

      /* INGREDIENTS HANDLING CODES STARTS HERE: */
      List<String> ingredientStringsForWhereInClause;
      List <NewIngredient> ingItems = new List<NewIngredient>();


      final List<dynamic> foodItemIngredientsList2 = oneFoodItem.ingredients;
      List<String> listStringIngredients = dynamicListFilteredToStringList(
          foodItemIngredientsList2);

//    print('listStringIngredients: $listStringIngredients');
//      logger.w('listStringIngredients at foodItem Details Block line # 160',
//          listStringIngredients);


//    List<NewIngredient> allIngsScoped = getAllIngredients();


      // DDD todo

//    print('allIng_s : $allIngsScoped');

      if (listStringIngredients.length != 0) {
        filterSelectedDefaultIngredients(allIngsScoped,
            listStringIngredients); // only default<NewIngredient>

        filterUnSelectedIngredients(allIngsScoped,
            listStringIngredients); // only default<NewIngredient>


      }

      else {
        print('at else statement:  ===> ===> ===> ===>');

        print('allIngsScoped.length  ===> ===> ===> ===> ${allIngsScoped
            .length}');
        NewIngredient c1 = new NewIngredient(
            ingredientName: 'None',
            imageURL: 'None',

            price: 0.01,
            documentId: 'None',
            ingredientAmountByUser: 1000

        );

        ingItems.add(c1);

//      _allIngItems = ingItems;

//      _allIngredientListController.sink.add(ingItems);

//      _unSelectedIngredientListController
        _defaultIngItems = ingItems;
        _defaultIngredientListController.sink.add(ingItems);


        List<NewIngredient> unSelectedDecremented =
        allIngsScoped.map((oneIngredient) =>
            NewIngredient.updateIngredient(
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


      dynamic normalPrice = foodSizePrice['normal'];

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

      _controller.sink.add(thisFood);
    }
  }

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
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      itemName: 'VSM',
      itemTextColor: '0xffFEE295',
    );


    FoodPropertyMultiSelect _m = new FoodPropertyMultiSelect(
      borderColor: '0xffB47C00',
      index: 1,
      isSelected: false,
      itemName: 'M',
      itemTextColor: '0xffB47C00',
    );


    List <FoodPropertyMultiSelect> multiSelectArray = new List<FoodPropertyMultiSelect>();

    multiSelectArray.addAll([_m,_vsm, _vs,_org]);

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _multiSelectForFoodController.sink.add(_multiSelectForFood);

  }

  /*  Below ARE OrderedFoodItem related codes decrement increment( SET) */
  void decrementOneSelectedFoodForOrder(/* SelectedFood oneSelectedFoodFD,
   first arg IS NOT REQUIRED FOR DECREMENT */itemCount){



    print('/// ////         // itemCount at DEC : $itemCount');
    int numberOFSelectedFoods;
    Order tempOrderDecrementOperation = _currentOrderFoodDetails;

    if(itemCount==1){

      print('_currentOrderFoodDetails.selectedFoodInOrder[0].quantity:'
          '${_currentOrderFoodDetails.selectedFoodInOrder[tempOrderDecrementOperation.selectedFoodListLength-1].quantity}');

      
      int newSelectedFoodOrderLength = tempOrderDecrementOperation.selectedFoodListLength-1;


      // from 1 to 0 and passed as parameter.
      tempOrderDecrementOperation.selectedFoodInOrder.removeAt(newSelectedFoodOrderLength);

      // remove at 0 means first item.

      //      List x=[1,2,3,4];
//      print('List(0) $List(0)');


      tempOrderDecrementOperation.selectedFoodListLength= newSelectedFoodOrderLength;

      _currentOrderFoodDetails = tempOrderDecrementOperation;

      print('_currentOrderFoodDetails.selectedFoodInOrder.length:'
          +'${_currentOrderFoodDetails.selectedFoodInOrder.length} ');

      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);
    }
    else{

      // _itemCount= itemCount > 0;

//      if(tempOrderDecrementOperation.selectedFoodInOrder == null){
//        print(' ** ***  ****  THIS PROBABLY WILL NOT EXECUTE EVER');
//
//        numberOFSelectedFoods = 0;
//      }
//      else{

    print('tempOrderDecrementOperation.selectedFoodInOrder: ${tempOrderDecrementOperation.selectedFoodInOrder}');
        numberOFSelectedFoods=  tempOrderDecrementOperation.selectedFoodInOrder.length;
        print('tempOrderDecrementOperation.selectedFoodInOrder.length:'
            +'${tempOrderDecrementOperation.selectedFoodInOrder.length} ');
//      }

      print('at DEC __ ** __ ** numberOFSelectedFoods: $numberOFSelectedFoods');

      tempOrderDecrementOperation.selectedFoodInOrder[numberOFSelectedFoods-1].quantity = itemCount-1;
      //ITEMCOUNT IS --ITEMCOUNT WHEN SENT AS PARAMETER.


      print('at DEC quantity: ___ * ||'
          ' ${tempOrderDecrementOperation.selectedFoodInOrder[numberOFSelectedFoods-1].quantity}');


      _currentOrderFoodDetails = tempOrderDecrementOperation;

      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);
    }





//    x.selectedFoodInOrder.add(constructorSelectedFoodFD);
  }

  void incrementOneSelectedFoodForOrder(SelectedFood oneSelectedFoodFD,int  initialItemCount  /*ItemCount */){





    print('_   _    _ itemCount _   _   _:$initialItemCount');



  // work 01

    /*
    if( ItemCount == 0 ) {

      print( '>>>> itemCount == 0  <<<< ');
      logger.e('oneSelectedFoodFD.quantity: ', oneSelectedFoodFD.quantity);

      Order tempOrderIncrementOperation = _currentOrderFoodDetails;

      tempOrderIncrementOperation.selectedFoodInOrder.add(oneSelectedFoodFD);

      print('length: of // tempOrderIncrementOperation.selectedFoodInOrder:'
          ' ${tempOrderIncrementOperation.selectedFoodInOrder.length}');

      int lengthOfSelectedItemsLength=  tempOrderIncrementOperation.selectedFoodListLength;


      logger.e(' ANY CHANGES IN HERE ? tempOrderIncrementOperation.selectedFoodInOrder[itemCount].quantity: ',

          tempOrderIncrementOperation.selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity);


      _currentOrderFoodDetails = tempOrderIncrementOperation;

      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);

    }
    */

    if( initialItemCount == 0 ) {

      print( '>>>> initialItemCount == 0  <<<< ');
//      logger.e('oneSelectedFoodFD.quantity: ', oneSelectedFoodFD.quantity);

      Order tempOrderIncrementOperation = _currentOrderFoodDetails;

      tempOrderIncrementOperation.selectedFoodInOrder.add(oneSelectedFoodFD);

      print('length: of // tempOrderIncrementOperation.selectedFoodInOrder:'
          ' ${tempOrderIncrementOperation.selectedFoodInOrder.length}');

      tempOrderIncrementOperation.selectedFoodListLength = 1;

      int lengthOfSelectedItemsLength =  tempOrderIncrementOperation.selectedFoodListLength;

//      List x=[1,2,3,4];
//      print('List(0) $List(0)');


      print('lengthOfSelectedItemsLength: $lengthOfSelectedItemsLength');

      List<SelectedFood> x2 = tempOrderIncrementOperation.selectedFoodInOrder;

      print('x2: $x2');
      print('x2[lengthOfSelectedItemsLength]: ${x2[lengthOfSelectedItemsLength-1]}');

      print('x2[lengthOfSelectedItemsLength].quantity: ${x2[lengthOfSelectedItemsLength-1].quantity}');


      /*

      logger.e(' ANY CHANGES IN HERE ? tempOrderIncrementOperation.selectedFoodInOrder[itemCount].quantity: ',

          tempOrderIncrementOperation.selectedFoodInOrder[lengthOfSelectedItemsLength].quantity);
      */


      _currentOrderFoodDetails = tempOrderIncrementOperation;

      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);

    }
    else{

//      int numberOFSelectedFoods;
      Order tempOrderIncrementOperation = _currentOrderFoodDetails;

      /*
      if(tempOrderIncrementOperation.selectedFoodInOrder.length==0){
        print(' ** ***  ****  THIS PROBABLY WILL NOT EXECUTE EVER');

        numberOFSelectedFoods= 0;
      }
      else{
        numberOFSelectedFoods =  tempOrderIncrementOperation.selectedFoodInOrder.length;
      }

      print(' INC __ ** __ ** numberOFSelectedFoods: $numberOFSelectedFoods');

//      logger.e('oneSelectedFoodFD.quantity: ', oneSelectedFoodFD.quantity);
//      Order constructorOrderFD = _currentOrderFoodDetails;
*/
      int lengthOfSelectedItemsLength=  tempOrderIncrementOperation.selectedFoodListLength;

      tempOrderIncrementOperation.selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity =
          tempOrderIncrementOperation.selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity + 1;

      // first time was set to 1, thus adding 1 required , please check the _itemCount state.


      print('quantity: * * * '
          '${tempOrderIncrementOperation.selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity}');

      _currentOrderFoodDetails = tempOrderIncrementOperation;


      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);



//      constructorOrderFD.selectedFoodInOrder.add(oneSelectedFoodFD);
//
//      _currentOrderFoodDetails = constructorOrderFD;
//
//      _orderControllerFoodDetails.sink.add(_currentOrderFoodDetails);

    }

//    x.selectedFoodInOrder.add(constructorSelectedFoodFD);
  }

  /*  ABOVE ARE OrderedFoodItem related codes*/

  void setMultiSelectOptionForFood(FoodPropertyMultiSelect x, int index){


    List <FoodPropertyMultiSelect> multiSelectArray = _multiSelectForFood;

    x.isSelected= !x.isSelected;
    multiSelectArray[index]=x;

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _multiSelectForFoodController.sink.add(_multiSelectForFood);
  }



  // CONSTRUCTOR ENDS HERE.

  /*
    else {
      FoodItemWithDocIDViewModel thisFood = new FoodItemWithDocIDViewModel(
        itemName: oneFoodItem.itemName,
        categoryName: oneFoodItem.categoryName,
        sizedFoodPrices: oneFoodItem.sizedFoodPrices,
        uploadDate: oneFoodItem.uploadDate,
        imageURL: oneFoodItem.imageURL,
        content: oneFoodItem.content,
        ingredients: oneFoodItem.ingredients,
        itemId: oneFoodItem.itemId,
        indicatorValue: oneFoodItem.indicatorValue,
        isAvailable: oneFoodItem.isAvailable,
        isHot: oneFoodItem.isHot,
        uploadedBy: oneFoodItem.uploadedBy,
        documentId: oneFoodItem.documentId,
        itemSize: 'normal',
        itemPrice: normalPriceCasted,
      );

      _controller.sink.add(thisFood);
    }
    */



//    _currentSize['normal']=changedPrice;

//    _itemSizeController.sink.add(_currentSize);






  //    if normal is there

  //   String key = foodSizePrice.keys.where((oneKey) =='normal').toString();


  // other wise map will return ToDo check values






  /*
    logger.i('foodSizePrice: ',foodSizePrice);
            dynamic normalPrice = foodSizePrice['normal'];


            num normalPrice3 = foodSizePrice['normal'];




            print('normalPrice1: $normalPrice ');
            print('normalPrice2: ${foodSizePrice['normal']} ');
            print('normalPrice3: $normalPrice3');

            print('euroPrice1: $normalPrice ');
            double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);
    */
//    if(oneFoodItem.si)
//      _currentSize['normal'] =normalPrice;


//      _itemSizeController.sink.add(_currentSize);

//    _allFoodsList.add(oneFoodItemWithDocID);




//    getAllFoodItems();
//    getAllCategories();

//    this.getAllFoodItems();
//    this.getAllCategories();

/*
  void getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    print('documents are: $documents');


    _allIngItems = ingItems;

    _allIngredientListController.sink.add(ingItems);

    return ingItems;

  }

  */




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


  }

  void updateDefaultIngredientItems(/*NewIngredient unSelectedOneIngredient,int index*/){
    print('reached here ==> : <==  update Default IngredientItem ');

    List<NewIngredient> allDefaultIngredientItems = _defaultIngItems;

    List<NewIngredient> allPreviouslyUnSelectedIngredientItems = _unSelectedIngItems;

    List <NewIngredient> valueIncrementedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser >0).toList();


    List <NewIngredient> valueUnChangedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser == 0).toList();

//    List<String> stringList = List<String>.from(dlist);
//    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
//    ==
//    isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

    allDefaultIngredientItems.addAll(valueIncrementedUNselectedIngredient);

    _defaultIngItems= allDefaultIngredientItems;
//    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _defaultIngredientListController.sink.add(_defaultIngItems);


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


    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);



  }


  // HELPER METHOD tryCast Number (1)
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

  // HELPER METHOD  dynamicListFilteredToStringList Number (2)

  List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
        ==
        isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

  }

  // HELPER METHOD  isIngredientExist ==> NUMBER 3


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

  // helper method 04 filterSelectedDefaultIngredients
  filterSelectedDefaultIngredients(List<NewIngredient> allIngList , List<String> listStringIngredients2) {
// foox

//    logger.w("at filterSelectedDefaultIngredients","filterSelectedDefaultIngredients");



//    print("allIngList: $allIngList");

    print("listStringIngredients2: $listStringIngredients2");



    List<NewIngredient> default2 =[];
//    List<NewIngredient> y = [];
    listStringIngredients2.forEach((stringIngredient) {
      NewIngredient elementExists = allIngList.where(
              (oneItem) => oneItem.ingredientName.trim().toLowerCase()
              == stringIngredient.trim().toLowerCase()).first;

      print('elementExists: $elementExists');
      // WITHOUT THE ABOVE PRINT STATEMENT SOME TIMES THE APPLICATION CRUSHES.

      default2.add(elementExists);

    });

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
//      print('elementUNSelected: $elementUNSelected');


    List<NewIngredient> unSelectedDecremented =
    unSelectedIngredientsFiltered.map((oneIngredient)=>
        NewIngredient.updateIngredient(
            oneIngredient
        )).toList();

//    print('unSelectedIngredientsFiltered ===>  ${unSelectedDecremented.length}');


//      Set<NewIngredient> unSelectedIngredientsFilteredSet = unSelectedIngredientsFiltered.toSet();
//
//      elementUNSelected.addAll(unSelectedIngredientsFilteredSet);





//        print('unSelectedIngredientsFiltered: $unSelectedIngredientsFiltered');
//        elementUNSelected =  unSelectedIngredientsFiltered;

//


//    List<NewIngredient> convertSetToList = elementUNSelected.toList();

    _unSelectedIngItems = unSelectedDecremented;
//    _defaultIngredientListController.sink.add(default2);
    _unSelectedIngredientListController.sink.add(unSelectedDecremented);

//    return allUnSelected;

//    logger.i('allUnSelected: ',unSelectedDecremented);

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





  @override
  void dispose() {
    _controller.close();
    _orderControllerFoodDetails.close();
//    _itemSizeController.close();
    _allIngredientListController.close();
    _defaultIngredientListController.close();
    _unSelectedIngredientListController.close();
    _multiSelectForFoodController.close();
  }
}
