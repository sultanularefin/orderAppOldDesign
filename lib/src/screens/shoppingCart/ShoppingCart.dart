

//food_gallery.dart



// dependency files
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Image;
//import 'package:image/image.dart';
import 'package:flutter/services.dart'; // InputFormatters.
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';
import 'package:foodgallery/src/welcomePage.dart';
import 'package:image/image.dart' as ImageAliasAnotherSource;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/Restaurant.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:dotted_border/dotted_border.dart';


/* classes added */
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

//import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:oktoast/oktoast.dart';
import 'dart:async';

//  TODO: REdirect to food gallery page after pay button is pressed.

/*
* MODIFICATIONS: for REAL DEVICES.
1.
onTap: () =>  _testPrintDummyDevices(blueToothDevicesState[index]),

above to below for real devices.

onTap: () => _testPrint(blueToothDevicesState[index]),
* _testPrint(blueToothDevicesFromStream[index])

*
*
*
*
2.
  void _startScanDummyDevices() {
  *
  *
  * above to below for real devices.

  void _startScanDevices() {


* */




import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';



import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/DataLayer/models/Order.dart';

// model files

import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';

// LOCAL SCREEN FILES:

import './widgets/ShoppingCartPagePainters.dart';

final Firestore firestore = Firestore();



class ShoppingCart extends StatefulWidget {
//  AdminFirebase({this.firestore});


  final Widget child;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  final FoodItem oneFoodItemData;

//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  ShoppingCart({Key key, this.child}) : super(key: key);

  @override
  _ShoppingCartState createState() => new _ShoppingCartState();

//  _FoodItemDetailsState createState() => _FoodItemDetailsState();


}


class _ShoppingCartState extends State<ShoppingCart> {


  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final GlobalKey<ScaffoldState> _scaffoldKeyShoppingCartPage = new GlobalKey<
      ScaffoldState>();

//  String _currentSize;
//  int _itemCount = 1;
  int _currentOrderTypeIndex = 0; // phone, takeaway, delivery, dinning.
  int _currentPaymentTypeIndex = 2; // PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
  bool showFullOrderType = true;
  bool showUserInputOptionsLikeFirstTime = true;
  bool showCustomerInformationHeader = false;
  bool showFullPaymentType = true;

  bool showEditingCompleteCustomerAddressInformation = false;
  bool showEditingCompleteCustomerHouseFlatIformation = false;
  bool showEditingCompleteCustomerPhoneIformation = false;
  bool showEditingCompleteCustomerReachoutIformation = false;


//  bool showInputtedCustomerIformation = false;

  final addressController = TextEditingController();
  final houseFlatNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final etaController = TextEditingController();


  bool loadingState = false;
  Timer _timer;


  /*
  * PRINTING RELATED STATE VARIABLES ARE HERE.
  * */

//  PrinterNetworkManager printerManager = PrinterNetworkManager();


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

//  List<PrinterBluetooth> blueToothDevicesState = [];
//  bool localScanAvailableState = true; // meant not busy.

//  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
//  List<PrinterBluetooth> _devices = [];

  /*
  String localIp = '';
  List<String> devices = [];
  bool isDiscovering = false;
  int found = -1;
  TextEditingController portController = TextEditingController(text: '9100');

  */
  /*
  * PRINTING RELATED STATE VARIABLES ENDS HERE.
  * */

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    addressController.dispose();
    houseFlatNumberController.dispose();
    phoneNumberController.dispose();
    etaController.dispose();
  }


//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false


/*
  @override
  void initState() {
//    setDetailForFood();
//    retrieveIngredientsDefault();

//    checkBlueToothDevices();




    print('debug print came to init State');
    print('debug print before invoking printerManager.scanResults.listen((devices) async { ');

    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');
      setState(() {
        blueToothDevicesState = devices;
//        localScanAvailableState=!localScanAvailableState;
      });
    });

    super.initState();
  }

  */


//  void _startScanDummyDevices() {
  void _startScanDevices() {
    print('debug print inside _startScanDevices() method ');

    setState(() {
      // blueToothDevicesState = [];
    });

    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    printerManager.startScan(Duration(seconds: 4));

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */

    /*
    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;


    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;


    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      blueToothDevicesState = tempBlueToothDevices;
    });

    */
  }


  void _startScanDummyDevices() {
    print('debug print inside _startScanDevices() method ');

    /*
    setState(() {
      blueToothDevicesState = [];
    });
    */
    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    /* printerManager.startScan(Duration(seconds: 4)); */

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */


    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;


    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;


    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      // blueToothDevicesState = tempBlueToothDevices;
    });
  }

  void _stopScanDevices() {
    print('debug print inside _stopScanDevices() method ');
    printerManager.stopScan();
    print(
        'debug print inside _stopScanDevices() method and finished calling printerManager.stopScan() method');
  }



  /// Creates an image from the given widget by first spinning up a element and render tree,
  /// then waiting for the given [wait] amount of time and then creating an image via a [RepaintBoundary].
  ///
  /// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
//  Future<Uint8List> createImageFromWidget(
  Future<Uint8List> createImageFromWidget(Widget widget,
      {
        /* Duration wait, */
        Size logicalSize,
        Size imageSize}) async {
    print('at here: $createImageFromWidget');


    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox>
    rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

//    if (wait != null) {
//      await Future.delayed(wait);
//    }
//    print('wait ** ** **: $wait');

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);
    final ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png);

//    final Uint8List bytes =  byteData.buffer.asUint8List();

//    final Uint8List bytes = data.buffer.asUint8List();
//    final Image image = decodeImage(bytes);
//
//    final Image oneImage = ImageAliasAnotherSource.decodeImage(bytes);
    // decodePng(bytes);
//    decodeImage(bytes)

//    bytesArefins = bytes;
//    uint8LIstController.sink.add(bytesArefins);

    print('byteData: $byteData');
    return
      byteData.buffer.asUint8List();

//  return;
  }

//  paidStatus
//  Widget restaurantName(String name) {

//  orderInformationAndCustomerInformationWidget

  Widget orderInformationForReciteWidget(OneOrderFirebase oneOrderForReceipt){

    print('at orderInformationForReciteWidget');
    return  new Directionality(
      textDirection: TextDirection.ltr,
      child:
      Container(
        height:100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                  ? 'Delivery'
                  :
              (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
              'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                  'takeaway') ? 'TakeAway' : 'DinningRoom',
//                    oneOrderForReceipt.orderBy
//                    'dinningRoom',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            // 1 ends here.


            Text(
              '${oneOrderForReceipt
                  .formattedOrderPlacementDatesTimeOnly}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),


            // 2 ends here.
            Text('${oneOrderForReceipt.orderProductionTime} min',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            // 3 ends here.
          ],

        ),
      ),
    );

  }


  Widget customerInformationOnlyWidget(
      OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt
            .orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');


    print('oneOrderForReceipt.orderBy: ${oneOrderForReceipt.orderBy}');

    if (oneOrderForReceipt.orderBy.toLowerCase() == 'TakeAway'.toLowerCase() ||
        oneOrderForReceipt.orderBy.toLowerCase() == 'DinningRoom'.toLowerCase()) {
      return new Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            height:50,
            child: Text('phone || address empty...',


              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(

                color: Colors.black,

                fontSize: 18, fontFamily: 'Itim-Regular',),

            ),
          )
      );
    }
    else {
      CustomerInformation customerForReciteGeneration = oneOrderForReceipt
          .oneCustomer;


//  Widget paidUnpaidDeliveryType =
      return new Directionality(
        textDirection: TextDirection.ltr,
        child:

        /// toDo: multiline. maxlines
        Container(
          height:160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                height:50,
                child: Text(
                  ((customerForReciteGeneration.address == null) ||
                      (customerForReciteGeneration.address.length == 0)) ?
                  '' : customerForReciteGeneration.address.length > 39 ?
                  customerForReciteGeneration.address.substring(0, 35) + '...' :
                  customerForReciteGeneration.address,

                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(

                    fontWeight: FontWeight.bold,
                    color: Colors.black,

                    fontSize: 18, fontFamily: 'Itim-Regular',),

                ),
              ),

              Container(
                height:50,
                child: Text(
                  ((customerForReciteGeneration.flatOrHouseNumber == null) ||
                      (customerForReciteGeneration.flatOrHouseNumber.length ==
                          0)) ?
                  '' : customerForReciteGeneration.flatOrHouseNumber.length > 39 ?
                  customerForReciteGeneration.flatOrHouseNumber.substring(0, 35) +
                      '...' :
                  customerForReciteGeneration.flatOrHouseNumber,

                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(

                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                    fontSize: 18, fontFamily: 'Itim-Regular',),

                ),
              ),

              Container(
                height:50,
                child: Text(

                  ((customerForReciteGeneration.phoneNumber == null) ||
                      (customerForReciteGeneration.phoneNumber.length == 0)) ?
                  '' : customerForReciteGeneration.phoneNumber.length > 39
                      ?
                  customerForReciteGeneration.phoneNumber.substring(0, 35) + '...'
                      :
                  customerForReciteGeneration.phoneNumber,
                  maxLines: 2,

                  textAlign: TextAlign.left,
                  style: TextStyle(

                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                    fontSize: 18, fontFamily: 'Itim-Regular',),

                ),
              ),

              // 3 ends here.
            ],
          ),
        ),
      );
    }
  }




  Widget restaurantName(String name) {
    return Directionality(
      textDirection:
      TextDirection.ltr,
      child: Text('${name.toLowerCase()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle
            (
            fontSize: 29,
            fontWeight:
            FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Itim-Regular',
          )
      ),
    );
  }

  Widget subTotalTotalDeliveryCost(double subtotal,
      {double deliveryCost: 2.50}) {


    return Directionality(

      textDirection: TextDirection.ltr,
      child:
      Container(
        height: 130,
        width: 300,

        child:

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'SUBTOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                            fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',),
                    ),
                  ),

                  // qwe
//                          '${
//                              (unObsecuredInputandPayment.totalPrice
//                                  /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
//                              '\u20AC',
                  Text(subtotal.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                          fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            // 1st row ends here.


            Container(
              height: 40,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'Delivery Cost',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(deliveryCost.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),


            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'TOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(
                    (deliveryCost + subtotal).toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }


  Widget cusomTtimerTest() {

    print('-------- .  ...  . at here: ::   ------- cusomTtimerTest');
//    _timer = new Timer(const Duration(milliseconds: 800), () {
    const Color beginColor = Colors.deepPurple;
    const Color endColor = Colors.deepOrange;
    AnimationController controller;

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
                      backgroundColor: Colors.cyanAccent,
                      valueColor:
                      ColorTween(begin: beginColor, end: endColor).animate(controller)
                  )
              ),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor:
                      ColorTween(begin: beginColor, end: endColor).animate(controller)
                  )
              ),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                      valueColor:
                      ColorTween(begin: beginColor, end: endColor).animate(controller)

                  )
              ),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.pink,

                      valueColor:
                      ColorTween(begin: beginColor, end: endColor).animate(controller)
                  )
              ),
            ),
          ],
        ),
      ),

    );
