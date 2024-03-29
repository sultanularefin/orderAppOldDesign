//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

import 'dart:core';

//final String storageBucketURLPredicate_Same =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class CheeseItem {

  final String cheeseItemName;
  final String imageURL;
  final double price;
  final String documentId;
  final int    cheeseItemAmountByUser;
  final int    sl;
        bool   isSelected;
        bool isDefaultSelected;

//  String ingredients;

  CheeseItem(
      {
        this.cheeseItemName,
        this.imageURL,
        this.price:0.0,
        this.documentId,
        this.cheeseItemAmountByUser,
        this.sl,
        this.isSelected:false,
        this.isDefaultSelected:false,

      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)
  CheeseItem.fromMap(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
        cheeseItemName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        cheeseItemAmountByUser = 0,
        sl = data['sl'],
        isSelected =false;
//
//
//  NewIngredient.updateIngredient(NewIngredient oneIngredient)
//       :imageURL= oneIngredient.imageURL,
//        ingredientName= oneIngredient.ingredientName,
//        price = oneIngredient.price,
//        documentId = oneIngredient.documentId,
//        ingredientAmountByUser = 0;






//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
