import 'package:flutter/widgets.dart';

enum ScreenState {
  about,
  loading,
  signed_out,
  signed_in,
  signed_in_anonymously,
}

class ScreenProperties {
  final String appBarTitle;
  final Widget ui;

  const ScreenProperties({this.appBarTitle, this.ui});
}