//    _timer = new Timer(const Duration(seconds: 1), () {
//
//
//     return Navigator.push(context, MaterialPageRoute(builder: (context) => FoodGallery2()));
//    });
//    });
  }



  @override
  Widget build(BuildContext context) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);


    var logger = Logger(
      printer: PrettyPrinter(),
    );


    return GestureDetector(
        onTap: () {
          print('s');
//                      Navigator.pop(context);
          FocusScopeNode currentFocus = FocusScope.of(
              context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
//                  Navigator.pop(context);

          }
        },


        child:
        Scaffold(
          key: _scaffoldKeyShoppingCartPage,
          backgroundColor: Colors.white.withOpacity(0.05),
//          backgroundColor: Colors.purpleAccent,

//      resizeToAvoidBottomPadding: false ,
          // appBar: AppBar(title: Text('Food Gallery')),
          body:
          WillPopScope(
            onWillPop: () {
              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(
                  context);
              print('at WillPopScope: ');

              List<SelectedFood> backUP = shoppingCartBloc
                  .getExpandedSelectedFood;
              print('at WillPopScope : $backUP');

              print('backUP.length == 0 ${backUP.length == 0}');


              if (backUP.length == 0) {
                Navigator.pop(context);
              }



              Order z = shoppingCartBloc.getCurrentOrder;

              print('order z: $z');
              z.selectedFoodInOrder = backUP;

              shoppingCartBloc.clearSubscription();

              logger.e('at WillPopScope Quantity: ${z.selectedFoodInOrder[0]
                  .quantity}');

              Navigator.pop(context, z);
              return new Future(() => false);
            }, child:
          SafeArea(
            child: SingleChildScrollView(
              child:

              StreamBuilder<Order>(


                  stream: shoppingCartBloc.getCurrentOrderStream,
                  initialData: shoppingCartBloc.getCurrentOrder,

                  builder: (context, snapshot) {
//            if (snapshot.hasData) {

//              print('snapshot.hasData in main build(BuildContext context) : ${snapshot.hasData}');
                    // ---
                    const Color beginColor = Colors.deepPurple;
                    const Color endColor = Colors.deepOrange;
                    AnimationController controller;

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        print(
                            'at ConnectionState.none || ConnectionState.waiting ||  ');
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
                                        backgroundColor: Colors.green,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)

                                      )
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: new CircularProgressIndicator(
                                        backgroundColor: Colors.yellow,
//                                        valueColor:
//                                            ColorTween(begin: beginColor, end: endColor).animate(controller)
                                      )
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: new CircularProgressIndicator(
                                        backgroundColor: Colors.blue,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)
                                      )
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: new CircularProgressIndicator(
                                        backgroundColor: Colors.pink,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );
                        break;

                      case ConnectionState.active:
                      default:
                        if (snapshot.data is Order) {
                          print(
                              'at snapshot.data is Order for ConnectionState.active or default ');

                          Order oneOrder = snapshot.data;
//              int x = 5;
                          if (oneOrder.paymentButtonPressed == true) {

                            print('....payment button pressed.....');
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
                                            backgroundColor: Colors
                                                .lightGreenAccent,
//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)


                                          )
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                          'printing recite... please wait.',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: new CircularProgressIndicator(
                                            backgroundColor: Color(
                                                0xffFC0000),

//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            );
                          }
                          else {
                            CustomerInformation x = oneOrder
                                .orderingCustomer;


                            logger.e(
                                '\n\n AM I EXECUTED TWICE snapshot.data !=null  in build method  ;;; \n\n ');

                            return Container(
                              height: displayHeight(context),
                              child: Column(
                                children: <Widget>[
                                  Container(

//                              alignment: Alignment.bottomCenter,
                                    height: displayHeight(context) /
                                        1.10,
                                    //width:displayWidth(context) / 1.5, /* 3.8*/
                                    width: displayWidth(context)
                                        - displayWidth(context) /
                                            5 /* this is about the width of yellow side menu */
                                    ,
//                  color:Colors.lightGreenAccent,
                                    margin: EdgeInsets.fromLTRB(
                                        12, displayHeight(context) / 16,
                                        10, 0),


                                    child: Neumorphic(
                                      // State of Neumorphic (may be convex, flat & emboss)

//                                      NeumorphicStyle
//                                      NeumorphicBoxShape
//                                      boxShape:

                                      curve: Neumorphic.DEFAULT_CURVE,
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape
                                            .concave,
                                        depth: 8,
                                        lightSource: LightSource
                                            .topLeft,
                                        color: Colors.white,
                                        boxShape: NeumorphicBoxShape
                                            .roundRect(
                                          BorderRadius.all(
                                              Radius.circular(15)),

                                        ),
                                      ),


                                      // THIS CHILD COLUMNS HOLDS THE CONTENTS OF THIS PAGE. BEGINS HERE.


                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[

//                                          /WWW??


                                          // IMAGES OF FOODS   QUANTITY TIMES PUT HERE


                                          Container(
                                            width: displayWidth(
                                                context) / 1.1,
                                            height: displayHeight(
                                                context) / 20,
                                            color: Color(0xffffffff),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start
                                              ,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: <Widget>[


                                                Container(
                                                  width: displayWidth(
                                                      context) /
                                                      1.5,
                                                  height: displayHeight(
                                                      context) / 20,
                                                  color: Color(
                                                      0xffffffff),

                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start
                                                      ,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: <
                                                          Widget>[

                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                              20, 0, 10,
                                                              0),
                                                          alignment: Alignment
                                                              .center,
                                                          child: Text(
                                                              'Shopping Cart',
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight: FontWeight
                                                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                                                color: Color(
                                                                    0xff000000),
                                                              )
                                                          ),
                                                        ),

                                                        CustomPaint(
                                                          size: Size(
                                                              0, 19),
                                                          painter: LongHeaderPainterAfterShoppingCartPage(
                                                              context),
                                                        ),


                                                      ]
                                                  ),

                                                ),

                                                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                                                Container(
//                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets
                                                      .fromLTRB(
                                                      0, 2, 0, 0),
                                                  width: displayWidth(
                                                      context) /
                                                      16,
//                                                height: displayHeight(context)/20,
                                                  color: Color(
                                                      0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        0, 0, 200, 0),
                                                    child: Icon(

                                                      Icons
                                                          .add_shopping_cart,
                                                      size: 30,
                                                      color: Color(
                                                          0xff54463E),
                                                    ),
                                                  ),


                                                ),


                                                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                                              ],
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets
                                                .fromLTRB(
                                                0, 0, 0, 0),
//                                                      padding::::
//                                          color: Colors.amberAccent,
                                            color: Colors.white,
//                                      FROM height: displayHeight(context) / 5.2 TO 4.8 ON JUNE 16
                                            height: displayHeight(
                                                context) /
                                                4.8,
                                            width: displayWidth(context)
                                                -
                                                displayWidth(context) /
                                                    5, /* this is about the width of yellow side menu */

//                                            width: displayWidth(context) * 0.57,
                                            child:

                                            //ssd

                                            StreamBuilder<
                                                List<SelectedFood>>(
                                                stream: shoppingCartBloc
                                                    .getExpandedFoodsStream,
                                                initialData: shoppingCartBloc
                                                    .getExpandedSelectedFood,

                                                builder: (context,
                                                    snapshot) {
                                                  if (snapshot
                                                      .hasData) {
                                                    List<SelectedFood> expandedSelectedFoodInOrder = snapshot
                                                        .data;


                                                    if (expandedSelectedFoodInOrder ==
                                                        null) {
                                                      print(
                                                          'Order has no data');
                                                      print(
                                                          'this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
                                                      return Container(
                                                          child: Text(
                                                              'expandedSelectedFoodInOrder == Null'));
                                                    }

                                                    else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

                                                      List<SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;


                                                      logger.e(
                                                          '\n\n AM I EXECUTED TWICE  ;;;'
                                                              ' allOrderedFoods.length: ${allOrderedFoods
                                                              .length} \n\n ');
                                                      return Container(
//                color: Colors.green,
                                                        color: Color(
                                                            0xffFFFFFF),

                                                        child: ListView
                                                            .builder(
                                                          scrollDirection: Axis
                                                              .horizontal,

                                                          reverse: false,

                                                          shrinkWrap: false,

                                                          itemCount: allOrderedFoods
                                                              .length,
                                                          // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                                                          itemBuilder: (_,
                                                              int index) {
//            return Text('ss');

                                                            return FoodImageInShoppingCart(
                                                                allOrderedFoods[index]
                                                                    .foodItemImageURL, /*OrderedFoodImageURL,*/
                                                                allOrderedFoods[index]
                                                                    .foodItemName, /*OrderedFoodItemName, */
                                                                allOrderedFoods[index]
                                                                    .selectedIngredients,
                                                                allOrderedFoods[index]
                                                                    .unitPrice,
                                                                index
                                                            );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                                                          },
                                                        ),


                                                        // M VSM ORG VS TODO. ENDS HERE.
                                                      );
                                                    }
                                                  }
                                                  else {
                                                    print(
                                                        '!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
                                                    return Container(
                                                        child: Text(
                                                            'Null'));
                                                  }
                                                }
                                            ),
                                            //ssd
                                          ),


                                          // work 1
                                          Container(
//                                        width: displayWidth(context) /1.8,
                                            width: displayWidth(
                                                context) / 1.1,
                                            child:
                                            AnimatedSwitcher(
                                              duration: Duration(
                                                  milliseconds: 1000),
//
                                              child: showFullOrderType
                                                  ?
                                              animatedWidgetShowFullOrderType()
                                                  : /*1 */
                                              animatedWidgetShowSelectedOrderType(), /* 2*/
                                              // 1 => displayHeight(context) / 20 + displayHeight(context) / 7
                                              // 2 => height: displayHeight(context) / 9,

                                            ),


                                          ),


                                          /*
                                            * INITIAL CHOOSE ORDER TYPE ENDS HERE.*/


                                          // work 2
                                          Container(
//                                          color: Colors.red,
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                                            width: displayWidth(
                                                context) / 1.1,
                                            height: displayHeight(
                                                context) /
                                                2.2,
//                                            height: displayWidth(context)/2.2
//                                          height: displayHeight(context)/2-42,
                                            // THIS HEIGHT SHOULDN'T BE GIVEN OTHERWISE
                                            // A CERTAIN PORTION OF OF THE CONTAINER
                                            // WITH YELLOW ACCENT BG COLOR IS
                                            // THERE WHEN THE CHILD WIDGETS ARE NOT
                                            // BIG ENOGH LIKE , AS BIG AS displayHeight(context)/2.5,


                                            //Text('AnimatedSwitcher('),
                                            child: AnimatedSwitcher(
                                              duration: Duration(
                                                  milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                                              child: oneOrder
                                                  .orderTypeIndex ==
                                                  0
                                                  ?
                                              _buildShoppingCartInputFieldsUNObscuredTakeAway(
                                                  oneOrder)
                                                  : oneOrder
                                                  .orderTypeIndex == 1
                                                  ?
                                              _buildShoppingCartInputFieldsUNObscured(oneOrder)
                                                  : oneOrder
                                                  .orderTypeIndex == 2
                                                  ?
                                              _buildShoppingCartInputFieldsUNObscuredPhone(oneOrder)
                                                  :
                                              //OBSCURED NOT REQUIRED SINCE FOR DINNING ROOM OPTION WE WILL HAVE
                                              // WHEN DO YOU WANT THE FOOD ON YOUR TABLE.
//                                        _buildShoppingCartInputFieldsUNObscuredTakeAway(oneOrder)
                                              _buildShoppingCartInputFieldsUNObscuredDinningRoom(
                                                  oneOrder),
//                                        animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


                                            ),


                                          ),


                                          /*
                                        // workTest
                                        Container(
                                          height:68,
//                                          color:Colors.lightBlueAccent,
                                          child: showAvailableDevices(),
                                        ),


                                        */

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            );
                          }
                        }

                        else {
                          print('sanp shot.data !is Order');
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
                                          backgroundColor: Colors
                                              .lightGreenAccent,
//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)


                                        )
                                    ),
                                  ),

                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                          backgroundColor: Color(
                                              0xffFC0000),

//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          );
                        }
                    }
//                          }

//                    }
                  }
              ),
            ),


          ),
          ),
          floatingActionButton: StreamBuilder<bool>(
            stream: printerManager.isScanningStream,
            // dEFINED IN HERE: C:\src\flutter\.pub-cache\hosted\
            // pub.dartlang.org\esc_pos_bluetooth-0.2.8\lib\
            // src\printer_bluetooth_manager.dart
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data) {
                return FloatingActionButton(
                  child: Icon(Icons.stop),
//                  onPressed: _stopScanDevices,
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _stopScanDevices'),
                    _stopScanDevices(),

                    /*
                  setState(() {
                  localScanAvailableState = !localScanAvailableState;
                  })
                    */


                  },
                  backgroundColor: Colors.red,
                );
              } else {
                return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _startScanDevices'),
                    _startScanDevices(),

                    /*
                    setState(() {
                      localScanAvailableState = !localScanAvailableState;
                    })
                    */

                  },
//                  onPressed: _startScanDevices,
                );
              }
            },
          ),
        )
    );
    //return Text('${x.toString()}');

//  }
//    }
//}
//
////---
//);
////    }
  }


  double tryCast<num>(dynamic x, {num fallback }) {
//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if (status) {
      return x.toDouble();
    }

    if (x is int) {
      return x.toDouble();
    }
    else if (x is double) {
      return x.toDouble();
    }


    else
      return 0.0;
  }


  Widget test1(Order oneOrder) {
//    final Order oneOrder = snapshot.data;
//              _currentPaymentTypeIndex = oneOrder.paymentTypeIndex;


  }


  Widget animatedWidgetShowFullOrderType() {
//    print ('at animatedWidgetShowFullOrderType() ');

    return
      Container(
        height: displayHeight(context) / 20
            /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */
            + displayHeight(context) / 11 /* HEIGHT OF MULTI SELECT PORTION */,
//        from 7 to /8.5 on june 03

        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'choose order type',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForChooseOrderTypeUpdated(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                                      padding::::
//              color:Colors.green,
              color: Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 11,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildOrderTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  Widget _buildOrderTypeSingleSelectOption() {
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentOrderType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot
                .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('orderTypes: $allOrderTypesSingleSelect');
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                .firstWhere((oneOrderType) =>
            oneOrderType.isSelected == true);
            _currentOrderTypeIndex = selectedOne.index;


            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

//              reverse: true,

//              shrinkWrap: false,
                shrinkWrap: true,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: allOrderTypesSingleSelect.length,

                itemBuilder: (_, int index) {
                  return oneSingleDeliveryType(
                      allOrderTypesSingleSelect[index],
                      index);
                },
              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }


  Widget animatedWidgetShowSelectedOrderType() {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 9,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentOrderType,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                  .firstWhere((oneOrderType) =>
              oneOrderType.isSelected == true);
              _currentOrderTypeIndex = selectedOne.index;


              String orderTypeName = selectedOne.orderType;
              String orderIconName = selectedOne.orderIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                width: displayWidth(context) / 1.1,
                height: displayHeight(context) / 12,
                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    Container(
                      width: displayWidth(context) /
                          1.5,
                      height: displayHeight(
                          context) / 20,
                      color: Color(0xffffffff),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets
                                  .fromLTRB(
                                  20, 0, 10, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'choose order type',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),

                            CustomPaint(
                              size: Size(0, 19),
                              painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                  context),
                            ),

                          ]
                      ),

                    ),
                    // THE ABOVE PART DEALS WITH LINES AND TEXT,
                    // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                    Container(

                      width: displayWidth(context) / 8,
                      height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                      child:
                      InkWell(
//                        color: Color(0xff000000),

//          elevation: 2.5,
                        // RoundedRectangleBorder
//          shape: CircleBorder(

                        /*
                        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                            color:Color(0xff000000),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        */
                        child: Container(
//                        alignment: Alignment.topCenter,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .start
                            ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                            children: <Widget>[

                              new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                width: displayWidth(context) / 8.4,
                                height: displayHeight(context) / 15,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
//                    color: Colors.black,
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0,

                                  ),
                                  shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                child: Icon(
                                  getIconForName(orderTypeName),
                                  color: Colors.black,
                                  size: displayHeight(context) / 24,

                                ),
                              ),

                              Container(

                                alignment: Alignment.center,
                                child: Text(
                                  orderTypeName, style:
                                TextStyle(
                                    color: Color(0xffFC0000),

                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                          //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

                          // only one instance of this animatedWidgetShowSelectedOrderType() IS AVAILABLE AND IN below ().
                          // animatedWidgetShowSelectedOrderType()
                          setState(() {
                            showFullOrderType =
                            !showFullOrderType;

//                            showFullOrderType
                            /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                            showCustomerInformationHeader = false;
                            showUserInputOptionsLikeFirstTime = true;
                            showFullPaymentType = true; //DEFAULT.

                            // JUST LIKE THE FIRST TIME.
                            showEditingCompleteCustomerAddressInformation =
                            false;
                            showEditingCompleteCustomerHouseFlatIformation =
                            false;
                            showEditingCompleteCustomerPhoneIformation = false;
                            showEditingCompleteCustomerReachoutIformation =
                            false;
                          });
                        },
                      ),
                      // : Container for 2nd argument of ternary condition ends here.

                    )


                    //ZZZZ


                  ],
                ),
              );
            }
          }
      ),
    );
  }

