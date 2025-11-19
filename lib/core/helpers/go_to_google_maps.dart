import 'package:url_launcher/url_launcher.dart';

import 'dart:io' show Platform;

Future<void> goToMaps(double latitude, double longitude) async {
  final Uri uri = Platform.isIOS
      ? Uri.parse('http://maps.apple.com/?q=$latitude,$longitude') // Apple Maps
      : Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
        ); // Google Maps

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $uri';
  }
}

