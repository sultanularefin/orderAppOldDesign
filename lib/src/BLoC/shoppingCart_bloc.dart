

//### EXTERNAL PACKAGES
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'; // to be removed later.
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/Restaurant.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:intl/intl.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';


import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';
//import 'package:wifi/wifi.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


//printing blue tooth or wifi in same local area network.

//import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';




//MODELS


class ShoppingCartBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();



//  PRINTING RELATED objects put here Beginning {.


  final FirebaseAuth _auth = FirebaseAuth.instance; // TO BE REMOVE LATER.

//  PRINTING RELATED objects put here } ends .
//  List<Order> _curretnOrder = [];

  Order _curretnOrder ;
  List<OrderTypeSingleSelect>   _orderType;
  List<PaymentTypeSingleSelect> _paymentType;
  List<SelectedFood> _expandedSelectedFood =[];

//  List<SelectedFood> _savedSelectedFood    =[];


//  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  Order get getCurrentOrder => _curretnOrder;
  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
  List<PaymentTypeSingleSelect> get getCurrentPaymentType => _paymentType;
  List<SelectedFood> get getExpandedSelectedFood => _expandedSelectedFood;

//  List<SelectedFood> get getSavedSelectedFood => _savedSelectedFood;

//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;



  final _orderController = StreamController <Order>();

  final _expandedSelectedFoodController =  StreamController<List<SelectedFood>>/*.broadcast*/();

//  final _savedSelectedFoodController =  StreamController<List<SelectedFood>>();

  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
  final _paymentTypeController = StreamController <List<PaymentTypeSingleSelect>>.broadcast();

//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();


  Stream<Order> get getCurrentOrderStream => _orderController.stream;

  Stream  <List<SelectedFood>> get getExpandedFoodsStream => _expandedSelectedFoodController.stream;

  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
      _orderTypeController.stream;

  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream =>
      _paymentTypeController.stream;

//  Stream  <List<SelectedFood>> get getSavedFoodsStream => _savedSelectedFoodController.stream;


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();



//  List<String> _devices =[];
//  List<String> get getDevices => _devices;
//  final _devicesController = StreamController<List<String>>();
//  Stream <List<String>> get getDevicesStream => _devicesController.stream;

  /*
  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
      _customerInformationController.stream;
  */

  Restaurant _thisRestaurant ;

  Restaurant get getCurrentRestaurant => _thisRestaurant;
  final _restaurantController = StreamController <Restaurant>();
  Stream<Restaurant> get getCurrentRestaurantsStream => _restaurantController.stream;

// BLUETOOTH PRINTER DEVICES..

  List<PrinterBluetooth> _devicesBlueTooth = [];
  //  List<String> _devices =[];
  List<PrinterBluetooth> get getDevices => _devicesBlueTooth;
  final _devicesController = StreamController<List<PrinterBluetooth>>();
  Stream <List<PrinterBluetooth>> get getDevicesStream => _devicesController.stream;


  //  List<PrinterBluetooth> blueToothDevicesState = [];



  Future<void> getRestaurantInformationConstructor() async{

    var snapshot = await _client.fetchRestaurantDataClient();


    Map     <String,dynamic> restaurantAddress = snapshot['address'];
    Map     <String,dynamic> restaurantAttribute = snapshot['attribute'];
    List    <dynamic> restaurantCousine = snapshot['cousine'];
    bool    restaurantKidFriendly =  snapshot['kid_friendly'];
    bool    restaurantReservation = snapshot['reservation'];
    bool    restaurantRomantic  = snapshot['romantic'];
    List    <String> restaurantOffday = snapshot['offday'];

    String  restaurantOpen = snapshot['open'];



    String  restaurantAvatar =snapshot['avatar']==''?
    'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        :''
        + storageBucketURLPredicate +
        Uri.encodeComponent(snapshot['avatar'])
        +'?alt=media';
    // 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/'

    print('restaurantAvatar: $restaurantAvatar');


    String  restaurantContact= snapshot['contact'];

    double  restaurantDeliveryCharge = snapshot['deliveryCharge'];
    int restaurantDiscount0 =snapshot['discount'];// from string;// need to convert string to double.
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is num);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is int);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is double);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is String);

    final double restaurantDiscount = restaurantDiscount0.toDouble();
