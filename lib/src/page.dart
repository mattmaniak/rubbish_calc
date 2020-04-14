library page;

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rubbish_calc/src/auth.dart';
import 'package:rubbish_calc/src/dialog_box.dart';

part 'package:rubbish_calc/src/page/about.dart';
part 'package:rubbish_calc/src/page/loading_animation.dart';
part 'package:rubbish_calc/src/page/login.dart';
part 'package:rubbish_calc/src/page/user_area.dart';
part 'package:rubbish_calc/src/page/_page_template.dart';

enum Mode {
  about,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}
