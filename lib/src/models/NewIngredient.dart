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
  final String imageURL;
  final num price;
  final String documentId;
  final int ingredientAmountByUser;

//  String ingredients;

  NewIngredient(
      {
        this.ingredientName,
        this.imageURL,
        this.price,
        this.documentId,
        this.ingredientAmountByUser,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)
  NewIngredient.fromMap(Map<String, dynamic> data)
//      : ingredientName = data['ingredientName'],
//        uploadDate = data['uploadDate'].toDate(),
//        uploadedBy = data['uploadedBy'],
//        ingredientId = data['ingredientId'],
//        isAvailable = data['isAvailable'],

//  data['document'].documentID
      :imageURL= data['image'],
        ingredientName= data['name'],
        documentId = 'ss',
        price = 0,
        ingredientAmountByUser = 1;


//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
