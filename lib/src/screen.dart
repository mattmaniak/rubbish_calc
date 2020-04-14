library screen;

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rubbish_calc/src/auth.dart';

part 'package:rubbish_calc/src/screen/about.dart';
part 'package:rubbish_calc/src/screen/loading_animation.dart';
part 'package:rubbish_calc/src/screen/login.dart';
part 'package:rubbish_calc/src/screen/user_area.dart';

enum Mode {
  about,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}

class Screen {
  final String appBarTitleSufix;
  final Widget ui;

  const Screen({this.appBarTitleSufix, this.ui});
}
