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

class NewIngredient {

  final String ingredientName;
  /*final*/ String imageURL;
  final double price;
  final String documentId;
  final int    ingredientAmountByUser;
  bool isDefault;

//  String ingredients;

  NewIngredient(
      {
        this.ingredientName,
        this.imageURL,
        this.price,
        this.documentId,
        this.ingredientAmountByUser,
        this.isDefault,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

  /*
  // INVOCATION CODE FOODDETAILBLOC LINE # 324.
  ingItems = snapshot.documents.map((documentSnapshot) =>
  NewIngredient.fromMap
  */

  NewIngredient.ingredientConvert(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
        ingredientName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        isDefault= false,
        ingredientAmountByUser = 1;


  // PURPOSE SETTING ISDEFAULT TRUE INORDER TO CALCULATE PRICE UPON NEW INGREDIENT ADD
  NewIngredient.updateSelectedIngredient(NewIngredient oneIngredient)
      :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        isDefault= true;



  NewIngredient.updateUnselectedIngredient(NewIngredient oneIngredient)
       :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        isDefault= false;

  // PURPOSE SETTING ISDEFAULT TRUE INORDER TO CALCULATE PRICE UPON NEW INGREDIENT ADD
  /*
  NewIngredient.updateSelectedIngredient(NewIngredient oneIngredient)
      :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        isDefault= true;

  */






//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