//    final double foodItemDiscount = doc['discount'];
    String  restaurantName =snapshot['name'];

    print('restaurantName: $restaurantName');
    double  restaurantRating =snapshot['rating'];
    double  restaurantTotalRating =snapshot['totalRating'];


    Restaurant onlyRestaurant = new Restaurant(
      address:restaurantAddress,
      attribute: restaurantAttribute,
      cousine: restaurantCousine,
      kidFriendly:restaurantKidFriendly, // kid_friendly
      reservation:restaurantReservation,
      romantic:restaurantRomantic,
      offday:restaurantOffday,
      open: restaurantOpen,
      avatar: restaurantAvatar,
      contact: restaurantContact,
      deliveryCharge: restaurantDeliveryCharge,
      discount: restaurantDiscount,// from string;// need to convert string to double.
      name: restaurantName,
      rating: restaurantRating,
      totalRating :restaurantTotalRating,
    );

    _thisRestaurant= onlyRestaurant;
    _restaurantController.sink.add(_thisRestaurant);

//    _foodItemController.sink.add(_allFoodsList);

  }

  // CONSTRUCTOR BEGINS HERE.


  ShoppingCartBloc(
      /*FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped */
      Order x
      ) {

    /*
    if(x.page==1){
      cancelButtonPressed();

    }
    else {
  */
//      logger.e('enterred into ShoppingCartBloc ');

//    Order x = new Order(
//      foodItemName: foodItemDetailsbloc.currentFoodItem.itemName,
//      foodItemImageURL: foodItemDetailsbloc.currentFoodItem.imageURL,
//      unitPrice:initialPriceByQuantityANDSize ,
//      foodDocumentId: foodItemDetailsbloc.currentFoodItem.documentId,
//      quantity: _itemCount,
//      foodItemSize: _currentSize,
//      ingredients: foodItemDetailsbloc.getDefaultIngredients,
//    );


//    getAllIngredients();

//    List<NewIngredient> allIngsScoped= _allIngItems;
    print("at the begin of Constructor [ShoppingCartBloc]");

//    print('food Item name in Shopping Cart BlocK ${x.foodItemName}');

    print('x.paymentTypeIndex: ${x.paymentTypeIndex}');
    int paymentTypeIndex = x.paymentTypeIndex;

    initiateOrderTypeSingleSelectOptions();

    //initiate scanner.
    printerManager.startScan(Duration(seconds: 4));
//    printerManager.startScan(Duration(seconds: 4));

    getRestaurantInformationConstructor();

    initiatePaymentTypeSingleSelectOptions(paymentTypeIndex);


    List<SelectedFood> allOrderedFoods = x.selectedFoodInOrder;


//    _savedSelectedFood = allOrderedFoods;
//    _savedSelectedFoodController.sink.add(_savedSelectedFood);


    List<SelectedFood> selectedFoodforDisplay = new List<SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


    allOrderedFoods.forEach((oneFood) {
      print('oneFood details: ===> ===> ');
      print('oneFood: ${oneFood.foodItemName}');
      logger.e('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
      List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

      print('MOMENT OF TRUTH: ');
      print(':::: ::: :: $test');
      selectedFoodforDisplay.addAll(test);
    });


//      selectedFoodforDisplay.addAll(test);

//      logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
    print('item count : ${selectedFoodforDisplay.length}');

    print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');

    _expandedSelectedFood = selectedFoodforDisplay;
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);


    discoverDevicesConstructor();
    //    initiateCustomerInformation();

    _curretnOrder = x;
    _orderController.sink.add(x);
//    }

  }
