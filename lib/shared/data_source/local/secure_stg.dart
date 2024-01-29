import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> writeData(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static readData({required String key}) async {
    String value = await storage.read(key: key) ?? 'No data found!';
    log('Data read from secure storage: $value');
  }

  static Future<Map<String, dynamic>> readAllData() async {
    return await storage.readAll(
      iOptions: const IOSOptions(),
      aOptions: AndroidOptions(),
    );
  }

  static Future<bool> checkData({required String key}) async {
    return await storage.containsKey(key: key);
  }

  static deleteData({required String key}) async {
    await storage.delete(key: key);
    log('$key is deleted');
  }

  static deleteAllData() async {
    await storage.deleteAll(
      iOptions: const IOSOptions(),
      aOptions: AndroidOptions(),
    );
  }
}
