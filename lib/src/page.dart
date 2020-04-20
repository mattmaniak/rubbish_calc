/// The package with all various screen variations - pages.

library page;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rubbish_calc/src/auth.dart';

part 'package:rubbish_calc/src/page/about.dart';
part 'package:rubbish_calc/src/page/loading_animation.dart';
part 'package:rubbish_calc/src/page/login.dart';
part 'package:rubbish_calc/src/page/user_area.dart';
part 'package:rubbish_calc/src/page/_scrollable_utils.dart';

/// Possible pages to display on a screen.
enum Visible {
  about,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}