/*
  Widget animatedUnObscuredTextInputContainer(Order forUnObscured){

    print('at animated Un Obscured Text Input Container');
    return
      Container(
//            height: displayWidth(context)/2,
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
////                                                      padding::::
//          color:Colors.orange,
////                                            height: 200,
//          height: displayHeight(context) /2,
//          width: displayWidth(context)
//              - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

            child: _buildShoppingCartInputFieldsUNObscured(forUnObscured)



      );


  }
  */

  Widget animatedObscuredTextInputContainer(
      CustomerInformation forObscuredCustomerInputDisplay) {
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print('at animated Obscured Text Input Container');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.4,
          child: Container(
//            Colors.white.withOpacity(0.10),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 4,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              /*
                                                    child:  AbsorbPointer(
                                                      child: _buildShoppingCartInputFields()
                                                  ),
                                                  */
              child: _buildShoppingCartInputFieldsObscured(
                  forObscuredCustomerInputDisplay)


          ),
        ),
      );
  }


  /*
  Widget _buildQuantityTimesofFood(/*Order qTimes */) {
//   height: 40,
//   width: displayWidth(context) * 0.57,

    var logger = Logger(
      printer: PrettyPrinter(),
    );

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);



    return StreamBuilder<List<SelectedFood>>(
        stream: shoppingCartbloc.getExpandedFoodsStream,
        initialData: shoppingCartbloc.getExpandedSelectedFood,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SelectedFood> expandedSelectedFoodInOrder = snapshot.data;


//            logger.e(
//                'selectedFoodListLength: ${qTimes.selectedFoodListLength}');

//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);

            if (expandedSelectedFoodInOrder == null) {
              print('Order has no data');
              print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('expandedSelectedFoodInOrder == Null'));
            }

            //    VIEW MODEL CHANGE THUS CONDITION CHANGE 1.
            /*
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    */
            else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

              List<SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;
/*
//      int tempItemCount = allOrderedFoods.fold(0, (t, e) => t + e.quantity);

//      const tempAllOptionsState =ChildrensFromData.map((oneQuestion,index) => {
//      const opt1 = Array(oneQuestion.option1.length).fill({...templateOptionsState, key: index + 'o1'})
//      for(let i=0; i<opt1.length;i++){
//        opt1[i]= {key:index+'_o1_'+i,value:false};
//
//        }

//      void forEach(void f(E element)) {
//        for (E element in this) f(element);
//      }
              List<SelectedFood> selectedFoodforDisplay = new List<
                  SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


              allOrderedFoods.forEach((oneFood) {
                print('oneFood details: ===> ===> ');
                print('oneFood: ${oneFood.foodItemName}');
                print('oneFood: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
                List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

                print('MOMENT OF TRUTH: ');
                print(':::: ::: :: $test');
                selectedFoodforDisplay.addAll(test);
              });


//      selectedFoodforDisplay.addAll(test);

              logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
              print('item count : ${selectedFoodforDisplay.length}');

              print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
//       allOrderedFoods.map((oneFood)=>
//      makeMoreFoodByQuantity(oneFood.quantity));
//      String OrderedFoodItemName = qTimes.foodItemName;
//      String OrderedFoodImageURL = qTimes.foodItemImageURL;

//      final String imageURLBig;
//      final String foodItemName;

//      final List<NewIngredient> selectedIngredients =qTimes.ingredients;
//      final double price = qTimes.unitPrice;

              */

              logger.e('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
              print('expandedSelectedFoodInOrder: $expandedSelectedFoodInOrder');

              return Container(

//                color: Colors.green,
                color: Color(0xffFFFFFF),

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  reverse: false,

                  shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
//          itemCount: quantity,
                  itemCount: allOrderedFoods.length,
                  // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                  itemBuilder: (_, int index) {
//            return Text('ss');

                    return FoodImageInShoppingCart(
                        allOrderedFoods[index].foodItemImageURL, /*OrderedFoodImageURL,*/
                        allOrderedFoods[index].foodItemName, /*OrderedFoodItemName, */
                        allOrderedFoods[index].selectedIngredients,
                        allOrderedFoods[index].unitPrice,
                        index
                    );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                  },
                ),


                // M VSM ORG VS TODO. ENDS HERE.
              );
            }
          }
          else {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
        }
    );
  }

   */


//  animatedShowUserAddressDetailsInLineTakeAway

  Widget animatedShowUserAddressDetailsInLineDinningRoom(
      CustomerInformation currentUserForInline) {
    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xFFffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'when you want to receive it',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[


                  RaisedButton(
                    color: Color(0xffFC0000),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }

  Widget animatedShowUserAddressDetailsInLineTakeAway(
      CustomerInformation currentUserForInline) {
//    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//    return StreamBuilder(
//        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
//        initialData: shoppingCartbloc.getCurrentOrderType,
//
//        builder: (context, snapshot)
//        {
//          if (!snapshot.hasData) {
//            print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//            return Container(child: Text('Null'));
//          }
//          else {
//            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;
//
////            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;
//
//            print('orderTypes: $allOrderTypesSingleSelect');
//            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
//                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
//            _currentOrderTypeIndex = selectedOne.index;
//
//
//            String orderTypeName = selectedOne.orderType;
//            String orderIconName = selectedOne.orderIconName;
//            String borderColor = selectedOne.borderColor;
//            const Color OrderTypeIconColor=Color(0xff070707);


//    currentUserForInline

    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'when you want to receive it',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[

                  /*
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.address != ''? Container(
                      color:Colors.lightBlueAccent,
                      width:displayWidth(context) /2.6,
                      height:displayHeight(
                          context) / 20,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context)/34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),



                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });




                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /4.9,
//                              width:displayWidth(context) /5.5
                    ),

                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerAddressInformation = !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.flatOrHouseNumber != ''?
                    Container(
                      color:Colors.brown,
//                       width:displayWidth(context) /2.6,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /8,
                      width:displayWidth(context) /4,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text = currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.phoneNumber != ''?
                    Container(
                      color:Colors.lightGreenAccent,
                      width:displayWidth(context) /3,

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /3,
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /5.9,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text = currentUserForInline.phoneNumber;



//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  */
                  RaisedButton(
                    color: Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }

//}

//  p-h-o-n-e

//  animatedShowUserAddressDetailsInLine

  Widget animatedShowUserInputPhoneOrderInLine(CustomerInformation currentUserForInline) {

    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child:

              Container(
                width: displayWidth(context) /
                    1.3,
                height: displayHeight(
                    context) / 21,
                color: Color(0xffffffff),

                child:

                Container(
                  margin: EdgeInsets
                      .fromLTRB(
                      10, 0, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'client\'s phone and duration in minutes:',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight
                            .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(
                            0xff000000),
                      )
                  ),
                ),


                /*
                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPhone(
                                context),
                          ),
                          */


              ),
              // THE ABOVE PART DEALS WITH LINES AND TEXT,
              // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


              //ZZZZ

            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[



                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),

                    child: currentUserForInline.phoneNumber != '' ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 3,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 3,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'phone',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),)
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text =
                            currentUserForInline.phoneNumber;


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 3.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'ETA',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                ],
              ),

            )


          ]
      ),
    );

  }


  Widget animatedShowUserAddressDetailsInLine(
      CustomerInformation currentUserForInline) {

    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Enter user address',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
//                    highlightElevation: 12,


                    child: currentUserForInline.address != '' ? Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightBlueAccent,
                      width: displayWidth(context) / 4.9,
                      height: displayHeight(
                          context) / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context) / 34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),


                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });


                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xffFFFFFF),
//                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightBlueAccent,
                      width: displayWidth(context) / 4.9,
                      height: displayHeight(
                          context) / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context) / 34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),


                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });


                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xffFFFFFF),
//                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  'address',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),),

                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerAddressInformation =
                        !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(

                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
//                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//
//
                    /*
//                  highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,

                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    */
                    child: currentUserForInline.flatOrHouseNumber != '' ?
                    Container(
//                      color:Colors.brown,
                      color: Color(0xffFFFFFF),
//                       width:displayWidth(context) /2.6,
                      width: displayWidth(context) / 5.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
//                      color:Colors.brown,
                      color: Color(0xffFFFFFF),
//                       width:displayWidth(context) /2.6,
                      width: displayWidth(context) / 5.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'flat number',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),)
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text =
                            currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
                    /*
                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    */
                    child: currentUserForInline.phoneNumber != '' ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 5.5,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 5.5,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'phone',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),)
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text =
                            currentUserForInline.phoneNumber;


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),

                    /*
                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
//                    // highlightColor: Colors.lightGreenAccent,
//                    // splashColor: Color(0xffFC0000),
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,

                    highlightElevation: 12,
                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    */

                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'ETA',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }


// YYYY

  Widget unobscureInputandRestforDinningRoom(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context) / 2.2,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
//      color: Colors.tealAccent,
      color: Colors.white,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
          /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */

          /*
          Container(
            child:

            animatedShowUserAddressDetailsInLineDinningRoom(currentUser),
          ),
          */

          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'possible dinning time ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(
                                    0xff000000),
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForDinning(
                              context),
                        ),


                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ


              ],
            ),
          ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


          // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.amber,
            color: Colors.white,

//            height: displayWidth(context)/2.6,
            height: displayWidth(context) / 2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
//            getNumberOfInputsFilledUpDinningRoom

                  bottom:
                  getNumberOfInputsFilledUpDinningRoom(
                      unObsecuredInputandPayment.orderingCustomer) > 0
                      ? 22 : -10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    // zeroORMoreInputsEmptyDinningRoom
                    child:
                    zeroORMoreInputsEmptyDinningRoom
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    // animatedObscuredPaymentSelectContainerTakeAway and Dinning Room
                    animatedObscuredPaymentSelectContainerTakeAwayDinning
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAwayDinning
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context) / 1.1) / 4,
                            15,
                            (displayWidth(context) / 1.1) / 4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
//                        color: Colors.green,
                        color: Colors.white,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                /*
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.location_on,

                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: addressController,

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter delivery location',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(() =>

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                  showFullOrderType = false,

                                                });
                                              }
                                              else {
                                                setState(() =>

                                                {
                                                  showFullOrderType = false,

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                    */


                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE


                                /*
                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.home,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },

                                                                        */

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.


                                /*
                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.phone,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),

                                            onChanged: (text) {
                                              print("33: $text");

                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setPhoneNumberForOrder(
                                                  text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                          */
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation
                                      ? Container()
                                      :
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, 0, 0, 15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Container(

//                                          height: 25,
                                          height: displayHeight(context) / 40,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.watch_later,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(

                                            controller: etaController,


                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              WhitelistingTextInputFormatter
                                                  .digitsOnly
                                            ],

                                            textInputAction: TextInputAction
                                                .done,
//
                                            onSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
//                                              hintText: 'Enter when you want your ordered foods',
                                              hintText: 'After XX minutes',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000),
                                                fontSize: 16),

                                            onChanged: (text) {
                                              print("0444: $text");


                                              print("33: $text");
                                              final shoppingCartBloc = BlocProvider
                                                  .of<
                                                  ShoppingCartBloc>(context);

                                              shoppingCartBloc.setETAForOrder(
                                                  text);
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader =
                                                true;
                                                showUserInputOptionsLikeFirstTime =
                                                false;
                                                showFullPaymentType =
                                                true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber
                                                      .trim()
                                                      .length) > 0) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {
                                              print(
                                                  'at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


/*

                                    onSubmitted: (String value) async {
                                      await showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thanks!'),
                                              content: Text ('You typed "$value".'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () { Navigator.pop(context); },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                        },
                                      );
                                    },
                                    */
                                          ),

                                        )


                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }

  Widget unobscureInputandRestforTakeAway(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context) / 2.2,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
//      color: Colors.tealAccent,
      color: Colors.white,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
          /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */

          /*
          Container(
            child:

            animatedShowUserAddressDetailsInLineTakeAway(currentUser),
          ),

          */
          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'when you will pick the Order',
//                              'when you want to receive your order'
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(
                                    0xff000000),
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForETA(
                              context),
                        ),


                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ


              ],
            ),
          ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


          // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.amber,
            color: Colors.white,
//            height: displayWidth(context)/2.6,
            height: displayWidth(context) / 2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
                  bottom:
                  getNumberOfInputsFilledUpTakeAway(
                      unObsecuredInputandPayment.orderingCustomer) > 0
                      ? 22 : -10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    child:
                    zeroORMoreInputsEmptyTakeAway
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    animatedObscuredPaymentSelectContainerTakeAwayDinning
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAwayDinning
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context) / 1.1) / 4,
                            15,
                            (displayWidth(context) / 1.1) / 4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
//                        color: Colors.green,
                        color: Colors.white,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[



                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation
                                      ? Container()
                                      :
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, 0, 0, 15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Container(

//                                          height: 25,
                                          height: displayHeight(context) / 40,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.watch_later,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(

                                            controller: etaController,


                                            keyboardType: TextInputType.number,
//                                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              WhitelistingTextInputFormatter
                                                  .digitsOnly
                                            ],
//inputFormatters: <TextInputFormatter>[
//    WhitelistingTextInputFormatter.digitsOnly
//],
                                            textInputAction: TextInputAction
                                                .done,
//
                                            onSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
//                                              hintText: 'Enter when you want your ordered foods',
                                              hintText: 'After XX minutes',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000),
                                                fontSize: 16),

                                            onChanged: (text) {
                                              print("0444: $text");


                                              print("33: $text");
                                              final shoppingCartBloc = BlocProvider
                                                  .of<
                                                  ShoppingCartBloc>(context);

                                              shoppingCartBloc.setETAForOrder(
                                                  text);
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader =
                                                true;
                                                showUserInputOptionsLikeFirstTime =
                                                false;
                                                showFullPaymentType =
                                                true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber
                                                      .trim()
                                                      .length) > 0) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {
                                              print(
                                                  'at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


                                          ),

                                        )


                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }
