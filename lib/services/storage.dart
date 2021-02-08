import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  Future readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  Future deleteSecureData(String key) async {
    return await _storage.delete(key: key);
  }
}
