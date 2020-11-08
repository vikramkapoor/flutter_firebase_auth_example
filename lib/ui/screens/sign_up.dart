import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth_brainframe/ui/screens/sign_in.dart';
import 'dart:math' as math;
import './validation_item.dart';
import 'package:flutter_firebase_auth_brainframe/models/user.dart';
import 'package:flutter_firebase_auth_brainframe/util/auth.dart';
import 'package:flutter_firebase_auth_brainframe/util/validator.dart';
import 'package:flutter_firebase_auth_brainframe/ui/widgets/loading.dart';
import 'package:flutter_firebase_auth_brainframe/util/state_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _code = new TextEditingController();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final FocusNode _focus = new FocusNode();

  AnimationController _controller;
  Animation<double> _fabScale;

  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

  bool _autoValidate = false;
  bool _loadingVisible = false;
  int role;
  String hotelId;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _password.addListener(() {
      setState(() {
        eightChars = _password.text.length >= 8;
        number = _password.text.contains(RegExp(r'\d'), 0);
        upperCaseChar = _password.text.contains(new RegExp(r'[A-Z]'), 0);
        specialChar = _password.text.isNotEmpty &&
            !_password.text.contains(RegExp(r'^[\w&.-]+$'), 0);
      });

      if (_allValid()) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    _controller = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 500));

    _fabScale = Tween<double>(begin: 0, end: 1)
    .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _fabScale.addListener((){
      setState(() {

      });
    });  
  }

  void _onFocusChange(){
    debugPrint("Focus: "+_focus.hasFocus.toString());
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: headerImage,
    );
    /*
    final code = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      controller: _code,
      validator: Validator.validateHotelCode,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.hotel,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Hotel Code',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
*/
    final firstName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _firstName,
      validator: Validator.validateName,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final lastName = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _lastName,
      validator: Validator.validateName,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      focusNode: _focus,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _emailSignUp(
              firstName: _firstName.text,
              lastName: _lastName.text,
              email: _email.text,
              password: _password.text,
              code: _code.text,
              context: context);
        },   
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('SIGN UP'),
      ),
    );

    final signInLabel = FlatButton(
      child: Text(
        'Have an Account? Sign In.',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
    );

    return Scaffold(
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      /*code,
                      SizedBox(height: 24.0),*/
                      firstName,
                      SizedBox(height: 24.0),
                      lastName,
                      SizedBox(height: 24.0),
                      email,
                      SizedBox(height: 24.0),
                      password,
                      (_focus.hasFocus)?Padding(padding: const EdgeInsets.only(top:4), child: _validationStack()):Container(),
                      SizedBox(height: 12.0),
                      signUpButton,
                      signInLabel
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
/*
  Future<bool> _validateHotelCode(String code) async {
    Hotel hotel;
    hotelId = code.split("-")[0];
    String roleCode = code.split("-")[1];
    if (code != null) {
        hotel =  await Firestore.instance
          .collection('Hotels')
          .where("HotelID",isEqualTo:hotelId)
          .getDocuments()
          .then((querySnapshot) => (querySnapshot.documents.isNotEmpty)? Hotel.fromSnapshot(querySnapshot.documents[0]):null);
    }
    else {
      return false;
      print('Hotel code can not be null');
    }
    if (hotel != null) {
      if (roleCode == hotel.adminCode) {
      role = Role.Admin;
      return true;
      } else if  (roleCode == hotel.managerCode) {
      role = Role.Manager;
      return true;
      } else if (roleCode == hotel.workerCode) {
      role = Role.Worker;
      return true;
      }
    }
    else 
      return false;
  }
*/
  void _emailSignUp(
      {String firstName,
      String lastName,
      String email,
      String password,
      String code,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
       /* await _validateHotelCode(code).then((boValid) {
        if (!boValid) {
          throw new PlatformException(code:"ErrorCode", message:"Invalid hotel code.");
        }
        });*/
       await Auth.signUp(email, password).then((uID) {
         Auth.addUserSettingsDB(new User(
            userId: uID,
            email: email,
            firstName: firstName,
            lastName: lastName,
          ));
        });
        //now automatically login user too
        await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/');
        //await Navigator.pushNamed(context, '/signin');
       /*
       Flushbar(
          title: "Sign up successful",
          message:
              'You can now sign into your account.',
          duration: Duration(seconds: 5),
        )..show(context);    
        */
      } catch (e) {
        _changeLoadingVisible();
        print("Sign up error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Sign up error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget _separator() {
    return Container(
      height: 1,
      decoration: BoxDecoration(color: Colors.blue.withAlpha(100)),
    );
  }

  Stack _validationStack() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Card(
          shape: CircleBorder(),
          color: Colors.black12,
          child: Container(height: 150, width: 150,),),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0, left: 10),
          child: Transform.rotate(
            angle: -math.pi/20,
            child: Icon(
              Icons.lock,
              color: Colors.pink,
              size: 60,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 60),
          child: Transform.rotate(
            angle: -math.pi / -60,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 4,
              color: Colors.yellow.shade800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 74),
          child: Transform.rotate(
            angle: math.pi / -45,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ValidationItem("8 characters", eightChars),
                        _separator(),
                        ValidationItem("1 special character", specialChar),
                        _separator(),
                        ValidationItem("1 upper case", upperCaseChar),
                        _separator(),
                        ValidationItem("1 number", number)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: _fabScale.value,
                      child: Card(
                        shape: CircleBorder(),
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  bool _allValid() {
    return eightChars && number && specialChar && upperCaseChar;
  }

}