// p-h-o-n-e



  Widget unobscureInputandOthersPhone(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment.orderingCustomer;


    return Container(

      height: displayHeight(context) / 2.2,

      width: displayWidth(context) / 1.1,


      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher
          Container(

            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false) ?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserInputPhoneOrderInLine(currentUser)
//              animatedShowUserInputPhoneOrderInLine

                  : Container(
                width: displayWidth(context) / 1.1,
                height: displayHeight(context) / 20,
//                color:Colors.blue,
//                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start
                  ,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: <Widget>[


                    Container(
                      width: displayWidth(context) /
                          1.5,
                      height: displayHeight(
                          context) / 20,
                      color: Color(0xffffffff),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets
                                  .fromLTRB(
                                  20, 0, 10, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'client\'s phone number and ETA',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),

                            CustomPaint(
                              size: Size(0, 19),
                              painter: LongPainterForChooseOrderTypeAdress(
                                  context),
                            ),


                          ]
                      ),

                    ),


                  ],
                ),
              ),

            ),
          ),



          Container(

            height: displayHeight(context) / 2.2 - displayHeight(context) / 20 - 100,

            child: Stack(
              children: <Widget>[
                Positioned(

                  bottom: getNumberOfInputsFilledUpPhoneOrder(
                      unObsecuredInputandPayment.orderingCustomer) <= 1 ?
                  -60 : -0,

                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    child:
                    zeroORMoreInputsEmptyPhone
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    animatedObscuredPaymentSelectContainer
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentUnSelectContainerPhoneOnly(unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                Container(
//                  height: displayWidth(context)/2.2
//                      -displayHeight(context) / 15,
                  child: AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    top:
                    0,


                    child:
                    Container(
//                        alignment:Alignment.topCenter,0


                      // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                        child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                          padding: EdgeInsets.fromLTRB(
                              (displayWidth(context) / 1.1) / 4,
                              10,
                              (displayWidth(context) / 1.1) / 4,
                              0

//                          horizontal: (displayWidth(context)/1.1)/4,
                          ),
//                        color: Colors.green,
                          color: Color(0xffFFFFFF),
                          child: Center(
//                    color:Colors.white.withOpacity(0.9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[



                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                  //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.

                                  Container(

                                    child: showEditingCompleteCustomerPhoneIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.phone,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(

                                              keyboardType: TextInputType.phone,
                                              inputFormatters: <TextInputFormatter>[
                                                LengthLimitingTextInputFormatter(16),
                                                WhitelistingTextInputFormatter.digitsOnly,
//                                                WhitelistingTextInputFormatter(RegExp("+[0-9]"))
//                                                WhitelistingTextInputFormatter(RegExp("[+]"))
                                              ],

                                              controller: phoneNumberController,


                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),

                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter phone / telephone number',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("33: $text");

                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);
//
                                                shoppingCartBloc
                                                    .setPhoneNumberForOrder(
                                                    text);

                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }
                                                );
                                                // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                              },

                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,

                                                });
                                              },
                                              onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                                print(
                                                    'at editing complete of Customer Phone Iformation ');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerPhoneIformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },

                                            ),

                                          )
                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                  Container(

                                    child: showEditingCompleteCustomerReachoutIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.watch_later,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(

                                              controller: etaController,


                                              keyboardType: TextInputType
                                                  .number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              textInputAction: TextInputAction
                                                  .done,
//
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter reach out time',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("0444: $text");


                                                print("33: $text");
                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);

                                                shoppingCartBloc.setETAForOrder(
                                                    text);
                                                setState(() {
                                                  // showFullOrderType = false;
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              },


                                              onTap: () {
                                                if ((currentUser.address
                                                    .trim()
                                                    .length) > 0 ||
                                                    (currentUser
                                                        .flatOrHouseNumber
                                                        .trim()
                                                        .length) > 0 ||
                                                    (currentUser.phoneNumber
                                                        .trim()
                                                        .length) > 0) {
                                                  showEditingCompleteCustomerHouseFlatIformation =
                                                  true;
                                                } else {
                                                  setState(() {
                                                    // showFullOrderType = false;
                                                    showFullOrderType
                                                    = false;
                                                    // showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.;
                                                  }
//                                                }
//                                                showFullOrderType = false


                                                  );
                                                }
                                              },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of Customer\'s address ETA Time:');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerReachoutIformation =
                                                  true
                                                }
                                                );
                                              },


/*

                                      onSubmitted: (String value) async {
                                        await showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text ('You typed "$value".'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () { Navigator.pop(context); },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                          },
                                        );
                                      },
                                      */
                                            ),

                                          )


                                        ],
                                      ),
                                    ),
                                  ),

                                  // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                                ],
                              )
                          ),
                        )

                    ),

                  ),
                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }



  Widget unobscureInputandRestDeliveryPhone(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;


    return Container(

      height: displayHeight(context) / 2.2,

      width: displayWidth(context) / 1.1,


      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher
          Container(

            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false) ?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLine(currentUser)


                  : Container(
                width: displayWidth(context) / 1.1,
                height: displayHeight(context) / 20,
//                color:Colors.blue,
//                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start
                  ,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: <Widget>[


                    Container(
                      width: displayWidth(context) /
                          1.5,
                      height: displayHeight(
                          context) / 20,
                      color: Color(0xffffffff),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets
                                  .fromLTRB(
                                  20, 0, 10, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'Enter user address',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),

                            CustomPaint(
                              size: Size(0, 19),
                              painter: LongPainterForChooseOrderTypeAdress(
                                  context),
                            ),


                          ]
                      ),

                    ),

                    // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                    /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                    // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                    ////WWWEEEQQQ


                  ],
                ),
              ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


            ),
          ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.black87,
//            color:Colors.black87,
//            height: displayWidth(context)/2.6,
            height: displayHeight(context) / 2.2 - displayHeight(context) / 20 -
                100,
//            height: displayHeight(context)/2 - displayHeight(context) / 20,
            // height: HEIGHT OF PARENT - HEIGHT OF HEADER TEXT FOR USER INPUT..,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//                  height: displayWidth(context)/2.2-displayHeight(context) / 20,
                  bottom: getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) <= 1 ?
                  -60 :
                  getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) <= 2 ?
                  -80 :
                  getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) == 3 ?

                  -80 : -0,
                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    child:
                    zeroORMoreInputsEmpty
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    animatedObscuredPaymentSelectContainer
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentUnSelectContainerDeliveryPhone
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                Container(
//                  height: displayWidth(context)/2.2
//                      -displayHeight(context) / 15,
                  child: AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    top:
                    0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                    // bottom 0 means full of green Container content shown.

                    child:
                    Container(
//                        alignment:Alignment.topCenter,0


                      // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                        child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                          padding: EdgeInsets.fromLTRB(
                              (displayWidth(context) / 1.1) / 4,
                              10,
                              (displayWidth(context) / 1.1) / 4,
                              0

//                          horizontal: (displayWidth(context)/1.1)/4,
                          ),
//                        color: Colors.green,
                          color: Color(0xffFFFFFF),
                          child: Center(
//                    color:Colors.white.withOpacity(0.9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[


                                  // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                  Container(
                                    child: showEditingCompleteCustomerAddressInformation
                                        ?
                                    Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.location_on,

                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(
                                              controller: addressController,

                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),


                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter delivery location',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                              ),


                                              onChanged: (text) {
                                                //RRRR

                                                print(
                                                    'at address of unobsecured (deliver loc)');

                                                final shoppingCartBloc = BlocProvider
                                                    .of<ShoppingCartBloc>(
                                                    context);
//
                                                shoppingCartBloc
                                                    .setAddressForOrder(text);
                                                if ((text
                                                    .trim()
                                                    .length) > 0) {
                                                  print(
                                                      'at (text.trim().length) >0)');
                                                  setState(() {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                    showFullOrderType = false;
//                                                showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                  });
                                                }
                                                else {
                                                  setState(() {
                                                    showFullOrderType = false;
                                                    // showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                                                showCustomerInformationHeader = true,

                                                  });
                                                }


                                                /*
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                          }

                                                          );
                                                          */
                                              },

                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                });
                                              },


                                              /*
                                                        onTap: () {

                                                          print('on tap of line # 1607');

                                                          if((currentUser.phoneNumber.trim().length) >0 ||
                                                              (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                              (currentUser.etaTimeInMinutes != null)  )
                                                          {
                                                            showEditingCompleteCustomerAddressInformation = true;
                                                          } else {
                                                            setState(() =>
                                                            {
                                                              showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                            });
                                                          }
                                                        },
                                                        */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                              //);
//                                            },
//                                          },


                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerAddressInformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },



                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),
                                            ),

                                          )

//                                  Spacer(),

//                                  Spacer(),

                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                  // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                  //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE

                                  Container(

                                    child: showEditingCompleteCustomerHouseFlatIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.home,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(
                                              controller: houseFlatNumberController,


                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter House/Flat address/number',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              onChanged: (text) {
                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);
//
                                                shoppingCartBloc
                                                    .setHouseorFlatNumberForOrder(
                                                    text);

                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }
                                                );
                                                // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                              },
                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                });
                                              },


                                              /*
                                                        onTap: () {


                                                          if ((currentUser.address
                                                              .trim()
                                                              .length) > 0 ||
                                                              (currentUser.flatOrHouseNumber
                                                                  .trim()
                                                                  .length) > 0 ||
                                                              (currentUser.etaTimeInMinutes !=-1
                                                                  )) {
                                                            showEditingCompleteCustomerHouseFlatIformation =
                                                            true;
                                                          } else {
                                                            setState(() =>
                                                            showFullOrderType = false);
                                                          }
                                                        },

                                                        */


                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerHouseFlatIformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },
                                              /*



                                                                          onSubmitted: (String value) async {
                                                                            await showDialog<void>(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Thanks!'),
                                                                                  content: Text ('You typed "$value".'),
                                                                                  actions: <Widget>[
                                                                                    FlatButton(
                                                                                      onPressed: () { Navigator.pop(context); },
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },

                                                                          */

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),
                                            ),

                                          )

//                                  Spacer(),

//                                  Spacer(),

                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                  //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.

                                  Container(

                                    child: showEditingCompleteCustomerPhoneIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.phone,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(

                                              keyboardType: TextInputType.phone,
                                              inputFormatters: <TextInputFormatter>[
                                                LengthLimitingTextInputFormatter(16),
                                                WhitelistingTextInputFormatter.digitsOnly,
//                                                WhitelistingTextInputFormatter(RegExp("+[0-9]"))
//                                                WhitelistingTextInputFormatter(RegExp("[+]"))
                                              ],

                                              controller: phoneNumberController,


                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),

                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter phone / telephone number',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("33: $text");

                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);
//
                                                shoppingCartBloc
                                                    .setPhoneNumberForOrder(
                                                    text);

                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }
                                                );
                                                // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                              },

                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,

                                                });
                                              },
                                              onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                                print(
                                                    'at editing complete of Customer Phone Iformation ');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerPhoneIformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },

                                            ),

                                          )
                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                  Container(

                                    child: showEditingCompleteCustomerReachoutIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.watch_later,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(

                                              controller: etaController,


                                              keyboardType: TextInputType
                                                  .number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              textInputAction: TextInputAction
                                                  .done,
//
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter reach out time',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("0444: $text");


                                                print("33: $text");
                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);

                                                shoppingCartBloc.setETAForOrder(
                                                    text);
                                                setState(() {
                                                  // showFullOrderType = false;
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              },


                                              onTap: () {
                                                if ((currentUser.address
                                                    .trim()
                                                    .length) > 0 ||
                                                    (currentUser
                                                        .flatOrHouseNumber
                                                        .trim()
                                                        .length) > 0 ||
                                                    (currentUser.phoneNumber
                                                        .trim()
                                                        .length) > 0) {
                                                  showEditingCompleteCustomerHouseFlatIformation =
                                                  true;
                                                } else {
                                                  setState(() {
                                                    // showFullOrderType = false;
                                                    showFullOrderType
                                                    = false;
                                                    // showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.;
                                                  }
//                                                }
//                                                showFullOrderType = false


                                                  );
                                                }
                                              },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of Customer\'s address ETA Time:');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerReachoutIformation =
                                                  true
                                                }
                                                );
                                              },


