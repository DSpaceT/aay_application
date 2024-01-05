
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
// device_id_utils.dart
  // ... (other code)

  static Future<bool> doesDeviceExist(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: userId)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  static Future<void> addDeviceIfNotExists(String userId) async {
    bool doesExist = await doesDeviceExist(userId);

    if (!doesExist) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({
        'id': userId,
        // Add other user information as needed
      });
    }
  }
}