// CONSTRUCTOR ENDS HERE.



  List<SelectedFood> makeMoreFoodByQuantity(SelectedFood X){

    int fillingLength = X.quantity;
    print('X X is $X');
    print('X.quantity is: ${X.quantity}');

    SelectedFood oneSelectedFood = X;
    oneSelectedFood.quantity = 1;
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');
    print('oneSelectedFood.foodItemName is: ${oneSelectedFood.foodItemName}');

    List<SelectedFood> multiplied = List.filled(fillingLength, oneSelectedFood);

    print('\n \n AFTER ... FILLING');
    print('X.quantity is: $fillingLength');
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');

    print('multiplied: $multiplied');

//    List<SelectedFood> multiplied2 = new List<SelectedFood>(X.quantity);
//    List.filled(int length, E fill, {bool growable = false});

    return multiplied;
  }
  /*

  void initiateCustomerInformation(){
    CustomerInformation customerInfoAtConstructor = new CustomerInformation(
      address:'',
      flatOrHouseNumber:'',
      phoneNumber:'',
      etaTimeInMinutes:-1,
//        CustomerInformation currentUser = _oneCustomerInfo;
//    currentUser.address = address;
//

    );
    _oneCustomerInfo = customerInfoAtConstructor;
    _customerInformationController.sink.add(_oneCustomerInfo);
  }
  */

  void initiatePaymentTypeSingleSelectOptions(int selectedPayment){
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );

    PaymentTypeSingleSelect Cash = new PaymentTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      paymentTypeName: 'Cash',
      iconDataString: 'FontAwesomeIcons.twitter',

      paymentIconName: 'Cash',
    );


//     0xffFEE295 false
    PaymentTypeSingleSelect Card = new PaymentTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      paymentTypeName: 'Card',
      iconDataString: 'FontAwesomeIcons.home',

      paymentIconName: 'Card',
    );