/*

                                      onSubmitted: (String value) async {
                                        await showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text ('You typed "$value".'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () { Navigator.pop(context); },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                          },
                                        );
                                      },
                                      */
                                            ),

                                          )


                                        ],
                                      ),
                                    ),
                                  ),

                                  // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                                ],
                              )
                          ),
                        )

                    ),

                  ),
                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }


  Widget _buildShoppingCartInputFieldsUNObscuredDinningRoom(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

//    return unobscureInputandRestforTakeAway(unObsecuredInputandPayment);
    return unobscureInputandRestforDinningRoom(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }

  Widget _buildShoppingCartInputFieldsUNObscuredTakeAway(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

    return
      unobscureInputandRestforTakeAway(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }


  Widget _buildShoppingCartInputFieldsUNObscuredPhone(Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address:--should be null or empty..... ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: --should be null or empty..... ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');


    return unobscureInputandOthersPhone(unObsecuredInputandPayment);

//    unobscureInputandOthersPhone

  }


// work 3
  Widget _buildShoppingCartInputFieldsUNObscured(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    return unobscureInputandRestDeliveryPhone(unObsecuredInputandPayment);

  }


  Widget _buildShoppingCartInputFieldsObscured(
      CustomerInformation obscuredDisplay) {
    //    CustomerInformation
//  final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//  return StreamBuilder(
//      stream: shoppingCartBloc.getCurrentCustomerInformationStream,
//      initialData: shoppingCartBloc.getCurrentCustomerInfo,
//
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//          return Container(child: Text('Null'));
//        }
//        else {

    CustomerInformation currentUser = obscuredDisplay;
    // THIS INFORMATION ABOVE IS NOT USED NOW.

    return Center(

        child: Container(
//                  color: Colors.green,
//                    color:Colors.white.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Container(
                    alignment: Alignment.center,

                    child: Text('Enter user address',
                      style: TextStyle(
                        color:
                        Color(0xffFC0000),
                        fontSize: 30,
                      ),)
                ),


                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
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
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.location_on,

                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          controller: addressController,

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                            focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter delivery location',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                          ),

                          onChanged: (text) {
                            //RRRR

                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setAddressForOrder(text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
//                            showFullOrderType = false;
                            );
                          },

                          onTap: () {
                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }

                            );
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                          */


                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),

                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.
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
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.home,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter House/Flat address/number',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          onChanged: (text) {
                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc
                                .setHouseorFlatNumberForOrder(
                                text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;

                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.


//                              showFullOrderType = false;
                            });
                          },


                          onTap: () {
                            setState(() {
//                              showFullOrderType = false;

                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                              showFullOrderType = false;
                            });
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },

                                                            */

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),


                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.
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
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.phone,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(16),
                            WhitelistingTextInputFormatter.digitsOnly,
//                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
//                            WhitelistingTextInputFormatter(RegExp("[+]"))
                          ],

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter phone / telephone number',

                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),

                          onChanged: (text) {
                            print("33: $text");

                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setPhoneNumberForOrder(
                                text);

                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }


                            );
                          },


                          onTap: () {
                            setState(() {
                              showFullOrderType = false;

//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
                          },

                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),


                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

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
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.watch_later,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),

                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter reach out time',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),

                          onChanged: (text) {
                            print("0444: $text");


                            print("33: $text");
                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);

                            shoppingCartBloc.setETAForOrder(text);
                            setState(() {
                              showFullOrderType = false;

//                            showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                              showUserInputOptionsLikeFirstTime = false;
                            });
                          },

                          onTap: () {
                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showUserInputOptionsLikeFirstTime = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
                          },

                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


              ],
            )
        )

    );
  }


  Widget animatedUnObscuredPaymentTypeUnSelectedContainerTakeAwayDinning(
      Order orderObjectTakeAway) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//              color:Colors.lightBlueAccent,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentTypeTakeAway
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway
                child: showFullPaymentType == false ?

                animatedWidgetShowSelectedPaymentTypeTakeAway(
                    orderObjectTakeAway) :
                _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(
                    orderObjectTakeAway),
              ),
              )
            //HHHH


          ),

          Container(
            height: displayHeight(context) / 20,
//          color:Colors.blue,
            width: displayWidth(context)
                - displayWidth(context) / 5,


//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),
            */
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
//
              // animatedUnObscuredCancelPayButtonTakeAway
              // animatedObscuredCancelPayButtonTakeAway
              // animatedUnObscuredCancelPayButton
              // animatedObscuredCancelPayButton
              child: showFullPaymentType == false ?
              animatedUnObscuredCancelPayButtonTakeAwayDinning(orderObjectTakeAway) :
              animatedObscuredCancelPayButtonTakeAwayDinning(orderObjectTakeAway)

              ,

            ),
          ),


//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),

          /*
          Container(
            height:20,
//                                                          color:Colors.lightBlueAccent,
            child: StreamBuilder<List<String>>(

              stream: shoppingCartBloc.getDevicesStream,
              initialData: shoppingCartBloc.getDevices,
              builder: (context, snapshot) {
                if ((snapshot.hasError) || (!snapshot.hasData)) {
                  return Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(''),
                    ),
                  );
                }
                else {

//                    SelectedFood incrementCurrentFoodProcessing = snapshot.data;
                  List<String> devicesFromStream = snapshot.data;

                  return ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: devicesFromStream.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OutlineButton(
                        onPressed: () => testPrint(devicesFromStream[index], context),
                        child:
                                        Text(
                                          '${devicesFromStream[index]}:${portController.text}',
                                          style: TextStyle(fontSize: 16),
                                        ),

                      );
                    },
                  );


                }
                },
                )
          ),

          */


        ],
      );
  }


  Widget animatedUnObscuredPaymentUnSelectContainerPhoneOnly(Order unObsecuredInputandPayment) {
    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[

          Container(
              color: Colors.white,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,


              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                child: showFullPaymentType == false
                    ? animatedWidgetShowSelectedPaymentTypeDeliveryPhone(unObsecuredInputandPayment) :
                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(unObsecuredInputandPayment)
                ,

              ),


              )
            //HHHH


          ),

          Container(

//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),


            */

            width: displayWidth(context)
                - displayWidth(context) / 5,
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
//
              child: showFullPaymentType == false ?
              animatedUnObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment) :
              animatedObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment)

              ,

            ),
          ),


        ],
      );
  }

  Widget animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
      Order unObsecuredInputandPayment) {
    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,


              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                child: showFullPaymentType == false
                    ? animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
                    unObsecuredInputandPayment)
                    :
                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    unObsecuredInputandPayment)
                ,

              ),


              )
            //HHHH


          ),

          Container(

//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),


            */

            width: displayWidth(context)
                - displayWidth(context) / 5,
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
//
              child: showFullPaymentType == false ?
              animatedUnObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment) :
              animatedObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment)

              ,

            ),
          ),


        ],
      );
  }


  Widget animatedObscuredCancelPayButtonTakeAwayDinning(Order cancelPaySelect) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child: Container(

            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () {
                      print('Cancel Pressed obscured animatedObscuredCancelPayButtonTakeAwayDinning');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                    },
                    color: Color(0xffFC0000),
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Color(0xffFC0000), // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,
                      child: Text('Cancel',
                        style: TextStyle(color: Color(0xffFC0000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),),

                    ),
                  ),

                ),


                SizedBox(width: displayWidth(context) / 12,),
                Container(
                  width: displayWidth(context) / 4,
//                  width:displayWidth(context)/3.1,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () async {
                      print('obscure pay');
                    },
                    color: Colors.green,
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Colors.green, // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,

                      //OBSCURE PAY

                      child: Text('Pay', style: TextStyle(color: Colors.green,
                        fontSize: 30, fontWeight: FontWeight.bold,),
                      ),),
                  ),


                ),


              ],
            ),
          ),


        ),
      );
  }

  Widget animatedObscuredCancelPayButtonDeliveryPhone(Order cancelPaySelect) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child:
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () {
                      print('Cancel Pressed obscured delivery phone obscured');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                    },
                    color: Color(0xffFC0000),
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Color(0xffFC0000), // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,
                      child: Text('Cancel',
                        style: TextStyle(color: Color(0xffFC0000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),),

                    ),
                  ),

                ),


                SizedBox(width: displayWidth(context) / 12,),
                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () async {
                      print(
                          'pay button Pressed obscured delivery phone obscured');
                    },
                    color: Colors.green,
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Colors.green, // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,

                      // PAY OBSCURED DELIVERY PHONE...
                      child: Text('Pay', style: TextStyle(color: Colors.green,
                        fontSize: 30, fontWeight: FontWeight.bold,),
                      ),),
                  ),


                ),


              ],
            ),
          ),


        ),
      );
  }


  // work 01_9thJuly.
  Widget animatedUnObscuredCancelPayButtonTakeAwayDinning(
      Order cancelPaySelectUNObscuredTakeAwayDinning) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animatedUnObscuredCancelPayButtonTakeAwayDinning()');
    return
      Container(
        margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Color(0xffFC0000),
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Color(0xffFC0000), // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,
                  child: Text('Cancel',
                    style: TextStyle(color: Color(0xffFC0000),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,),),

                ),
                onPressed: () {
                  print(
                      'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                  /*
                        cancelPaySelect.page=1;
                        return Navigator.of(context).pop(
                            BlocProvider<ShoppingCartBloc>(
                                bloc: ShoppingCartBloc(cancelPaySelect),
                            child:
                            BlocProvider<FoodGalleryBloc>(
                                bloc: FoodGalleryBloc(),
                                child: FoodGallery2()
                            )
                        ),);
                        */

                  print(
                      'debug print before invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button ');
                  _stopScanDevices();
                  print(
                      'debug print after invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button');


                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  shoppingCartBloc.clearSubscription();

                  cancelPaySelectUNObscuredTakeAwayDinning.isCanceled = true;


                  return Navigator.pop(
                      context, cancelPaySelectUNObscuredTakeAwayDinning);


//                  return Navigator.pop(context,expandedFoodReturnTemp);
                },
              ),
            ),

            SizedBox(width: displayWidth(context) / 12,),

            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Colors.green,
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Colors.green, // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(


                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,

                  // PAY UNOBSCURED DINNING TAKEAWAY.
                  child: Text('Pay', style: TextStyle(color: Colors.green,
                    fontSize: 30, fontWeight: FontWeight.bold,),
                  ),),



                onPressed: () async {

                  // TAkEAWAY AND DINNING  Recite Print. ....
                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  print(
                      'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUNObscuredTakeAwayDinning
                          .paymentTypeIndex}');
                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(cancelPaySelectUNObscuredTakeAwayDinning);





                  if ((cancelPaySelectUNObscuredTakeAwayDinning.paymentButtonPressed == true) &&
                      (cancelPaySelectUNObscuredTakeAwayDinning.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    logger.i('tempOrderWithdocId.orderdocId: ${cancelPaySelectUNObscuredTakeAwayDinning
                        .orderdocId}');

                    List<
                        PrinterBluetooth> blueToothDevicesState = shoppingCartBloc
                        .getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

                      await _showMyDialog2(
                          '___________ blueTooth device not found _____ TakeAway || Dinning pay button');

                      print(
                          'at here... __________ blueTooth device not found _____ TakeAway || Dinning pay button');

                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(
                          context, cancelPaySelectUNObscuredTakeAwayDinning);

                    }

                    else {
                      bool found = false;
                      int index = -1;
                      for (int i = 0; i < blueToothDevicesState.length; i++) {
                        ++index;

                        print(
                            'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                                .name}');
                        print(
                            'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                                .address}');

                        if ((blueToothDevicesState[i].name ==
                            'Restaurant Printer') ||
                            (blueToothDevicesState[i].address ==
                                '0F:02:18:51:23:46')) {
                          found = true;
                          break;

                          // _testPrint(oneBlueToothDevice);

                        }
                      };

                      logger.w('check device listed or not');
                      print('index: $index');
                      print('found == true ${found == true}');

                      if (found == true) {
                        print('found == true');
                        bool printResult = await _testPrint(
                            blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                        if (printResult == true) {
                          logger.i('printResult==true i.e. print successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUNObscuredTakeAwayDinning);
                        }
                        else {
                          logger.i('printResult!=true i.e. print UN successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUNObscuredTakeAwayDinning);
                        }
                      }
                      else {
                        logger.i(
                            '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');
                        await _showMyDialog2(
                            '___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');


                        shoppingCartBloc.clearSubscription();
                        print('going to food \" cancelPaySelectUNObscuredTakeAwayDinning \" Gallery page   Restaurant Printer not found');
                        return Navigator.pop(
                            context, cancelPaySelectUNObscuredTakeAwayDinning);
                      }
                    }
                  }

                },


              ),
            ),


          ],
        ),


      );
  }


  Future<void> _showMyDialog2(String message) async {

    logger.e('in showMyDialog2');
    print(' at the beginning of  _showMyDialog2 ....');


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$message'),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return Home page.'),
              onPressed: () {


                Navigator.of(context).pop();


              },
            ),
          ],
        );
      },
    );
  }


