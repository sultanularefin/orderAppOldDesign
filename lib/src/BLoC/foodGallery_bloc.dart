


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

import 'package:foodgallery/src/DataLayer/models/newCategory.dart';


import 'package:logger/logger.dart';


import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';

class FoodGalleryBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://linkupadminolddbandclientapp.appspot.com');



  bool  _isDisposedIngredients = false;

  bool    _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;


  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];

  List<NewIngredient> _allIngItemsFGBloc =[];

  List<NewIngredient> get getAllIngredientsPublicFGB2 => _allIngItemsFGBloc;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;
  final _allIngredientListController = StreamController <List<NewIngredient>> /*.broadcast*/();


  final _client = FirebaseClient();


  List<FoodItemWithDocID> get allFoodItems => _allFoodsList;
  List<NewCategoryItem> get allCategories => _allCategoryList;

  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();



  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;


  Future<void> getAllOldIngredientsConstructor() async {
    print('at getAllIngredientsConstructor()');


    if (_isDisposedIngredients == false) {
      var snapshot = await _client.fetchAllOldIngredients();
      List docList = snapshot.docs;

      logger.w("all oldIngredients lenght: ${docList.length} ");


      List <NewIngredient> ingItems = new List<NewIngredient>();
      ingItems = snapshot.docs.map((documentSnapshot) =>
          NewIngredient.ingredientConvert
            (documentSnapshot.data(), documentSnapshot.id)

      ).toList();


      List<String> documents = snapshot.docs.map((documentSnapshot) =>
      documentSnapshot.id
      ).toList();


// xxx-->
// get download image url=>
//
// print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');



      for (int i = 0; i< ingItems.length ; i++){

        String fileName2  = ingItems[i].imageURL;
        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForIngredientItemImage = storage
            .ref()
            .child(fileName2);

        String newimageURLIngredient = await storageReferenceForIngredientItemImage.getDownloadURL();

        ingItems[i].imageURL= newimageURLIngredient;


      }

      ingItems.forEach((doc) {
        print('one Extra . . . . . . . name: ${doc.ingredientName} documentID: ${doc.documentId}');
      }
      );

      // logger.i('newimageURL ingredient Item : ${ingItems[0].imageURL}');



//       _allExtraIngredients = ingItems;
//
//       _allExtraIngredientItemsController.sink.add(_allExtraIngredients);
//       _isDisposedExtraIngredients=true;
// xxx-->
      _allIngItemsFGBloc = ingItems;

      _allIngredientListController.sink.add(_allIngItemsFGBloc);


      _isDisposedIngredients=true;

    }
    else {
      return;
    }
  }

 // List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {
 //
 //    List<String> stringList = List<String>.from(dlist);
 //
 //    return stringList;
 //
 //
 //  }



  // Future<String> getDownloadURL2(String imageURL) async{
  //
  //   StorageReference storageReference_2 = storage
  //       .ref()
  //       .child('foodItems2')
  //       .child(imageURL);
  //
  //   String x;
  //   try {
  //     x = await storageReference_2.getDownloadURL();
  //   } catch (e) {
  //
  //     print('e         _____ -----: $e');
  //
  //   }
  //
  //
  //   print('x         _____ -----: $x');
  //
  //   return x;
  // }
  //
  //
  // Future<String> _downloadFile(StorageReference ref) async {
  //   final String url = await ref.getDownloadURL();
  //
  //   return url;
  // }


  void getAllFoodItemsConstructor() async {

    print('at getAllFoodItemsConstructor()');


    if(_isDisposedFoodItems==true) {
      return;
    }
    else {



      var snapshot = await _client.fetchFoodItems();
      List docList = snapshot.docs;

      List<FoodItemWithDocID> tempAllFoodsList= new List<FoodItemWithDocID>();
      docList.forEach((doc) {

        Map getDocs = doc.data();
        final String foodItemName = getDocs ['name'];
        //doc['name'];


        final String foodItemDocumentID = doc.documentID;


        final String foodImageURL  = getDocs ['image'];

        // final String foodImageURL  = doc['image']==''?
        // 'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        //     :
        // storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
        //     +'?alt=media';

        final bool foodIsAvailable =  doc['isAvailable'];


        final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];

        final List<dynamic> foodItemIngredientsList =  doc['ingredients'];

        final String foodCategoryName = doc['category'];

        final double foodItemDiscount = 0;

        FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(
          itemName: foodItemName,
          categoryName: foodCategoryName,
          imageURL: foodImageURL,
          sizedFoodPrices: oneFoodSizePriceMap,
          ingredients: foodItemIngredientsList,
          isAvailable: foodIsAvailable,
          documentId: foodItemDocumentID,
          discount: foodItemDiscount,
        );

        tempAllFoodsList.add(oneFoodItemWithDocID);
      }
      );


      for (int i =0; i< tempAllFoodsList.length ; i++){


        String fileName2  = tempAllFoodsList[i].imageURL;


        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForFoodItemImage = storage
            .ref()
            .child(fileName2);

        String newimageURLFood = await storageReferenceForFoodItemImage.getDownloadURL();

        tempAllFoodsList[i].imageURL= newimageURLFood;

        print('newimageURL food Item : $newimageURLFood');
      }





      _allFoodsList= tempAllFoodsList;

//       _foodItemController.sink.add(_allFoodsList);
//       _isDisposedFoodItems = true;
// */
      _allFoodsList= tempAllFoodsList;

      _foodItemController.sink.add(_allFoodsList);
      _isDisposedFoodItems = true;

    }
  }

  void getAllCategoriesConstructor() async {

    print('at getAllCategoriesConstructor()');

    if(_isDisposedCategories == true) {
      return;
    }

    else {


      var snapshot = await _client.fetchCategoryItems();
      List docList = snapshot.docs;


      List<NewCategoryItem> tempAllCategories = new List<NewCategoryItem>();

      docList.forEach((doc) {

        // final String categoryItemName = doc.get('name');//['name'];
        final String categoryItemName = doc['name'];

        print('categoryItemName : $categoryItemName');

        // final String categoryImageURL  = doc['image']==''?
        // 'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        //     :
        // storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
        //     +'?alt=media';

        final String categoryImageURL  = doc.get('image');

        final num categoryRating = doc['sequenceNo'];

        print('categoryItemName : $categoryItemName,categoryRating :'
            ' $categoryRating,  categoryImageURL: $categoryImageURL');


        NewCategoryItem oneCategoryItem = new NewCategoryItem(

          categoryName: categoryItemName,
          imageURL: categoryImageURL,
          rating: categoryRating.toInt(),
        );

        tempAllCategories.add(oneCategoryItem);
      }
      );

      for (int i =0; i< tempAllCategories.length ; i++){


        String fileName2  = tempAllCategories[i].imageURL;


        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForFoodItemImage = storage
            .ref()
            .child(fileName2);

        String newimageURLFood = await storageReferenceForFoodItemImage.getDownloadURL();

        tempAllCategories[i].imageURL= newimageURLFood;

        print('newimageURL category Item : $newimageURLFood');
      }


      // _allFoodsList= tempAllFoodsList;







      _allCategoryList= tempAllCategories;

      _categoriesController.sink.add(_allCategoryList);

      _isDisposedCategories = true;

    }
  }


  // CONSTRUCTOR BIGINS HERE..
  FoodGalleryBloc() {

    print('at FoodGalleryBloc()');



    getAllOldIngredientsConstructor();

    getAllFoodItemsConstructor();

    getAllCategoriesConstructor();


    print('at FoodGalleryBloc()');


  }


  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoriesController.close();
    _allIngredientListController.close();

    _isDisposedIngredients = true;
    _isDisposedFoodItems = true;
    _isDisposedCategories = true;


  }
}