// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import '../services/secure_storage_service.dart';
// final _storage = StorageService().storage;
//
// Future<void> initializeConfig() async {
//   await Firebase.initializeApp();
//   final _storage = const FlutterSecureStorage();
//   late FirebaseRemoteConfig _remoteConfig;
//
//   _remoteConfig = FirebaseRemoteConfig.instance;
//   await _remoteConfig.fetchAndActivate();
//   var month_date = _remoteConfig.getString('month_date');
//   await _addConfig('month_date', month_date);
//
// }
//
// Future<void> _addConfig(String key, String value) async {
//   await _storage.write(
//     key: key,
//     value: value,
//     //iOptions: _getIOSOptions(),
//     //aOptions: _getAndroidOptions(),
//   );
// }
//
// Future<String?> getConfig(String key) async {
//   String? val = await _storage.read(
//     key: key,
//     //iOptions: _getIOSOptions(),
//     //aOptions: _getAndroidOptions(),
//   );
//   return val;
// }
//
//
// Future<void> deleteAll() async {
//   await _storage.deleteAll(
//     iOptions: _getIOSOptions(),
//     aOptions: _getAndroidOptions(),
//   );
// }
//
// IOSOptions _getIOSOptions() => IOSOptions(
//   //accountName: _getAccountName(),
// );
//
// AndroidOptions _getAndroidOptions() => const AndroidOptions(
//   encryptedSharedPreferences: true,
// );
//
// //String? _getAccountName() =>
// //    _accountNameController.text.isEmpty ? null : _accountNameController.text;
//
//