// animatedUnObscuredCancelPayButton
// animatedUnObscuredCancelPayButtonDeliveryPhone
  Widget animatedUnObscuredCancelPayButtonDeliveryPhone(
      Order cancelPaySelectUnobscuredDeliveryPhone) {


    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      Container(
        margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Color(0xffFC0000),
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Color(0xffFC0000), // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,
                  child: Text('Cancel',
                    style: TextStyle(color: Color(0xffFC0000),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,),),

                ),
                onPressed: () {
                  print(
                      'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                  /*
                  cancelPaySelect.page=1;
                  return Navigator.of(context).pop(
                      BlocProvider<ShoppingCartBloc>(
                          bloc: ShoppingCartBloc(cancelPaySelect),
                      child:
                      BlocProvider<FoodGalleryBloc>(
                          bloc: FoodGalleryBloc(),
                          child: FoodGallery2()
                      )
                  ),);
                  */


                  print(
                      'debug print before invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button ');
                  _stopScanDevices();
                  print(
                      'debug print after invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button');


                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  shoppingCartBloc.clearSubscription();

//                  List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);
//                  shoppingCartBloc.getExpandedSelectedFood;
                  cancelPaySelectUnobscuredDeliveryPhone.isCanceled = true;


                  /*
                  //MIGHT NOT BE NECESSARY.
                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  return Navigator.pop(
                      context, cancelPaySelectUnobscuredDeliveryPhone);
//                  return Navigator.pop(context,cancelPaySelect);

//                  return Navigator.pop(context,expandedFoodReturnTemp);
                },
              ),
            ),

            SizedBox(width: displayWidth(context) / 12,),

            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Colors.green,
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Colors.green, // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(


                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,

                  //    cancel Pay Select Unobscured Delivery Phone
                  child: Text('Pay', style: TextStyle(color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,),
                  ),),





                onPressed: () async {

                  // Delivery Phone Recite Print.

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);


                  print(
                      'cancelPaySelect.paymentTypeIndex Delivery Phone Recite Print..: '
                          '${cancelPaySelectUnobscuredDeliveryPhone
                          .paymentTypeIndex}');

                  // let's not use this order returned use the one from the bloc:
                  // Order tempOrderWithdocId
                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(
                      cancelPaySelectUnobscuredDeliveryPhone);


                  if ((cancelPaySelectUnobscuredDeliveryPhone.paymentButtonPressed == true) &&
                      (cancelPaySelectUnobscuredDeliveryPhone.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    logger.i(
                        'tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone
                            .orderdocId}');

                    List<PrinterBluetooth> blueToothDevicesState
                    = shoppingCartBloc.getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

                      await _showMyDialog2(
                          '___________ blueTooth device not found _____ delivery phone pay button');

                      print(
                          'at here... __________ blueTooth device not found _____ delivery phone pay button');

                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(
                          context, cancelPaySelectUnobscuredDeliveryPhone);

                    }

                    else {
                      bool found = false;
                      int index = -1;
                      for (int i = 0; i < blueToothDevicesState.length; i++) {
                        ++index;

                        print(
                            'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                                .name}');
                        print(
                            'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                                .address}');

                        if ((blueToothDevicesState[i].name ==
                            'Restaurant Printer') ||
                            (blueToothDevicesState[i].address ==
                                '0F:02:18:51:23:46')) {
                          found = true;
                          break;

                          // _testPrint(oneBlueToothDevice);

                        }
                      };



                      logger.w('check device listed or not');
                      print('index: $index');
                      print('found == true ${found == true}');

                      if (found == true) {
                        print('found == true');
                        bool printResult = await _testPrint(
                            blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                        if (printResult == true) {
                          logger.i('printResult==true i.e. print successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                        else {
                          logger.i('printResult!=true i.e. print UN successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                      }
                      else {


                        logger.i(
                            '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');

                        await
                        _showMyDialog2('___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');


                        shoppingCartBloc.clearSubscription();
                        print('going to food Gallery page  Restaurant Printer not found');
                        return Navigator.pop(
                            context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                    }
                  }

                },


                // ---
              ),
            ),

          ],
        ),
      );
  }


  Widget animatedWidgetShowSelectedPaymentTypeTakeAway(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 8.2,
//      height: displayHeight(context) / 10,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<
                  PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) =>
              onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;

              /*
              logger.e('selectedOne.index',selectedOne.index);
              logger.e('selectedOne.isSelected',selectedOne.isSelected);
              */


              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: displayWidth(context) / 1.1,
                      height: displayHeight(context) / 11,
                      color: Color(0xFFffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[


                          Container(
                            width: displayWidth(context) /
                                1.5,
                            height: displayHeight(
                                context) / 20,
                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start
                                ,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: <Widget>[

                                  Container(
                                    margin: EdgeInsets
                                        .fromLTRB(
                                        20, 0, 10, 0),
                                    alignment: Alignment
                                        .center,
                                    child: Text(
                                        'Payment Method',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight
                                              .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                          color: Color(
                                              0xff000000),
                                        )
                                    ),
                                  ),

                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                        context),
                                  ),

                                ]
                            ),

                          ),
                          // THE ABOVE PART DEALS WITH LINES AND TEXT,
                          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                          Container(

//                            width: 100,
                            width: displayWidth(context) / 8,
                            height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            OutlineButton(
                              color: Color(0xff000000),

//          elevation: 2.5,
                              // RoundedRectangleBorder
//          shape: CircleBorder(
                              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color(0xff000000),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Container(
//                        alignment: Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start
                                  ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                                  children: <Widget>[

                                    new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                      width: 90,
                                      height: displayHeight(context) / 14,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
//                    color: Colors.black,
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0,

                                        ),
                                        shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                      child: Icon(
                                        getIconForName(orderTypeName),
                                        color: Colors.black,
                                        size: displayHeight(context) / 34,

                                      ),
                                    ),

                                    Container(

                                      alignment: Alignment.center,
                                      child: Text(
                                        orderTypeName, style:
                                      TextStyle(
                                          color: Color(0xffFC0000),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                                setState(() {
                                  showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
                                });
                              },
                            ),
                            // : Container for 2nd argument of ternary condition ends here.

                          )


                          //ZZZZ


                        ],
                      ),
                    ),
                    Container(

                      padding: EdgeInsets
                          .fromLTRB(
                          300, 0, 10, 0),
                      alignment: Alignment
                          .center,
                      child: Row(
                        children: <Widget>[
                          Text(
                              'TOTAL : ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          ),

                          Text(
                              '${
                                  (unObsecuredInputandPayment.totalPrice
                                      /* * unObsecuredInputandPayment.totalPrice */)
                                      .toStringAsFixed(2)} '
                                  '\u20AC',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

//  Widget animatedWidgetShowSelectedPaymentTypeTakeAway(Order unObsecuredInputandPayment){
//animatedWidgetShowSelectedPaymentType
//animatedWidgetShowSelectedPaymentTypeDeliveryPhone

  // work 4
  Widget animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    // work -3
    return Container(
//      height: displayHeight(context) / 9,
      height: displayHeight(context) / 8.2,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<
                  PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) =>
              onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;
//              logger.e('selectedOne.index',selectedOne.index);
//              logger.e('selectedOne.isSelected',selectedOne.isSelected);


              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: displayWidth(context) / 1.1,
                      height: displayHeight(context) / 11,
//                height: displayHeight(context) / 12,

                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[


                          Container(
                            width: displayWidth(context) /
                                1.5,
                            height: displayHeight(
                                context) / 20,
                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start
                                ,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: <Widget>[

                                  Container(
                                    margin: EdgeInsets
                                        .fromLTRB(
                                        20, 0, 10, 0),
                                    alignment: Alignment
                                        .center,
                                    child: Text(
                                        'Payment Method',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight
                                              .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                          color: Color(
                                              0xff000000),
                                        )
                                    ),
                                  ),

                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                        context),
                                  ),

                                ]
                            ),

                          ),
                          // THE ABOVE PART DEALS WITH LINES AND TEXT,
                          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                          Container(

//                            width: 100,
                            width: displayWidth(context) / 8,
                            height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            OutlineButton(
                              color: Color(0xff000000),

//          elevation: 2.5,
                              // RoundedRectangleBorder
//          shape: CircleBorder(
                              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color(0xff000000),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Container(
//                        alignment: Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start
                                  ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                                  children: <Widget>[

                                    new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                      width: 90,
                                      height: displayHeight(context) / 14,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
//                    color: Colors.black,
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0,

                                        ),
                                        shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                      child: Icon(
                                        getIconForName(orderTypeName),
                                        color: Colors.black,
                                        size: displayHeight(context) / 30,

                                      ),
                                    ),

                                    Container(

                                      alignment: Alignment.center,
                                      child: Text(
                                        orderTypeName, style:
                                      TextStyle(
                                          color: Color(0xffFC0000),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                                setState(() {
                                  showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
                                });
                              },
                            ),
                            // : Container for 2nd argument of ternary condition ends here.

                          )


                          //ZZZZ


                        ],
                      ),
                    ),

                    Container(

                      padding: EdgeInsets
                          .fromLTRB(
                          300, 0, 10, 0),
                      alignment: Alignment
                          .center,
                      child: Row(
                        children: <Widget>[
                          Text(
                              'TOTAL : ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          ),

                          Text(
                              '${
                                  (unObsecuredInputandPayment.totalPrice
                                      /* * unObsecuredInputandPayment.totalPrice */)
                                      .toStringAsFixed(2)} '
                                  '\u20AC',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(
      Order unObsecuredInputandPayment) {
    //XYZ
    return
      Container(
//        color: Colors.blueGrey,
        color: Colors.white,
        height: displayHeight(context) /
            20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
            displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
//              color: Colors.blueGrey,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
              alignment: Alignment
                  .center,
              child: Row(
                children: <Widget>[
                  Text(
                      'TOTAL : ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  ),

                  Text(
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */)
                              .toStringAsFixed(2)} '
                          '\u20AC',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  )
                ],
              ),
            ),

            Container(
//              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
//              color: Colors.blueGrey,
              color: Colors.white,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 9,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
      Order unObsecuredInputandPayment) {
//    XYZ
    return
      Container(
//        color: Colors.blueGrey,
        color: Colors.white,
        height: displayHeight(context) /
            20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
            displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
//              color: Colors.blueGrey,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
              alignment: Alignment
                  .center,
              child: Row(
                children: <Widget>[
                  Text(
                      'TOTAL : ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  ),

                  Text(
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */)
                              .toStringAsFixed(2)} '
                          '\u20AC',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  )
                ],
              ),
            ),

            Container(
//              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
//              color: Colors.blueGrey,
              color: Colors.white,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 9,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  int getNumberOfInputsFilledUpDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  int getNumberOfInputsFilledUpTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }



  int getNumberOfInputsFilledUpPhoneOrder(CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    /*
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    */
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }



  int getNumberOfInputsFilledUp(CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  IconData getIconForName(String iconName) {
    print('iconName at getIconForName: $iconName');
    switch (iconName) {
      case 'facebook':
        {
//        return FontAwesomeIcons.facebook;
          return FontAwesomeIcons.facebook;
        }
        break;

      case 'twitter':
        {
          return FontAwesomeIcons.twitter;
        }
        break;
      case 'TakeAway':
        {
          return Icons.work;
        }
        break;
      case 'Delivery':
        {
          return Icons.local_shipping;
        }
        break;
      case 'Phone':
        {
          return Icons.phone_in_talk;
        }
        break;
      case 'DinningRoom':
        {
          return Icons.fastfood;
        }

      case 'Card':
        {
          return FontAwesomeIcons.solidCreditCard;
        }
        break;
      case 'Cash':
        {
          return FontAwesomeIcons.moneyBill;
        }
        break;
      case 'Later':
        {
          return FontAwesomeIcons.bookmark;
        }
        break;


      default:
        {
          return FontAwesomeIcons.home;
        }
    }
  }

//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSingleDeliveryType(OrderTypeSingleSelect x, int index) {
    String orderTypeName = x.orderType;
    String orderIconName = x.orderIconName;
    String borderColor = x.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(
      child: index == _currentOrderTypeIndex ?

      Container(

        width: displayWidth(context) / 6,
        height: displayHeight(context) / 11,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child:
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

                  width: displayWidth(context) / 10.8,
                  height: displayWidth(context) / 10.8,

                  decoration: BoxDecoration(
                    border: Border.all(

                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,

                  ),

                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Color(0xffFC0000),
                    size: displayWidth(context) / 16,

                  ),

                ),
                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
                x, index, _currentOrderTypeIndex);
            showEditingCompleteCustomerAddressInformation = false;
            showEditingCompleteCustomerHouseFlatIformation = false;
            showEditingCompleteCustomerPhoneIformation = false;
            showEditingCompleteCustomerReachoutIformation = false;

            // WORK -2


          },
        ),
        // : Container for 2nd argument of ternary condition ends here.


        // : Container for 2nd argument of ternary condition ends here.

      ) :
      Container(
        width: displayWidth(context) / 6,
        height: displayHeight(context) / 11,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child:
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                new Container(
                  width: displayWidth(context) / 10.8,
                  height: displayWidth(context) / 10.8,
                  decoration: BoxDecoration(
                    border: Border.all(

                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,

                  ),

                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Colors.black,
                    size: displayWidth(context) / 16,
                  ),
                ),
                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
                x, index, _currentOrderTypeIndex);

            setState(() {
              showCustomerInformationHeader = true;
              showUserInputOptionsLikeFirstTime = true;
              // MAKEING THEM AS THEY ARE IN THE FIRST TIME:

              showEditingCompleteCustomerAddressInformation = false;
              showEditingCompleteCustomerHouseFlatIformation = false;
              showEditingCompleteCustomerPhoneIformation = false;
              showEditingCompleteCustomerReachoutIformation = false;


              // WE ARE oneSingleDeliveryType;
//            showFullPaymentType = false;  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
            }
            );
          },
        ),
      ),

    );
  }

// PAYMENT RELATED WIDGETS ARE HERE  --- below:


  Widget animatedObscuredPaymentSelectContainerTakeAwayDinning(
      Order priceandselectedCardFunctionality) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context) / 2.5,
        child: AbsorbPointer(
          child: Opacity(
            opacity: 0.2,
            child: Container(
                color: Colors.greenAccent,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: displayWidth(context)
                    - displayWidth(context) / 5,
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    priceandselectedCardFunctionality)

            ),
          ),
        ),
      );
  }


  Widget animatedObscuredPaymentSelectContainer(
      Order priceandselectedCardFunctionality) {
    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context) / 2.5,
        child: AbsorbPointer(
          child: Opacity(
            opacity: 0.2,
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: displayWidth(context)
                    - displayWidth(context) / 5,
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    priceandselectedCardFunctionality)
            ),
          ),
        ),
      );
  }


  bool zeroORMoreInputsEmptyDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }


  bool zeroORMoreInputsEmptyTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }



  bool zeroORMoreInputsEmptyPhone(CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if (

    (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length > 0)
        &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1)
    ) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }



  bool zeroORMoreInputsEmpty(CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if (
    (customerInfoFieldsCheck.address
        .trim()
        .length > 0)
        &&
        (customerInfoFieldsCheck.flatOrHouseNumber
            .trim()
            .length > 0)
        &&
        (customerInfoFieldsCheck.phoneNumber
            .trim()
            .length > 0)
        &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1)
    ) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }


// 3926 IS FOR THE UNOBSCURE PART.
// 4511 is for the OBSCURED PART.
  Widget _buildPaymentTypeSingleSelectOption() {
//    logger.i('at here: _buildPaymentTypeSingleSelectOption');
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentPaymentType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('paymentTypes: $allPaymentTypesSingleSelect');

            /*
            PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect.firstWhere(
                    (onePaymentType) =>
                    onePaymentType.isSelected==true);
            _currentPaymentTypeIndex = selectedOne.index;

            print('_currentPaymentTypeIndex: at 4237 000  0000 $_currentPaymentTypeIndex');


             */


            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

//              reverse: true,

                shrinkWrap: true,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: allPaymentTypesSingleSelect.length,

                itemBuilder: (_, int index) {
                  return oneSinglePaymentType(
                      allPaymentTypesSingleSelect[index],
                      index);
                },

              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }


