import 'package:flutter/widgets.dart';

enum ScreenState {
  about,
  loading,
  signedOut,
  signedIn,
  signedInAnonymously,
}

class ScreenProperties {
  final String appBarTitleSufix;
  final Widget ui;

  const ScreenProperties({this.appBarTitleSufix, this.ui});
}
