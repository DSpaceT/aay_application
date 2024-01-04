
import 'package:device_info/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DeviceUtils{
  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId = '';

    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceId = androidInfo.androidId;

    return deviceId;
  }
  static Future<bool> doesDeviceIdExist(String deviceId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users') // Replace with your Firestore collection name
        .where('id', isEqualTo: deviceId) // Replace with your field name
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  static Future<void> addDeviceIdToFirestore(String deviceId) async {
    await FirebaseFirestore.instance
        .collection('users') // Replace with your Firestore collection name
        .add({
      'id': deviceId, // Replace with your field name
    });
  }
}