//
//    OrderTypeSingleSelect _dinningRoom = new OrderTypeSingleSelect(
//      borderColor: '0xffB47C00',
//      index: 3,
//      isSelected: false,
//      orderType: 'DinningRoom',
//      iconDataString: 'Icons.audiotrack',
//      orderIconName: 'fastfood',
//    );



    List <PaymentTypeSingleSelect> paymentTypeSingleSelectArray = new List<PaymentTypeSingleSelect>();


    paymentTypeSingleSelectArray.addAll([Later, Cash, Card  ]);

    paymentTypeSingleSelectArray[selectedPayment].isSelected =true;

    _paymentType = paymentTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _paymentTypeController.sink.add(_paymentType);
  }

  void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){

    print('new Payment Index is $newPaymentIndex');
    print('old Payment Index is $oldPaymentIndex');


    List <PaymentTypeSingleSelect> singleSelectArray = _paymentType;
//    _currentOrderTypeIndex

    /*
    logger.w('singleSelectArray[oldPaymentIndex].isSelected:'
        ' ${singleSelectArray[oldPaymentIndex].isSelected}');


    */

    singleSelectArray[oldPaymentIndex].isSelected =
    !singleSelectArray[oldPaymentIndex].isSelected;

    /*
    logger.w('singleSelectArray[oldPaymentIndex].isSelected:'

        ' ${singleSelectArray[oldPaymentIndex].isSelected}');

     */

    singleSelectArray [newPaymentIndex].isSelected =
    !singleSelectArray[newPaymentIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.paymentTypeIndex = newPaymentIndex;


    _paymentType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();

    _paymentTypeController.sink.add(_paymentType);
    _orderController.sink.add(_curretnOrder);
  }


  //PAYMENT FIRESTORE =>



//  Future<OneOrderFirebase> fetchOrderDataFromFirebase(String orderDocumentId) async {
  Future<String> recitePrinted(String orderDocumentID,String status) async{

    String documentID = orderDocumentID;


    var updateResult =
    await _client.updateOrderCollectionDocumentWithRecitePrintedInformation(documentID,status);

    print('updateResult is:: :: $updateResult');



    String                    recitePrintedString = updateResult['recitePrinted'];

    print('recitePrintedString: $recitePrintedString');

    return recitePrintedString;

  }

  Future<Order> paymentButtonPressed(Order payMentProcessing) async{

    String orderBy =    _orderType[payMentProcessing.orderTypeIndex].orderType;
//    logger.i('payment Button Pressed is payMentProcessing.orderTypeIndex ${payMentProcessing.orderTypeIndex} ::'
//        ' orderBy: $orderBy    ${_curretnOrder.paymentTypeIndex}');




    String paidType0 =  _paymentType[payMentProcessing.paymentTypeIndex].paymentTypeName;

    // where should i put cancelButtonPressed();
//
    // payMentProcessing
    Order tempOrder= payMentProcessing;

    tempOrder.paymentButtonPressed=true;


    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020.


    _curretnOrder=tempOrder;
    _orderController.sink.add(_curretnOrder);

    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020. ends here.


//    _curretnOrder= tempOrder;

//    List<SelectedFood> selectedFoodCheckForList = tempOrder.selectedFoodInOrder;

    List<SelectedFood> selectedFoodCheckForList = _expandedSelectedFood;
    int length =tempOrder.selectedFoodListLength;


//    logger.e('tempOrder.selectedFoodListLength ${tempOrder.selectedFoodListLength}');
//
//    logger.e('selectedFoodCheckForList: $selectedFoodCheckForList');

//    print('selectedFoodCheckForList[3].quantity => ${selectedFoodCheckForList[3].quantity}');

    Set<SelectedFood> selectedFoodCheckForListToSet= selectedFoodCheckForList.toSet();

    int lengthOfNotDuplicateFoods= selectedFoodCheckForListToSet.length;

//    unDuplicatedSelectedFoods
//

    selectedFoodCheckForListToSet.forEach((oneFood) {


      for(int i=0;i<selectedFoodCheckForList.length;i++){
        if(oneFood==selectedFoodCheckForList[i]){
          oneFood.quantity= oneFood.quantity +1;
        }
      }

//      print('oneFood details: ===> ===> ');
//      print('oneFood: ${oneFood.foodItemName}');
//      logger.i('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');



    });

    selectedFoodCheckForListToSet.forEach((oneFood) {

      oneFood.quantity= oneFood.quantity-1; //initially 1 that was incremented in the previous forEach loop.
      print('oneFood.quantity SS: ${oneFood.quantity}');





    });



//    print('${selectedFoodCheckForListToSet.}')


    tempOrder.selectedFoodInOrder = selectedFoodCheckForListToSet.toList();





    String documentID = await _client.insertOrder(tempOrder,orderBy,paidType0);


    print('documentID: $documentID');

    if(documentID!=null){
      tempOrder.orderdocId= documentID;

      _curretnOrder=null;
      _expandedSelectedFood =[];
      _orderType =[];
      _paymentType =[];


      // required to properly show data in the receipt thus don't clear _currentOrder object.
      _curretnOrder=tempOrder;
      _orderController.sink.add(_curretnOrder);


      return tempOrder;

    }
    else{
      return tempOrder;
    }



  }

  List<NewIngredient> convertFireStoreIngredientItemsToLocalNewIngredientItemsList(List<dynamic>
  fireStoreNewIngredients){

    print('at convertFireStoreIngredientItemsToLocalNewIngredientItemsList');

    // List<Map<String, dynamic>>

//    print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : ');

    List<NewIngredient> allIngredientItems = new List<NewIngredient>();

    int ingredientCount =0;
    fireStoreNewIngredients.forEach((oneFireStoreSauce) {

      var oneNewIngredient = oneFireStoreSauce;


      NewIngredient oneTempNewIngredient = new NewIngredient(
        ingredientName: oneFireStoreSauce['name'] ,
        imageURL: oneFireStoreSauce['image'] ,
        ingredientAmountByUser: oneFireStoreSauce['ingredientAmountByUser'] ,
        isDefault:oneFireStoreSauce['isDefault'],
        price:oneFireStoreSauce['price'],
//          isDefault: oneFireStoreSauce['isDefault'],

      );

      print('--   ::      :: at here: convertFireStoreIngredientItemsToLocalNewIngredientItemsList -------- : :'
          ' for ingredient: ${oneTempNewIngredient.ingredientName} ');

      print('name: ${oneTempNewIngredient.ingredientName} '
          'imageURL: ${oneTempNewIngredient.imageURL} price: ${oneTempNewIngredient.price},'
          ' ingredientAmountByUser: ${oneTempNewIngredient.ingredientAmountByUser}... isDefault: ${oneTempNewIngredient.isDefault}');


      allIngredientItems.add(oneTempNewIngredient);

      ingredientCount = ingredientCount +1;

    });

    logger.i('total Ingredient count: $ingredientCount');

    return allIngredientItems;
//    return sf.length
  }

//  convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']),

  List<CheeseItem> convertFireStoreCheeseItemsToLocalCheeseItemsList(List<dynamic> fireStoreCheeseItems){


    // List<Map<String, dynamic>>

    print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : : ');

    List<CheeseItem> allCheeseItems = new List<CheeseItem>();

    int cheeseItemCount= 0;
    fireStoreCheeseItems.forEach((oneFireStoreCheese) {

      var oneCheeseItem = oneFireStoreCheese;


      CheeseItem oneTempCheeseItem = new CheeseItem(
        cheeseItemName: oneCheeseItem['name'] ,
        imageURL: oneCheeseItem['image'] ,
        cheeseItemAmountByUser: oneCheeseItem['cheeseItemAmountByUser'] ,
        price: oneCheeseItem['price'] ,
        isDefaultSelected:  oneCheeseItem['isDefaultSelected'],

      );

      print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : :'
          ' for cheeseItem: ${oneTempCheeseItem.cheeseItemName} ');

      print('CheeseItem_name: ${oneTempCheeseItem.cheeseItemName} '
          'imageURL: ${oneTempCheeseItem.imageURL} price: ${oneTempCheeseItem.price},'
          ' cheeseItemAmountByUser: ${oneTempCheeseItem.cheeseItemAmountByUser} isDefaultSelected: '
          '${oneTempCheeseItem.isDefaultSelected}');


      allCheeseItems.add(oneTempCheeseItem);

      cheeseItemCount = cheeseItemCount +1;

    });

    logger.i('cheeseItemCount: $cheeseItemCount');
    return allCheeseItems;
//    return sf.length
  }

  List<SauceItem> convertFireStoreSauceItemsToLocalSauceItemsList(List<dynamic> fireStoreSauces){
    // List<Map<String, dynamic>>

    print('at convertFireStoreSauceItemsToLocalSauceItemsList');

    List<SauceItem> allSauceItems = new List<SauceItem>();

    int sauceCount= 0;
    fireStoreSauces.forEach((oneFireStoreSauce) {

      var oneSauceItem = oneFireStoreSauce;


      SauceItem oneTempSauceItem = new SauceItem(
        sauceItemName: oneSauceItem['name'] ,
        imageURL: oneSauceItem['image'] ,
        sauceItemAmountByUser: oneSauceItem['sauceItemAmountByUser'] ,
        price: oneSauceItem['price'],
        isDefaultSelected: oneSauceItem['isDefaultSelected'],

      );

      print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : for sauce: ${oneSauceItem['name']} ');

      print('sauceItemName: ${oneTempSauceItem.sauceItemName} '
          'imageURL: ${oneTempSauceItem.imageURL} price: ${oneTempSauceItem.price},'
          ' sauceItemAmountByUser: ${oneTempSauceItem.sauceItemAmountByUser} VV isDefaultSelected: '
          '${oneTempSauceItem.isDefaultSelected}');


      allSauceItems.add(oneTempSauceItem);

      sauceCount= sauceCount+ 1;
    });

    logger.i('sauceCount: $sauceCount');

    return allSauceItems;
//    return sf.length

  }

  CustomerInformation localCustomerInformationObject(Map<String,dynamic> customerAddress){
// List<Map<String, dynamic>>

    CustomerInformation oneCustomer = new CustomerInformation(
      address: customerAddress['state'],
      flatOrHouseNumber: customerAddress['apartNo'],
      phoneNumber:customerAddress['phone'],
//      etaTimeInMinutes: , ETA IS orderProductionTime
    );



    return oneCustomer;

  }


  Future<OneOrderFirebase> fetchOrderDataFromFirebase(String orderDocumentId) async {

    var snapshot = await _client.invokeClientForOneOrder(orderDocumentId);


//    List <Map<String, dynamic>>
    Map<String,dynamic>       customerAddress = snapshot['address'];
//    List <Map<dynamic, dynamic>> orderedItems = snapshot['items'];
    List<dynamic> orderedItems = snapshot['items'];
//    List<Map<String, dynamic>>
    String                    orderBy = snapshot['orderby'];
    String                    paidStatus = snapshot['paidStatus'];
    String                    paidType = snapshot['paidType'];
    double                    totalPrice = snapshot['price'];

    String                    contact = snapshot['contact'];
    String                    driverName = snapshot['driver'];
    DateTime                  endDate = snapshot['end'].toDate();
    DateTime                  startDate = snapshot['start'].toDate();

    String                    orderStatus = snapshot['status'];
    String                    tableNo = snapshot['tableNo'];
    String                    orderType = snapshot['orderType'];
    String                    documentId = orderDocumentId;
    int                    orderProductionTime= snapshot['orderProductionTime'];


    CustomerInformation currentCustomerFromFireStore = localCustomerInformationObject(customerAddress);
//    new CustomerInformation
    print('currentCustomerFromFireStore.address: ${currentCustomerFromFireStore.address}');
    print('currentCustomerFromFireStore.flatOrHouseNumber: ${currentCustomerFromFireStore.flatOrHouseNumber}');
    print('currentCustomerFromFireStore.phoneNumber: ${currentCustomerFromFireStore.phoneNumber}');
//    print('currentCustomerFromFireStore.etaTimeInMinutes: ${currentCustomerFromFireStore.etaTimeInMinutes}');



    print('orderedItems: $orderedItems');
    print('orderBy: $orderBy');
    print('paidStatus: $paidStatus');
    print('paidType: $paidType');
    print('totalPrice: $totalPrice');
    print('contact: $contact');
    print('driverName: $driverName');

    print('snapshot[\'end\'].toDate().toString(): ${snapshot['end'].toDate().toString()}');

//    DateTime d = t.toDate();
//    print(d.toString()); //2019-12-28 18:48:48.364
    print('snapshot[\'start\'].toDate().toString()${snapshot['start'].toDate().toString()}');


    print('snapshot[\'end\']: ${snapshot['end'].toDate()}');

    print('snapshot[\'start\']${snapshot['start'].toDate()}');


    print('endDate: $endDate');
    print('startDate: $startDate');

//    final now = DateTime.now();
    final formatter1 = /*DateFormat('MM/dd/yyyy H:m'); */ DateFormat.yMMMMd('en_US').add_jm();
    final String timestamp = formatter1.format(startDate);

    print('timestamp: $timestamp');
    final formatter2 =  DateFormat.jm();
    final String formattedOrderPlacementDatesTimeOnly = formatter2.format(startDate);
    print('orderProductionTime: $orderProductionTime');
//    ticket.text(timestamp,
//        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

//    new DateFormat.yMMMMd('en_US')
//    new DateFormat.jm()
//    new DateFormat.yMd().add_jm()

//    -> July 10, 1996
//    -> 5:08 PM
//    -> 7/10/1996 5:08 PM
    print('orderStatus: $orderStatus'); // "ready"
    print('tableNo: $tableNo');
    print('orderType: $orderType');
    print('documentId: $documentId');

    List<OrderedItem> allOrderedItems= new List<OrderedItem>();
    orderedItems.forEach((oneFood) {

      var oneFoodItem = oneFood;
      print('oneFoodItem[\'quantity\'] ${oneFoodItem['quantity']}!');
      print('oneFoodItem[\'name\'] ${oneFoodItem['name']}!');
      print('oneFoodItem[\'oneFoodTypeTotalPrice\'] ${oneFoodItem['oneFoodTypeTotalPrice']}!');
//      print('oneFoodItem.category: ${oneFoodItem.category}');
      print('oneFoodItem[\'category\']: ${oneFoodItem['category']}');



      print('unitPrice: ${oneFoodItem['unitPrice']}');
      print('unitPrice: ${oneFoodItem['foodImage']}');
      print('unitPrice: ${oneFoodItem['discount']}');
      print('unitPrice');
      print('foodItemSize: ${oneFoodItem['foodItemSize']}');

      List<SauceItem>     defaultSauces = convertFireStoreSauceItemsToLocalSauceItemsList(oneFoodItem['selectedSauces']);
      List<NewIngredient> selectedIngredients = convertFireStoreIngredientItemsToLocalNewIngredientItemsList(oneFoodItem['ingredients']);
      List<CheeseItem>    selectedCheeses = convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']);


      print('defaultSauces : $defaultSauces ');
      print('selectedIngredients : $selectedIngredients ');
      print('selectedCheeses : $selectedCheeses ');

      OrderedItem oneTempOrderedItem= new OrderedItem(
        category:  oneFoodItem['category'],

        selectedSauces:  defaultSauces,
        selectedIngredients: selectedIngredients,
        selectedCheeses: selectedCheeses,

        discount:  oneFoodItem['discount'],
        foodItemImage:  oneFoodItem['foodImage'],

        quantity:  oneFoodItem['quantity'],
        name:oneFoodItem['name'],
        oneFoodTypeTotalPrice:oneFoodItem['oneFoodTypeTotalPrice'],
        unitPrice:oneFoodItem['unitPrice'],
        foodItemSize: oneFoodItem['foodItemSize'],
      );



//        print('oneFoodItem[\'quantity\'] ${oneFoodItem['quantity']}!');
//        print('oneFoodItem[\'name\'] ${oneFoodItem['name']}!');
//        print('oneFoodItem[\'oneFoodTypeTotalPrice\'] ${oneFoodItem['oneFoodTypeTotalPrice']}!');


      allOrderedItems.add(oneTempOrderedItem);


    });



    /*
    orderedItems55.forEach((oneFood) {
      /* Map<String, dynamic> */ var userX2 = oneFood;

      print('oneFood[\'category\'] ${oneFood['category']}!!');
    });
    */




    OneOrderFirebase oneOrderForReceiptProduction = new OneOrderFirebase(
      oneCustomer:currentCustomerFromFireStore,
//      orderedItems:[],
      orderedItems:allOrderedItems,
      orderBy:orderBy,
      paidStatus:paidStatus,
      paidType:paidType,
      totalPrice:totalPrice,
      contact:contact,
      driverName:driverName,
      endDate:endDate,
      startDate:startDate,
      formattedOrderPlacementDate:timestamp,
      formattedOrderPlacementDatesTimeOnly:formattedOrderPlacementDatesTimeOnly,
      orderStatus:orderStatus,
      tableNo:tableNo,
      orderType:orderType,
      orderProductionTime:orderProductionTime,
      documentId:documentId,
    );





    // print('result:  IIIII   >>>>>  $result'  );


    /*
    if ((oneOrderForReceiptProduction.type != null) &&((oneOrderForReceiptProduction.totalPrice !=null))) {




      return oneOrderForReceiptProduction;
    }
    else {
      */
    return oneOrderForReceiptProduction;
  }

