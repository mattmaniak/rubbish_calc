/// The package with all various screen variations - pages.

library page;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rubbish_calc/src/app_injector.dart';

part 'package:rubbish_calc/src/page/_about.dart';
part 'package:rubbish_calc/src/page/_loading_animation.dart';
part 'package:rubbish_calc/src/page/_login_form.dart';
part 'package:rubbish_calc/src/page/_user_area.dart';
part 'package:rubbish_calc/src/page/_utils_scrollable.dart';

/// Possible pages to display on a screen.
enum Visible {
  about,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}
