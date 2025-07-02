
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
 static final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> saveToken (String token){
    return storage.write(key: "token", value: token);
  }

  static Future<String?> getToken()async{
    String? token = await storage.read(key: "token");
    return token;
  }

  static Future<void> clearData()async{
    return storage.deleteAll();
  }
}