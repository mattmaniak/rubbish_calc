import 'package:url_launcher/url_launcher.dart';

void openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Unable to open the license in a browser.';
  }
}
