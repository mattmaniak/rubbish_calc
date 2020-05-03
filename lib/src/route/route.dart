/// The package with all various screen variations - pages.

library route;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rubbish_calc/src/app_injector.dart';
import 'package:rubbish_calc/src/session_storage.dart';
import 'package:rubbish_calc/src/simple_alert_dialog.dart';

part 'package:rubbish_calc/src/route/_about.dart';
part 'package:rubbish_calc/src/route/_account_settings.dart';
part 'package:rubbish_calc/src/route/_login_form.dart';
part 'package:rubbish_calc/src/route/_user_area.dart';
part 'package:rubbish_calc/src/route/_utils_scrollable.dart';

/// Possible pages to display on a screen.
enum Visible {
  about,
  accountSettings,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}

/// Decide which route will be displayed.
class Picker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (AppInjector.of(context).visibleRoute) {
      case Visible.signedOut:
        return LoginForm();

      case Visible.signedIn:
        return UserArea(
          isUserAnonymous: false,
        );

      case Visible.accountSettings:
        return AccountSettings();

      case Visible.signedInAnonymously:
        return UserArea();

      case Visible.about:
        return About();

      case Visible.loading:
    }
    return LoginForm();
  }
}
