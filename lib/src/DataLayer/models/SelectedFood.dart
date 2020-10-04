//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

//import 'dart:core';
import 'dart:math';

import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


class SelectedFood {

  final String  foodItemName;      // one of foodItems> collection.
  final String  foodItemImageURL;
  final double  unitPrice;
  final String  foodDocumentId;
  int           quantity;
  final String  foodItemSize;
  final String  categoryName;
  final double     discount;
  // final String foodItemOrderID;     // random might not be needed.
  List<NewIngredient> selectedIngredients;
  List<CheeseItem>  selectedCheeseItems;
  List<SauceItem>   selectedSauceItems;
  double subTotalPrice;

//  String ingredients;
//  itemId = await generateItemId(6);

  SelectedFood(
      {
        this.foodItemName,
        this.foodItemImageURL,
        this.unitPrice,
        this.foodDocumentId,
        this.quantity,
        this.foodItemSize,
        this.selectedIngredients,
        this.categoryName,
        this.discount,
        this.selectedCheeseItems,
        this.selectedSauceItems,
        this.subTotalPrice,

        // this.foodItemOrderID,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

//  OrderList.fromMap(Map<String, dynamic> data,String docID)
//      :imageURL= data['image'],
//        ingredientName= data['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,
//        ingredientAmountByUser = 1;



  Future<String> generateItemId(int length)  async {
    String _result = "";
    int i = 0;
    String _allowedChars ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      //      print('randomInt: $randomInt');
      //Get random char and append it to the password

      //      print('_allowedChars[randomInt]: ${_allowedChars[randomInt]}');


      _result += _allowedChars[randomInt];

      //      print('_result: $_result');

      i++;
    }

    return _result;
  }

}