//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSinglePaymentType(PaymentTypeSingleSelect onePaymentType,
      int index) {
//    String color1 = x.itemTextColor.replaceAll('#', '0xff');

//    Color c1 = Color(int.parse(color1));
//    print('x: ',x.i)

//    IconData x = IconData(int.parse(x.iconDataString),fontFamily: 'MaterialIcons');

//    print('x.icondataString: ${x.iconDataString}');
//    print('x.orderType: ${x.orderType}');
//    print('isSelected check at Shopping Cart Page: ${x.isSelected}');
//    logger.i('isSelected check at Shopping Cart Page: ',x.isSelected);


//    logger.i('_currentPaymentTypeIndex: at line # 4287 $_currentPaymentTypeIndex');
    String paymentTypeName = onePaymentType.paymentTypeName;
    String paymentIconName = onePaymentType.paymentTypeName;
    String borderColor = onePaymentType.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(

//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

      child: index == _currentPaymentTypeIndex ?

      Container(

//        width: 110,
        width: displayWidth(context) / 7.8,
        height: displayHeight(context) / 11,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          // RoundedRectangleBorder
//          shape: CircleBorder(
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width: displayWidth(context) / 11.5,
                  height: displayWidth(context) / 11.5,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                  decoration: BoxDecoration(
                    border: Border.all(
//                    color: Colors.black,
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Color(0xffFC0000),
                    size: displayWidth(context) / 20,

                  ),
//
//                child: Icon(IconData(58840, fontFamily: 'MaterialIcons')),
//                Icon(
//                  IconData(x.orderIconName),
//                               color: Color(0xffFC0000),
//                  size: 36.0,
//                ),
//                child: Icon(IconData(), color: Colors.red), todo

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
//    void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);

            // oneSinglePaymentType
            setState(() {
              showFullPaymentType = false;
            });
          },
        ),
        // : Container for 2nd argument of ternary condition ends here.

      ) :

      Container(
//        width: 110,
        width: displayWidth(context) / 7.8,
//        width: displayWidth(context)/8,
        height: displayHeight(context) / 10,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width: displayWidth(context) / 11.5,
                  height: displayWidth(context) / 11.5,
                  decoration: BoxDecoration(
                    border: Border.all(
//                      color: Colors.red[500],
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Colors.grey,
                    size: displayWidth(context) / 20,
                  ),
//                child: Icon(
//                  Icons.beach_access,
//                  color: Colors.grey,
//                  size: 36.0,
//                ),

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);


            // oneSinglePaymentType
            setState(() {
              showFullPaymentType = false;
            });
          },
        ),


      ),
    );
  }

//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(List <NewIngredient> reciteIngrdients){

    print('reciteIngrdients.length: ${reciteIngrdients.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteIngrdients.length,


      itemBuilder: (_,int index) {
        return displayOneExtraIngredientInRecite(reciteIngrdients[index], index);
      },

    );

  }
  Widget showExtraCheeseItems(List<CheeseItem> reciteCheeseItems){
    print('reciteCheeseItems.length: ${reciteCheeseItems.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteCheeseItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraCheeseItemInRecite(reciteCheeseItems[index], index);
      },
    );
  }
  Widget showExtraSauces(List<SauceItem> reciteSauceItems){
    print('reciteSauceItems.length: ${reciteSauceItems.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteSauceItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraSauceItemInRecite(reciteSauceItems[index], index);
      },
    );
  }

  Widget displayOneExtraIngredientInRecite(NewIngredient oneIngredientForRecite, int index){

    print('oneIngredientForRecite.ingredientName: ${oneIngredientForRecite.ingredientName}');

    if(oneIngredientForRecite.isDefault==false) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              '+Ingre.: ',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            Text('${((oneIngredientForRecite.ingredientName == null) ||
      (oneIngredientForRecite.ingredientName.length == 0)) ?
      '----' : oneIngredientForRecite.ingredientName.length > 18 ?
      oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
      oneIngredientForRecite.ingredientName}',
            /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',),
            ),
            Text(
              '  +${oneIngredientForRecite.price.toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }

  Widget displayOneExtraSauceItemInRecite(SauceItem oneSauceItemForRecite, int index){

    print('oneSauceItemForRecite.ingredientName: ${oneSauceItemForRecite.sauceItemName}');

    if(oneSauceItemForRecite.isDefaultSelected !=true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              '+SauceItem: ',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

        Text('${((oneSauceItemForRecite.sauceItemName == null) ||
            (oneSauceItemForRecite.sauceItemName.length == 0)) ?
        '---' : oneSauceItemForRecite.sauceItemName.length > 18 ?
        oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
        oneSauceItemForRecite.sauceItemName}',
          /*
          Text(
              '${oneSauceItemForRecite.sauceItemName} ',
              */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),
            Text(
              '  +${oneSauceItemForRecite.price.toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }


  Widget displayOneExtraCheeseItemInRecite(CheeseItem oneCheeseItemForRecite, int index){

    print('oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForRecite.cheeseItemName}');
    if(oneCheeseItemForRecite.isDefaultSelected !=true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              '+cheese: ',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),
        Text('${((oneCheeseItemForRecite.cheeseItemName == null) ||
            (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
        '---' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
        oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
        oneCheeseItemForRecite.cheeseItemName}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            /*

            Text('${((oneIngredientForRecite.ingredientName == null) ||
      (oneIngredientForRecite.ingredientName.length == 0)) ?
      '----' : oneIngredientForRecite.ingredientName.length > 18 ?
      oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
      oneIngredientForRecite.ingredientName}',
            /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',),
            ),

            */
            Text(
              '  +${oneCheeseItemForRecite.price.toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }

  Widget displayOneFoodInformation(OrderedItem oneFood, int index){
    print('index: : : : $index');

    List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
    List<SauceItem>     extraSauces       = oneFood.selectedSauces;
    List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;


    print('extraIngredient: $extraIngredient');

    print('extraSauces: $extraSauces');

    print('extraCheeseItems: $extraCheeseItems');

    List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();
    List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => e.isDefaultSelected != true).toList();
    List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();


    print('onlyExtraIngredient: $onlyExtraIngredient');

    print('onlyExtraSauces: $onlyExtraSauces');

    print('onlyExtraCheeseItems: $onlyExtraCheeseItems');


    /*
    List<NewIngredient> defaultIngredientsLaterAdded
    = defaultIngredients.where((oneDefaultIngredient) =>
    oneDefaultIngredient.isDefault!=true).toList();

    */

    return Container(

      height:940,
      width: 220,

      child: Column(
        children: <Widget>[


          Container(
            height: 100,
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  '${oneFood.name.toString()}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                Text(
                  'X${oneFood.quantity}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),


          Container(
            height: 100,
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  '${oneFood.foodItemSize}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                Text(
                  '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),



          Container(
            height:700,
            color:Colors.redAccent,
            padding:const EdgeInsets.all(3),
            child:ListView(
              children: <Widget>[
                Container(
                    width: 340,
                    height:210,
                    color:Colors.blue,
                    child: showExtraIngredients(onlyExtraIngredient)),



                Divider(
                  height:10,
//            width: 220,
                  thickness:5,
                  color:Colors.black,
                ),
                Container(
                    width: 340,
                    height:210,
                    color:Colors.orange,
                    child: showExtraCheeseItems(onlyExtraCheeseItems)
                ),

                Divider(
                  height:10,
//            width: 220,
                  thickness:5,
                  color:Colors.black,
                ),
                Container(
                    width: 320,

                    height:210,
                    color:Colors.deepPurpleAccent,
                    child: showExtraSauces(onlyExtraSauces)
                ),


              ],
            )
          ),


          Divider(
            height:20,
//            width: 220,
            thickness:5,
            color:Colors.black,
          ),


        ],
      ),
    );
  }



  Widget processFoodForRecite(List<OrderedItem> orderedItems){

    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: orderedItems.length,

      itemBuilder: (_,int index) {
        return displayOneFoodInformation(orderedItems[index], index);
      },
    );
  }



  Future<void> dummyPrintDialog(

      OneOrderFirebase oneOrderForReceipt,
      Uint8List restaurantNameImageByte2,
      ) async {

    print('restaurantNameImageByte2: $restaurantNameImageByte2');

    CustomerInformation customerForReciteGeneration = oneOrderForReceipt
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderForReceipt.orderedItems;






    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container
                  (
//                    color:Colors.green,
                    width: 200,
                    height:40,
                    child: Image.memory(restaurantNameImageByte2)
                ),

                Divider(
                  height:10,
                  thickness:5,
                  color:Colors.black,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${oneOrderForReceipt
                            .formattedOrderPlacementDatesTimeOnly}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                      // 2 ends here.
                      Text('${oneOrderForReceipt.orderProductionTime} min',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                    ],
                  ),
                ),






                // ADDRESS: BEGINS HERE.

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'address: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${((customerForReciteGeneration.address == null) ||
                            (customerForReciteGeneration.address.length == 0)) ?
                        '----' : customerForReciteGeneration.address.length > 21 ?
                        customerForReciteGeneration.address.substring(0, 18) + '_ _' :
                        customerForReciteGeneration.address}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                      // 2 ends here.
                      Text('${customerForReciteGeneration.flatOrHouseNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                    ],
                  ),
                ),

                // ADDRESS: ENDS HERE.

                // PHONE: BEGINS HERE.



                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'phone: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${customerForReciteGeneration.phoneNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),

                // PHONE: ENDS HERE.


                Divider(
                  height:30,
                  thickness:10,
                  color:Colors.black,
                ),


                //  ORDEREDITEMS BEGINS HERE..

//                orderedItems.map((e) => null)




                Container(
                    width: 220,
                    height:580,
                    child: processFoodForRecite(orderedItems)
                ),



                //  ORDEREDITEMS endS HERE..

                Divider(
                  height:30,
                  thickness:8,
                  color:Colors.black,
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'SUBTOTAL: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${oneOrderForReceipt.totalPrice.toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'DELIVERY: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${1.6.toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'TOTAL: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 30, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${(oneOrderForReceipt.totalPrice +1.6).toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),







                Container(
                  height:70,
                  width: 400,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color:Colors.red,
                        //sss
                        width: 70,
                        height:70,
                        child: Image.asset(
                          oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                          'assets/unpaid_cash_card/card.png'
                              :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                          'assets/unpaid_cash_card/cash.png':'assets/unpaid_cash_card/unpaid.png',

//                color: Colors.black,
                          width: 50,
                          height:50,

                        ),
                      ),
                      Row(
                        children: <Widget>[


                          Text(
                            oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                            'card'
                                :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                            'cash':'unpaid',

//                            oneOrderForReceipt.paidType.toLowerCase() == 'paid' ?
//                            'paid' : 'unpaid',

                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                          color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',),
                          ),

                          SizedBox(width: 50),

                          Text(
                            (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                                ? 'Delivery'
                                :
                            (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                            'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                                'takeaway') ? 'TakeAway' : 'DinningRoom',
//                    oneOrderForReceipt.orderBy
//                    'dinningRoom',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                        color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',),
                          ),



                        ],
                      ),

                      Container(
//                      color: Colors.black,
                        width: 70,
                        height:70,

                        child: (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery') ?
                        Image.asset(
                          'assets/orderBYicons/delivery.png',
                          color: Colors.black,
                          width: 50,
                          height:50,) :
                        (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                        Image.asset(
                            'assets/phone.png',
                            color: Colors.black,
                            width: 50,
                            height:50) : (oneOrderForReceipt.orderBy
                            .toLowerCase() == 'takeaway')
                            ? Image.asset(
                          'assets/orderBYicons/takeaway.png',
                          color: Colors.black,
                          width: 50,
                          height:50,
                        )
                            : Image.asset('assets/orderBYicons/diningroom.png',
                          color: Colors.black,
                          width: 50,
                          height:50,),

                      ),


                    ],
                  ),
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /* invoker -->

              printTicketDummy2(
              /*paper, */
                thisRestaurant,
                oneOrderData,
                imageRestaurant,
                restaurantNameBytesNotFuture,
                // orderInformationAndUserInformationTopInBytes,
                Uint8List orderInformationForReciteWidgetBytes2,
                Uint8List customerInformationOnlyBytes2,
                totalCostDeliveryBytes,
                paidUnpaidDeliveryTypeInBytes);
          }).catchError((onError) {

  * */
  void printTicketDummy2(/*PaperSize paper, */
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderdocument,
      ImageAliasAnotherSource.Image imageResource,
//      Uint8List orderInformationAndUserInformationTopInBytes,
      /*
      Uint8List orderInformationForReciteWidgetBytes2,
      Uint8List customerInformationOnlyBytes2, */
      Uint8List restaurantNameImageBytes,
      /* Uint8List totalCostDeliveryBytes2,*/
      /*Uint8List paidUnpaidDeliveryTypeWidgetBytes2 */
      ) async {
    print(' came here: printTicketDummy');

//    final PosPrintResult res =
//    await printerManager.printTicket(await demoReceipt(paper,currentRestaurant, oneOrderdocument));

//    showToast('res.msg  res.msg   res.msg');


    dummyPrintDialog(
      oneOrderdocument,
      restaurantNameImageBytes,
//        orderInformationAndUserInformationTopInBytes,
      /*
      orderInformationForReciteWidgetBytes2,
      customerInformationOnlyBytes2,

      totalCostDeliveryBytes2,

     */
      /*paidUnpaidDeliveryTypeWidgetBytes2 */
    );
  }


  String sanitize(String nameInput){

    return nameInput;
  }

  /*
    Future<Ticket> demoReceiptOrderTypeDelivery(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {

  */
  // # number 1: demoReceipt Order Type TakeAway begins here...


  Future<Ticket> demoReceiptOrderTypeTakeAway(
      PaperSize paper,
      Restaurant thisRestaurant3, // not required but just for printing...
      OneOrderFirebase oneOrderData3, // oneOrderData3.orderedItems --> for loop print..
      Uint8List restaurantNameBytesNotFuture3,

      ) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameBytesNotFuture3---takeAway---> : $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderData3
        .orderProductionTime}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);





    //0.... printing codes starts here..


    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:0);

    ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'           '
        +'${oneOrderData3.orderProductionTime} min',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    //    ticket.feed(2);


    // FOR TAKEAWAY NOT NECESSARY..
    /*
    // 3 ... address: .... + flat


    ticket.text('address:  ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    // 4 ... phone: phone
    ticket.text('phone:  ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));

    */


    ticket.feed(1);
    ticket.hr(ch:'.',len:null,linesAfter:1);

    // 5... processFoodForRecite


    orderedItems.forEach((oneFood) {


      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;

//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<SauceItem> onlyExtraSauces       =
      extraSauces.where((e) => e.isDefaultSelected != true).toList();
      List<CheeseItem>    onlyExtraCheeseItems  =
      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');



      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${oneFood.name.toString()}',
            width: 5, styles: PosStyles(align: PosAlign.left,
            ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
            width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // 5.2 --- extra ingredients...

      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneIngredientForRecite.ingredientName == null) ||
                (oneIngredientForRecite.ingredientName.length == 0)) ?
            '----' : oneIngredientForRecite.ingredientName.length > 18 ?
            oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
            oneIngredientForRecite.ingredientName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                (oneSauceItemForRecite.sauceItemName.length == 0)) ?
            '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
            oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
            oneSauceItemForRecite.sauceItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left) ),


          ]);
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {
          ticket.row([


            PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
            '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
            oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
            oneCheeseItemForRecite.cheeseItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);



    // for takeaway and delivery not necessary.
    /*
    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${00.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);

    */

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right)  ,
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;


    }






  // # number 2: demoReceipt Order Type Delivery begins here...

