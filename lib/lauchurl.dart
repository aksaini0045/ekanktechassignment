import 'package:url_launcher/url_launcher.dart';

void launchurl({required String urlpath}) async {
  
  final url = Uri.parse(urlpath);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch';
  }
}
