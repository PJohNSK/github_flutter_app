import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static const String name = "NAME";
  static const String avatarUrl = "AVATARURL";

  FlutterSecureStorage secureStore = new FlutterSecureStorage();

  setAuthorization(String nameValue, String avatarUrlValue) async {
    await secureStore.write(key: name, value: nameValue);
    await secureStore.write(key: avatarUrl, value: avatarUrlValue);
  }

  getName() async {
    return await secureStore.read(key: name) ?? "";
  }

  getAvatarUrl() async {
    return await secureStore.read(key: avatarUrl) ?? "";
  }

  clearToken() async {
    return await secureStore.deleteAll();
  }

}