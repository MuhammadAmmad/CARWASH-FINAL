import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  // location_controller.dart

  // Check if location services are enabled
  Future<bool> checkLocationServices() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Request permission for location services
  Future<void> requestLocationPermission(BuildContext context) async {
    bool serviceEnabled = await checkLocationServices();
    if (!serviceEnabled) {
      // If services are not enabled, prompt the user to enable them
      await Geolocator.openLocationSettings();
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, show a dialog
          showLocationPermissionDialog(context);
        }
      } else if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, show a dialog
        showLocationPermissionDialog(context);
      } else {
        // Permissions are granted, open Google Maps
        openGoogleMaps();
      }
    }
  }

  // Show a dialog asking for location permissions
  void showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content:
            const Text('Please enable location services to use this feature.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Open Google Maps
  Future<void> openGoogleMaps() async {
    const url = 'https://www.google.com/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //CLAUDE CODE

  // *******************  //

  Future<void> requestLocationAndLaunchMap() async {
    // Check if location services are enabled
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // Request the user to enable location services
      await Geolocator.openLocationSettings();
      return;
    }

    // Check if location permission is granted
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return; // User denied the permission
      }
    }

    // Launch the Google Maps app
    final url = 'https://www.google.com/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
