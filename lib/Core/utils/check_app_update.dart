// import 'package:app_version_update/app_version_update.dart';
// import 'package:flutter/material.dart';
// import 'package:odoo_hr/core/widgets/custom_button.dart';
// import 'package:odoo_hr/core/widgets/custom_text.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:zap_sizer/zap_sizer.dart';
// import 'package:zapx/Zap/extensions/zap_translate.dart';
// import 'package:zapx/zapx.dart';

// class CheckAppUpdate {
//   static Future<void> onCheckForUpdate(BuildContext ctx) async {
//     AppVersionUpdate.checkForUpdates(
//       playStoreId: 'com.quick_services.dawami',
//     ).then((data) async {
//       if (data.canUpdate ?? false) {
//         if (!ctx.mounted) return;
//         Zap.offAll(
//             Scaffold(
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                       child: CustomText(
//                     '''The app needs to be updated now!
// You must update the app to continue.'''
//                         .ztr,
//                     fontSize: 18,
//                     textAlign: TextAlign.center,
//                   )),
//                   SizedBox(
//                     height: 1.h,
//                   ),
//                   Center(
//                     child: CustomButton(
//                       onPressed: () => launchUrl(
//                         Uri.parse(
//                           'https://play.google.com/store/apps/details?id=com.quick_services.dawami',
//                         ),
//                       ),
//                       child: CustomText("Upgrade now".ztr),
//                     ),
//                   ).paddingAll(15)
//                 ],
//               ),
//             ),
//             context: ctx);
//       }
//     });
//   }
// }
