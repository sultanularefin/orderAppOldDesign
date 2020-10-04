import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodgallery/src/identity/SignUpPage.dart';
import 'package:foodgallery/src/welcomePage.dart';

import './Widget/bezierContainer.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:foodgallery/src/BLoC/bloc_provider.dart';

import 'package:foodgallery/src/BLoC/identity_bloc.dart';


class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

//  @override
//  _WelcomePageState createState() => _WelcomePageState(fromWhicPage);

  @override
  _LoginPageState createState() => _LoginPageState();

//  _WelcomePageState createState() => _WelcomePageState(fromWhicPage);
}


// class _WelcomePageState extends State<WelcomePage> {
class _LoginPageState extends State<LoginPage> {



  _LoginPageState();

//  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String emailState ='';
  String passwordState = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




//  final logger = Logger(
//    printer: PrettyPrinter(),
//  );



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        key: _scaffoldKey,
//    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),

                        Container(
                            child: titleWidget()
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),

                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (){
                            print("login button pressed");
//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context) {
//                                  return Center(child: CircularProgressIndicator(),);
//                                });

                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 30), content:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("  Signing-In...",style:TextStyle(
                                      color: Colors.white38,
                                    ))
                                  ],
                                ),
                                )
                            );
                            final identityBlocLoginPage =
                            BlocProvider.of<IdentityBloc>(context);


                            Future<UserCredential> userCheck=
                            identityBlocLoginPage.handleSignInFromLoginPage(emailState.trim(),passwordState.trim());

//                            _handleSignIn();

                            userCheck.whenComplete(() {

                              print("called when future completes");

                            }
                            ).then((onValue){

//                              FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
//                              List<NewIngredient> emptyIngs = [];

//                              Navigator.of(context).pop();


                              Navigator.of(context).pushAndRemoveUntil(
                                //        MaterialPageRoute(builder: (context) => HomeScreen())
                                //
                                //        MaterialPageRoute(builder: (context) => MyHomePage())
                                  MaterialPageRoute(builder: (BuildContext context) {

                                    return BlocProvider<IdentityBloc>(
                                        bloc: IdentityBloc(),
                                        //AppBloc(emptyFoodItemWithDocID,loginPageIngredients,fromWhichPage:0),
                                        child: WelcomePage()
                                    );




                                  }),(Route<dynamic> route) => false);









//                            _handleSignIn();
                            }).catchError((onError){
//                              logger.e('at onError');
                              _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 6), content:Container(
                                  child:
                                  new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("Error: ${onError.message.substring(0,40)}",style:
                                      TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500,
                                          color:Colors.white)),
                                    ],
                                  ),
                                )),);

                            });
                          },

                          child:  _submitButton(),
                        ),

                      Container(
                        padding: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account? ",
                              style: TextStyle(color: /*Colors.white*/ Colors.blueGrey, fontSize: 16),
                            ),
                            InkWell(


                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()));

                                  // return Navigator.pushReplacement(
                                  //     context, MaterialPageRoute(builder: (context) => ChatRoom()));



                                  // widget.toggleView();
                                },

                              child: Text(
                                  "Register now",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                            ),

                          ],
                        ),
                      ),

                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        /* */
                      ],
                    ),
                  ),
                  /*
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(),
                  ),
                  */
                  Positioned(top: 40, left: 0, child: _backButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )


    ),
    );
  }
  void setEmailState( text) {
    print(text);
    setState(() {
      emailState = text;
    });
  }

    void setPasswordState( text){
      print(text);
      setState(() {
        passwordState = text;
      });
    }





//  final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;






    //functions marked 'async' must have a return type assignable to 'future'
    Future<bool> loadUser(/*String uid*/) async {

      print('at loadUser of Welcome Page');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //    ??=
      //    Assign the value only if the variable is null



      final resultString =   prefs.getString("userInfo");

      print('resultString in login Page $resultString');


      if(resultString == null) {

        return true;
      }
      print("found"); // thus nothing to return.
      return false;

      //1 means SharedPreference not empty.

    }





    Widget _backButton() {
      return InkWell(
        onTap: () {
          SystemNavigator.pop();
//        Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
              ),
              Text('Back',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      );
    }

    // email and password input.

    Widget _entryField(String title, {bool isPassword = false}) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                obscureText: isPassword,

                textInputAction: !isPassword? TextInputAction.next :TextInputAction.done,
//              textInputAction: TextInputAction.next,
                onSubmitted:(_) => !isPassword?  FocusScope.of(context).nextFocus():
                FocusScope.of(context).unfocus(),

//              onSubmitted: (_) => FocusScope.of(context).unfocus(),
                onChanged: (text) {
                  !isPassword?
                  setEmailState(text):setPasswordState(text);
//                print("First text field: $text");
                },

                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xffFFFA5F),
                    filled: true)
            )
          ],
        ),
      );
    }
//  _handleSignIn
    Widget _submitButton() {

      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448),
                  Color(0xfff7892b)])),

        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),


      );
    }


    // or login with facebook.












    Widget titleWidget() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'F',
            style:
            TextStyle( //Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'ood',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'Gallery',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
              ),
            ]),
      );
    }

    Widget _emailPasswordWidget() {
      return Column(
        children: <Widget>[
          _entryField("Email id"),
          _entryField("Password", isPassword: true),
        ],
      );
    }




  }
