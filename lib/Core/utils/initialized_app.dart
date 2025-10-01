// import 'dart:convert';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:odoo_hr/core/app_settings/app_settings.dart';
// import 'package:odoo_hr/core/services/background_service.dart';
// import 'package:odoo_hr/core/services/notification/notification_stream_service.dart';
// import 'package:odoo_hr/core/services/storage_service.dart';
// import 'package:odoo_hr/core/network/api_points.dart';
// import 'package:odoo_hr/core/services/notification/notification_service.dart';
// import 'package:odoo_hr/core/utils/constant.dart';
// import 'package:odoo_hr/core/utils/locator.dart';

// import '../../firebase_options.dart';

// Future initializedApp([bool initAll = true]) async {
//   if (initAll) {
//     initDependencyInjection();
//   }
//   NotificationStreamService.instance.getSaved();

//   var futuresData = await Future.wait([
//     StorageService.getString(LocalStorageKeys.userData),
//     StorageService.getString(LocalStorageKeys.savedUrl),
//     if (initAll) AppSettings.getData(),
//     if (initAll)
//       Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
//     if (initAll) BackgroundService.initialize(),
//   ]);
//   if (initAll) {
//     await NotificationService.init();
//   }
//   String? savedUserData = futuresData[0] as String?;
//   String? savedUrl = futuresData[1] as String?;
//   if (savedUrl != null) {
//     ApiPoints.API_BASE_URL = savedUrl;
//   }
//   if (savedUserData != null) {
//     userData = UserModel.fromJson(jsonDecode(savedUserData));
//   }
// }
