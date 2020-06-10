
// bloc 's
import 'package:flutter/cupertino.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

// models
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



// external pkg's
import 'package:logger/logger.dart';



class AppBloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  FoodGalleryBloc foodGalleryBlockObject;
  FoodItemDetailsBloc foodItemDetailsBlockObject;

  FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
  List<NewIngredient> emptyIngs = [];



  /*
  Future<void> getAllIngredients(/*int pageFrom */) async {

//        final bloc = BlocProvider.of<FoodGalleryBloc>(context);


//    final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
//    await foodGalleryBlockObject.getAllIngredients(
    await foodGalleryBlockObject.getAllIngredients();
    List<NewIngredient> emptyIngs = foodGalleryBlockObject.allIngredients;
  }
  */

//  FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),

  AppBloc(FoodItemWithDocID oneFoodItemWithDocID,List<NewIngredient> allIngredients,{int fromWhichPage =1}) {

//    getAllIngredients(/*fromWhichPage*/);

    if(fromWhichPage==0){

      print('0 means from login page or welcome page');

      foodGalleryBlockObject = FoodGalleryBloc();
      foodItemDetailsBlockObject = FoodItemDetailsBloc(emptyFoodItemWithDocID,[] ,fromWhichPage:0);

    }
    else{

      print('from which page ==1 means from Food Gallery page to FoodDetails Page');

      logger.w('allIngredients: $allIngredients');
      foodGalleryBlockObject = FoodGalleryBloc();
      foodItemDetailsBlockObject = FoodItemDetailsBloc(oneFoodItemWithDocID,allIngredients ,fromWhichPage:1);
    }

//    foodGalleryBlockObject.counter$.listen(foodItemDetailsBlockObject.increment.add);
  }

//  final bloc = BlocProvider.of<FoodGalleryBloc>(context);
//  final bloc = BlocProvider.of(context).getFoodGalleryBlockObject;


  FoodGalleryBloc get getFoodGalleryBlockObject => foodGalleryBlockObject;
  FoodItemDetailsBloc get getFoodItemDetailsBlockObject => foodItemDetailsBlockObject;
}