import 'package:flutter/widgets.dart';

enum ScreenState {
  about,
  loading,
  signed_out,
  signed_in,
  signed_in_anonymously,
}

class ScreenProperties {
  final String appBarTitleSufix;
  final Widget ui;

  const ScreenProperties({this.appBarTitleSufix, this.ui});
}
