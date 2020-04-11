import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rubbish Calc'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                maxLines: 1,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                maxLines: 1,
                obscureText: true,
                enableSuggestions: false,
                validator: _validatePassword,
              ),
              RaisedButton(
                child: Text('Sign in/up'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Wrong data'),
      ));
    }
  }

  String _validateEmail(String email) {
    final bool hasCorrectFormat = EmailValidator.validate(email);

    if (email.isEmpty) {
      return 'Email field cannot be empty.';
    } else if (hasCorrectFormat) {
      return null;
    } else {
      return 'Invalid email format.';
    }
  }

  String _validatePassword(String password) {
    final bool isReasonablySafe =
        RegExp('((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{,12})').hasMatch(password);

    if (password.isEmpty) {
      return 'Password field cannot be empty.';
    } else if (isReasonablySafe) {
      return null;
    } else {
      return 'Use at least 12 chars with number and uppercase letter.';
    }
  }
}