//    AssertionError(result.user.email);
//    print('result: ' + result.user.email);



  void clearSubscription(){


    _curretnOrder=null;
    _expandedSelectedFood =[];
    _orderType =[];
    _paymentType =[];

    _devicesBlueTooth = [];

    _thisRestaurant= null;



    _orderController.sink.add(_curretnOrder);
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
    _orderTypeController.sink.add(_orderType);
    _paymentTypeController.sink.add(_paymentType);

    _devicesController.sink.add(_devicesBlueTooth);

    _restaurantController.sink.add(_thisRestaurant);


  }

  void clearSubscriptionPayment(){


    _curretnOrder=null;
    _expandedSelectedFood =[];
    _orderType =[];
    _paymentType =[];

    _devicesBlueTooth = [];

    _thisRestaurant= null;



    _orderController.sink.add(_curretnOrder);
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);

    _orderTypeController.sink.add(_orderType);
    _paymentTypeController.sink.add(_paymentType);

    _devicesController.sink.add(_devicesBlueTooth);

    _restaurantController.sink.add(_thisRestaurant);


  }




  void initiateOrderTypeSingleSelectOptions()
  {

    OrderTypeSingleSelect _takeAway = new OrderTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: true,
      orderType: 'TakeAway',
      iconDataString: 'FontAwesomeIcons.facebook',

      orderIconName: 'flight_takeoff',
    );

    OrderTypeSingleSelect _delivery = new OrderTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      orderType: 'Delivery',
      iconDataString: 'FontAwesomeIcons.twitter',

      orderIconName: 'local_shipping',
    );


