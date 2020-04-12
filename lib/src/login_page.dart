import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:email_validator/email_validator.dart';

import 'package:rubbish_calc/src/auth.dart';

class LoginPage extends StatefulWidget {
  final Function showScaffoldSnackbar;

  const LoginPage({this.showScaffoldSnackbar});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _userUid;

  set _switchToLoadingMode(bool option) {
    setState(() {
      _isLoading = option;
    });
  }

  void dispose() {
    _auth.signOut();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      maxLines: 1,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _validateEmail,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      maxLines: 1,
                      enableSuggestions: false,
                      obscureText: true,
                      controller: _passwordController,
                      validator: _validatePassword,
                    ),
                    RaisedButton(
                      child: Text('Sign in'),
                      onPressed: _signIn,
                    ),
                    FlatButton(
                      child: Text('Sign up'),
                      onPressed: _signUp,
                    ),
                    FlatButton(
                      child: Text('Use anonymously'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void _signIn() async {
    if (_formKey.currentState.validate()) {
      _switchToLoadingMode = true;

      try {
        _auth
            .signIn(
                _emailController.text.trim(), _passwordController.text.trim())
            .then((id) {
          _userUid = id;
          widget.showScaffoldSnackbar('Sign in token: $_userUid'); // TODO: DEBUG.

          _auth.signOut();
        });
      } on AuthException catch (ex) {
        widget.showScaffoldSnackbar(ex.message);
      }
      _switchToLoadingMode = false;
    }
  }

  // void _signInAnonymously() async {}

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      _switchToLoadingMode = true;

      try {
        _auth
            .signUp(
                _emailController.text.trim(), _passwordController.text.trim())
            .then((id) {
          _userUid = id;
          widget.showScaffoldSnackbar('Sign up token: $_userUid'); // TODO: DEBUG.

          _auth.verifyByEmail();
          _auth.signOut();
        });
      } on AuthException catch (ex) {
        widget.showScaffoldSnackbar(ex.message);
      }
      _switchToLoadingMode = false;
    } else {
      widget.showScaffoldSnackbar('Invalid data format.');
    }
  }

  String _validateEmail(String email) {
    final bool hasCorrectFormat = EmailValidator.validate(email);

    if (email.isEmpty) {
      return 'Email field can\'t be empty.';
    } else if (hasCorrectFormat) {
      return null;
    } else {
      return 'Invalid email format.';
    }
  }

  String _validatePassword(String password) {
    // final bool isReasonablySafe =
    //     RegExp('((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{12,})').hasMatch(password);

    final bool isReasonablySafe = true; // TODO: DEBUG.

    if (password.isEmpty) {
      return 'Password field can\'t be empty.';
    } else if (isReasonablySafe) {
      return null;
    } else {
      return 'Use at least 12 chars with number and uppercase letter.';
    }
  }
}
