part of page;

mixin _PageTemplateMixin {
  Widget _displayAppBar({@required String titleSufix, Widget leading}) {
    return AppBar(
      title: Text('Rubbish Calc - $titleSufix'),
      centerTitle: true,
      leading: leading,
    );
  }
}
