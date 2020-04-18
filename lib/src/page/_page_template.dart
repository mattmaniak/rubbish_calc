part of '../page.dart';

/// Provide universal visual stuff for various pages.
///
/// As all pages have unifed layout, e.g. appBar, this mixin extends all pages
/// to provide an easy-to-programm and common user interface.
mixin _PageTemplateMixin {
  Widget _displayAppBar({@required String titleSufix, List<Widget> actions}) {
    return AppBar(
      title: Text('Rubbish Calc - $titleSufix'),
      actions: actions,
    );
  }
}