//     0xffFEE295 false
    OrderTypeSingleSelect _phone = new OrderTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      orderType: 'Phone',
      iconDataString: 'FontAwesomeIcons.home',

      orderIconName: 'phone_in_talk',
    );


    OrderTypeSingleSelect _dinningRoom = new OrderTypeSingleSelect(
      borderColor: '0xffB47C00',
      index: 3,
      isSelected: false,
      orderType: 'DinningRoom',
      iconDataString: 'Icons.audiotrack',
      orderIconName: 'fastfood',
    );



    List <OrderTypeSingleSelect> orderTypeSingleSelectArray = new List<OrderTypeSingleSelect>();


    orderTypeSingleSelectArray.addAll([_takeAway,_delivery, _phone, _dinningRoom]);

    _orderType = orderTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);

  }

  void setOrderTypeSingleSelectOptionForOrder(OrderTypeSingleSelect x, int newIndex,int oldIndex){

    print('newIndex is $newIndex');
    print('oldIndex is $oldIndex');


    List <OrderTypeSingleSelect> singleSelectArray = _orderType;
//    _currentOrderTypeIndex


    singleSelectArray[oldIndex].isSelected =
    !singleSelectArray[oldIndex].isSelected;

    singleSelectArray[newIndex].isSelected =
    !singleSelectArray[newIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.orderTypeIndex=newIndex;


    _orderType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);
    _orderController.sink.add(_curretnOrder);
  }

  setAddressForOrder(String address){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.address= address;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);

  }

  setHouseorFlatNumberForOrder(String houseOrFlatNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.flatOrHouseNumber= houseOrFlatNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.flatOrHouseNumber = houseOrFlatNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);

  }

  setPhoneNumberForOrder(String phoneNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.phoneNumber = phoneNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);
