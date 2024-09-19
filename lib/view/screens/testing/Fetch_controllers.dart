import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class TestingLedController extends GetxController {
  final DatabaseReference dataRef = FirebaseDatabase.instance.ref();
  var ledData = <String, dynamic>{}.obs;
  var bayNames = <String>[].obs;
  Future<void> fetchLedData() async {
    try {
      DataSnapshot snapshot = await dataRef.child('selfServeBays').get();
      if (snapshot.exists) {
        ledData.value = Map<String, dynamic>.from(snapshot.value as Map);
        // print(snapshot.value);
        // print(
        //     "SHAHYK JAHAN HERE IS YOUR TESTING DATA : ${ledData['superBrightBay']}");
        // print("SHAHIK JAHAN TESTING DATA : ${ledData[]}");
        bayNames.value = ledData.keys.toList();
        print("HERE ARE THE KEYS ONLY :${bayNames}");
      } else {
        print("no data available!");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