//  restaurantNameImageBytes,totalCostDeliveryBytes2
  Future<Ticket> demoReceiptOrderTypeDelivery(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {


    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameBytesNotFuture3 line # 10760: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderData3
        .orderProductionTime}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);


    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:0);

    ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'           '
        +'${oneOrderData3.orderProductionTime} min',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    //    ticket.feed(2);


    // 3 ... address: .... + flat


    ticket.text('address:  ${((customerForReciteGeneration.address == null) ||
    (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    // 4 ... phone: phone
    ticket.text('phone:  ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));


    ticket.feed(1);
    ticket.hr(ch:'.',len:null,linesAfter:1);

    // 5... processFoodForRecite


    orderedItems.forEach((oneFood) {


      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;

//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<SauceItem> onlyExtraSauces       =
      extraSauces.where((e) => e.isDefaultSelected != true).toList();
      List<CheeseItem>    onlyExtraCheeseItems  =
      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');



      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${oneFood.name.toString()}',
          width: 5, styles: PosStyles(align: PosAlign.left,
      ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
          width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
          width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',
          width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // 5.2 --- extra ingredients...

      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneIngredientForRecite.ingredientName == null) ||
          (oneIngredientForRecite.ingredientName.length == 0)) ?
          '----' : oneIngredientForRecite.ingredientName.length > 18 ?
          oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
          oneIngredientForRecite.ingredientName}',
              width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
              width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                (oneSauceItemForRecite.sauceItemName.length == 0)) ?
            '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
            oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
            oneSauceItemForRecite.sauceItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
              width: 3,styles: PosStyles(align: PosAlign.left) ),


          ]);
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {
          ticket.row([


            PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
            '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
            oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
            oneCheeseItemForRecite.cheeseItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
              width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);


    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${00.toStringAsFixed(2)}',
        width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right)  ,
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;

  }


  // demoReceipt Order Type Delivery ends here...

  // # number 3: demoReceipt Order Type phone begins here...

  // demoReceipt Order Type Phone begins here...
  Future<Ticket> demoReceiptOrderTypePhone(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {


    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameBytesNotFuture3 line# 11159: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderData3
        .orderProductionTime}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);





    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:0);

    ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'           '
        +'${oneOrderData3.orderProductionTime} min',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    //    ticket.feed(2);


    // 3 ... address: .... + flat

    // FOR PHONE ORDER NOT NECESSARY...
    /*

    ticket.text('address:  ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    */

    // 4 ... phone: phone
    ticket.text('phone:  ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));


    ticket.feed(1);
    ticket.hr(ch:'.',len:null,linesAfter:1);

    // 5... processFoodForRecite


    orderedItems.forEach((oneFood) {


      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;

//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<SauceItem> onlyExtraSauces       =
      extraSauces.where((e) => e.isDefaultSelected != true).toList();
      List<CheeseItem>    onlyExtraCheeseItems  =
      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');



      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${oneFood.name.toString()}',
            width: 5, styles: PosStyles(align: PosAlign.left,
            ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
            width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // 5.2 --- extra ingredients...

      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneIngredientForRecite.ingredientName == null) ||
                (oneIngredientForRecite.ingredientName.length == 0)) ?
            '----' : oneIngredientForRecite.ingredientName.length > 18 ?
            oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
            oneIngredientForRecite.ingredientName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                (oneSauceItemForRecite.sauceItemName.length == 0)) ?
            '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
            oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
            oneSauceItemForRecite.sauceItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left) ),


          ]);
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {
          ticket.row([


            PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
            '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
            oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
            oneCheeseItemForRecite.cheeseItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);


    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${00.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right)  ,
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;


  }

// demoReceipt Order Type Phone ends here...


// # number 4: demoReceipt Order Type Dinning begins here...

  Future<Ticket> demoReceiptOrderTypeDinning(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {

    //--4

    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2 line # 11509: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderData3
        .orderProductionTime}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);






    //0.... printing codes starts here..


    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:0);

    ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'           '
        +'${oneOrderData3.orderProductionTime} min',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    //    ticket.feed(2);


    // FOR TAKEAWAY NOT NECESSARY..
    /*
    // 3 ... address: .... + flat


    ticket.text('address:  ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    // 4 ... phone: phone
    ticket.text('phone:  ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));

    */


    ticket.feed(1);
    ticket.hr(ch:'.',len:null,linesAfter:1);

    // 5... processFoodForRecite


    orderedItems.forEach((oneFood) {


      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;

//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<SauceItem> onlyExtraSauces       =
      extraSauces.where((e) => e.isDefaultSelected != true).toList();
      List<CheeseItem>    onlyExtraCheeseItems  =
      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');



      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${oneFood.name.toString()}',
            width: 5, styles: PosStyles(align: PosAlign.left,
            ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
            width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // 5.2 --- extra ingredients...

      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneIngredientForRecite.ingredientName == null) ||
                (oneIngredientForRecite.ingredientName.length == 0)) ?
            '----' : oneIngredientForRecite.ingredientName.length > 18 ?
            oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
            oneIngredientForRecite.ingredientName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {
          ticket.row([


            PosColumn(text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                (oneSauceItemForRecite.sauceItemName.length == 0)) ?
            '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
            oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
            oneSauceItemForRecite.sauceItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left) ),


          ]);
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {
          ticket.row([


            PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
            '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
            oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
            oneCheeseItemForRecite.cheeseItemName}',
                width: 9,styles: PosStyles(

                  align: PosAlign.right,
                )),

            PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                width: 3,styles: PosStyles(align: PosAlign.left)),


          ]);
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);



    // for takeaway and delivery not necessary.
    /*
    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${00.toStringAsFixed(2)}\€',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);

    */

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '\$${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right)  ,
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;



  }

// # number 4: demoReceipt Order Type Dinning ends here...



  Future <bool> printTicket2(
      PaperSize paper,
      Restaurant thisRestaurant2,
      OneOrderFirebase oneOrderData2,
      Uint8List restaurantNameBytesNotFuture2,
      ) async {
    // pqr


    print('restaurantNameBytesNotFuture2:: $restaurantNameBytesNotFuture2');

    print('oneOrderdocument.orderBy: ${oneOrderData2.orderBy}');

    final PosPrintResult res = (oneOrderData2.orderBy.toLowerCase() ==
        'delivery') ?
    await printerManager.printTicket(
        await demoReceiptOrderTypeDelivery(
          paper,
          thisRestaurant2,
          oneOrderData2,
          restaurantNameBytesNotFuture2,
        )) :
    (oneOrderData2.orderBy.toLowerCase() == 'phone') ?
    await printerManager.printTicket(await demoReceiptOrderTypePhone(
      paper,
      thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    (oneOrderData2.orderBy.toLowerCase() == 'takeaway') ?
    await printerManager.printTicket(await demoReceiptOrderTypeTakeAway(
      paper,
      thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    await printerManager.printTicket(
        await demoReceiptOrderTypeDinning(
          paper,
          thisRestaurant2,
          oneOrderData2,
          restaurantNameBytesNotFuture2,
        ));


    logger.i('----- res : $res');
    print('res.msg: ${res.msg}');
    String response2 = res.msg;


    // showToast(res.msg);

    logger.i('this never executes .. TODO...');
    if (response2== 'Success') {
      print('at Success');
      print('-----check above condition\'s.... -----');
      return true;
    }



    else {
      print('before returning false from Future <bool> printTicket ');
      return false;
    }

//    TODO: NEED TO check the res.msg
    // true means printed.


  }


  Future<bool> _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    print(" at _testPrint");


    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');


    Future<OneOrderFirebase> testFirebaseOrderFetch =
    shoppingCartBloc.fetchOrderDataFromFirebase(
        oneOrderForReceipt.orderdocId.trim());





//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(()
    {
      print("called when future completes");
    }
    ).then((oneOrderData) {

      Widget restaurantName2 = restaurantName(thisRestaurant.name);

      final Future<Uint8List> restaurantNameBytesFuture = createImageFromWidget(restaurantName2);

      Uint8List restaurantNameBytesNotFuture;

      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


      ImageAliasAnotherSource.Image imageRestaurant;

      /* await */
      restaurantNameBytesFuture.whenComplete(() {
        print("restaurantNameBytes.whenComplete called when future completes");
      }
      ).then((oneImageInBytes) {
//      ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print('calling ticket.image(imageRestaurant); ');
        restaurantNameBytesNotFuture = oneImageInBytes;

        print('oneImageInBytes: $oneImageInBytes');
//      ticket.image(imageRestaurant);


        print('reached here: $oneOrderData');






        Future<bool> isPrint =
        printTicket2(
          paper,
          thisRestaurant,
          oneOrderData /*,imageRestaurant */,

          restaurantNameBytesNotFuture,

        );

//        Future<OneOrderFirebase> testFirebaseOrderFetch=

        isPrint.whenComplete(() {
          print("called when future completes");
//          return true;
        }
        ).then((printResult) async {
          if (printResult == true) {
            print("printResult: $printResult");
            Future<String> docID = shoppingCartBloc
                .recitePrinted(oneOrderForReceipt.orderdocId, 'Done');


//              --


            docID.whenComplete(() => print('printing completed..')).then((
                value) {
              print(
                  'docID in [Future<bool> isPrin] await shoppingCartBloc.recitePrintedt: $docID');
              return true;
            }).catchError((onError) {
              return false;
            });
//            --
            return false;
          }
          else {
            return false;
          }

        }).catchError((onError) {
          print('printing not successful: $onError');
          return false;
        });

      }).catchError((onError) {
        print(' error in getting restaurant name as image---1');
        print('false: means something wrong not printed');
        //means something wrong not printed
        return false;
      });




    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content: Container(
          child:
          new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Error: ${onError.message.substring(0, 40)}", style:
              TextStyle(/*fontSize: 10,*/ fontWeight: FontWeight.w500,
                  color: Colors.white)),
            ],
          ),
        )),);

      return false;
    });


    // final return false if true is not return from the above conditioned.
    return false;
//    });
  }

  void _testPrintDummyDevices(PrinterBluetooth printer) async {
    // NOT REQUIRED SINCE DUMMY...

    print("_testPrintDummyDevices");

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');



    TODO: // something wrong maybe here. docID needs to be processed...

    Future<String> docID = shoppingCartBloc.recitePrinted(
        oneOrderForReceipt.orderdocId, 'dummyPrint');

//                    recitePrinted

    print('docID1 in dummy Print: $docID');

    Future<OneOrderFirebase> testFirebaseOrderFetch = shoppingCartBloc
        .fetchOrderDataFromFirebase(oneOrderForReceipt.orderdocId.trim());

    Widget restaurantName2 = restaurantName(thisRestaurant.name);
    final Future<Uint8List> restaurantNameBytesFuture =
    createImageFromWidget(restaurantName2);
    Uint8List restaurantNameBytesNotFuture;

    print('restaurantNameBytes: $restaurantNameBytesNotFuture');

    ImageAliasAnotherSource.Image imageRestaurant;

    /* await */
    restaurantNameBytesFuture.whenComplete(() {
      print("restaurantNameBytes.whenComplete called when future completes");
    }).then((oneImageInBytes) {
      ImageAliasAnotherSource.Image imageRestaurant =
      ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      print('calling ticket.image(imageRestaurant); ');
      restaurantNameBytesNotFuture = oneImageInBytes;

      print('restaurantNameBytesNotFuture: $restaurantNameBytesNotFuture');
//      ticket.image(imageRestaurant);
    }).catchError((onError) {
      print(' error in getting restaurant name as image--22');
    });

//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }).then((oneOrderData) {





      printTicketDummy2(
        /*paper, */
        thisRestaurant,
        oneOrderData,
        imageRestaurant,

        restaurantNameBytesNotFuture,

      );


    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(
            duration: new Duration(seconds: 6),
            content: Container(
              child: new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("Error: $onError",
                      style: TextStyle(
                        /*fontSize: 10,*/ fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
            )),
      );
    });
  }




  Future<void> _showMyDialog3(Uint8List x) async {
    print('x: $x');
//    print('totalCostDeliveryBytes3: $totalCostDeliveryBytes3');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'please use real blueTooth devices and also change functions in '
                        'shopping cart page.'),
                Container
                  (child: Image.memory(x)
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/* PRINTING REcite related codes resides here: */


}

