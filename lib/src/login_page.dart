import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:email_validator/email_validator.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/screen.dart';

class LoginPage extends StatefulWidget {
  final Function showScaffoldDialogBox;
  final Function showScaffoldSnackBar;
  final Function updateScreenState;

  const LoginPage(
      {@required this.updateScreenState,
      @required this.showScaffoldSnackBar,
      @required this.showScaffoldDialogBox});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _userUid;

  void dispose() {
    _auth.signOut();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
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
              Divider(),
              RaisedButton(
                child: Text('Sign in anonymously'),
                onPressed: _signInAnonymously,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState.validate()) {
      widget.updateScreenState(ScreenState.loading);

      try {
        _userUid = await _auth.signIn(
            _emailController.text.trim(), _passwordController.text.trim());
        await _auth.signOut();

        widget.showScaffoldSnackBar('Sign in token: $_userUid'); // TODO: DEBUG.
      } on AuthException catch (ex) {
        widget.showScaffoldSnackBar(ex.message);
      }
      widget.updateScreenState(ScreenState.signed_out);
    }
  }

  void _signInAnonymously() async {
    widget.updateScreenState(ScreenState.loading);

    _userUid = await _auth.signInAnonymously();
    await _auth.signOut();

    widget.showScaffoldSnackBar('Anon token: $_userUid'); // TODO: DEBUG.
    widget.updateScreenState(ScreenState.signed_out);
  }

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      widget.updateScreenState(ScreenState.loading);

      try {
        _userUid = await _auth.signUp(
            _emailController.text.trim(), _passwordController.text.trim());
        await _auth.verifyByEmail();
        await _auth.signOut();

        widget.showScaffoldSnackBar('Sign up token: $_userUid'); // TODO: DEBUG.
      } on AuthException catch (ex) {
        widget.showScaffoldSnackBar(ex.message);
      }
      widget.updateScreenState(ScreenState.signed_out);
      widget.showScaffoldDialogBox('Confirm account',
          'Check your mailbox and verify your account in order to sign in.');
    } else {
      widget.showScaffoldSnackBar('Invalid data format or no data at all.');
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