//
//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.phoneNumber=phoneNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);
  }

  // ETA = estimated time of arrival.
  setETAForOrder(String minutes){



    double minutes2 = double.parse(minutes);
    int minutes3 =minutes2.ceil(); // no need to have double

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.etaTimeInMinutes = minutes3;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.etaTimeInMinutes=minutes3;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);


  }


  /*
  Future<List<String>> discoverDevices2(String portNumber) async {
//    AuthResult result = await _auth.signInWithEmailAndPassword(email:
//    email, password: password);

    // print('result:  IIIII   >>>>>  $result'  );
    List<String> devices = [];

//    if (result.user.email != null) {
//      FirebaseUser fireBaseUserRemote = result.user;




    String ip;
    try {
      ip = await Wifi.ip;
      print('local ip:\t$ip');
    } catch (e) {

      print('ip error, please check internet');
      return devices;
    }

    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 9100;
    try {
      port = int.parse(portNumber);
    } catch (e) {
      print('port.toString()  please check $e');
    }
    print('subnet:\t$subnet, port:\t$port');


    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        devices.add(addr.ip);


      }
    });

    _devices=devices;
    _devicesController.sink.add(_devices);

    return devices;

  }

  */

//  Future <bool> checkUserinLocalStorage() async {
  void discoverDevicesConstructor(/*String portNumber*/) async {

    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');

      _devicesBlueTooth = devices;
      _devicesController.sink.add(_devicesBlueTooth);
//        blueToothDevicesState = devices;
//        localScanAvailableState=!localScanAvailableState;

    });


    //OPTION 1..

    /*
    printerManager.startScan(Duration(seconds: 4));
    printerManager.scanResults.listen((scannedDevices) {


      logger.w('scannedDevices: $scannedDevices');
      _devicesBlueTooth = scannedDevices;
      _devicesController.sink.add(_devicesBlueTooth);

//    bluetoo
    }, onDone: () {
      print("Task Done zzzzz zzzzzz zzzzzzz zzzzzzz zzzzzz zzzzzzzz zzzzzzzzz zzzzzzz zzzzzzz");
    }, onError: (error, StackTrace stackTrace) {
      print("Some Error $stackTrace");
    });

    */


  }



  //  Future <bool> checkUserinLocalStorage() async {
  Future<List<PrinterBluetooth>> discoverDevicesInitState() async {

    printerManager.startScan(Duration(seconds: 4));
    printerManager.scanResults.listen((scannedDevices) {
//      setState(() {
//        _devices=scannedDevices;
//      });
      _devicesBlueTooth = scannedDevices;

      logger.w('scannedDevices: $scannedDevices');
      _devicesController.sink.add(_devicesBlueTooth);
      return _devicesBlueTooth;


//    bluetoo
    }, onDone: () {
      print("Task Done: zzzzz zzzzzz zzzzzzz  zzzzzzzzz zzzzzzz zzzzzzz");
//      _devicesBlueTooth = scannedDevices;

    }, onError: (error, StackTrace stackTrace) {
      print("Some Error: $stackTrace");
    },cancelOnError: false);

    return _devicesBlueTooth;




  }






  @override
  void dispose() {
    _orderController.close();
    _expandedSelectedFoodController.close();
//    _savedSelectedFoodController.close();
    _orderTypeController.close();
    _paymentTypeController.close();
    _devicesController.close();
    _restaurantController.close();
//    _customerInformationController.close();
//    _multiSelectForFoodController.close();

  }
}