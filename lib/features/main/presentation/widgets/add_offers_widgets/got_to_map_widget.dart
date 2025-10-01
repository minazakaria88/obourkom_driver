import 'package:flutter/material.dart';
import '../../../../../core/functions/go_to_google_maps.dart';

class GoToMapWidget extends StatelessWidget {
  const GoToMapWidget({
    super.key, required this.lat, required this.lng,
  });

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        goToMaps(lat,lng);
      },
      icon: const Icon(Icons.location_on_outlined,color: Colors.red,size: 20,),
    );
  }
}
