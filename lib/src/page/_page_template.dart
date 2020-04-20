part of page;

/// Provide universal visual stuff for various pages.
///
/// As all pages have unifed layout, e.g. appBar, this mixin extends all pages
/// to provide an easy-to-programm and common user interface.
mixin _PageTemplateMixin {
  Widget _displayAppBar({@required String title, Widget leading}) {
    return SliverAppBar(
      leading: leading,
      pinned: true,
      floating: true,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(title),
        background: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text('Rubbish Calc'),
          ],
        ),
      ),
    );
  }
}
