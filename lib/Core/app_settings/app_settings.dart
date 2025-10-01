// import 'dart:ui';

// import 'package:odoo_hr/core/services/storage_service.dart';

// bool get isArLang => AppSettings.currentLang == 'ar';

// class AppSettings {
//   ///[Locale]
//   ///
//   static String get currentLang =>
//       locale?.languageCode ?? deviceLocale.languageCode;
//   static String? lang;
//   static Locale deviceLocale = PlatformDispatcher.instance.locale;
//   static Locale? get locale => lang == null ? null : Locale(lang!);

// //
//   static bool isDarkMode = false;

//   //
//   static Future saveData() async {
//     await StorageService.setValue(
//       LocalStorageKeys.appSettings,
//       {
//         'language': lang,
//         'isDarkMode': isDarkMode,
//       },
//     );
//   }

//   static Future getData() async {
//     StorageService.getMap(LocalStorageKeys.appSettings).then((value) {
//       if (value != null) {
//         lang = value['language'];
//         isDarkMode = value['isDarkMode'] ?? false;
//       }
//     });
//   }
// }
