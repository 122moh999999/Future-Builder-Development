// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:odoo_hr/core/app_settings/app_settings.dart';
// import 'package:odoo_hr/core/utils/constant.dart';
// import 'package:zapx/Zap/extensions/zap_translate.dart';
// import 'package:zapx/zapx.dart';

// extension CubitExtensions<T> on Cubit<T> {
//   void update(T newState) {
//     if (!isClosed) {
//       // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//       emit(newState);
//     } else {
//       logger.i('⚠️ Cubit is closed, cannot emit new state: $newState');
//     }
//   }
// }
// extension CustomPadding on Widget {
//   Padding get paddingDefault =>
//       Padding(padding: const EdgeInsets.all(10), child: this);
// }

// extension CustomColor on Color {
//   Color addOpacity(double opacity) {
//     int alpha = (opacity * 255).toInt().clamp(0, 255);
//     return withAlpha(alpha);
//   }
// }


// extension CustomInt on int{
//   String get monthName=>months[this-1] ;
// }

// extension CustomString on String {

//   int get monthNumber => months.indexWhere((v)=>v==this)+1;

//   String getHourByDate() {
//     var date = DateTime.parse(this);
//     return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
//   }


//   String get capitalizeFirst {
//     if (isEmpty) return this;
//     return this[0].toUpperCase() + substring(1).toLowerCase();
//   }


// //Dates

//   String formatTimeing({bool removeDays = false}) {
//     if (trim().isEmpty) return '';
//     var date = DateTime.parse(
//       "${this}z",
//     ).toLocal();

//     bool isToday = date.year == DateTime.now().year &&
//         date.month == DateTime.now().month &&
//         date.day == DateTime.now().day;

//     String formattedDate;
//     int hour =
//         date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
//     String period = (date.hour >= 12 ? "PM" : "AM").ztr;
//     if (isToday) {
//       formattedDate = "$hour:${date.minute.toString().padLeft(2, '0')} $period";
//     } else {
//       if (removeDays) {
//         formattedDate =
//             "$hour:${date.minute.toString().padLeft(2, '0')} $period";
//       } else {
//         formattedDate =
//             "${date.day}/${date.month}/${date.year} , $hour:${date.minute.toString().padLeft(2, '0')} $period";
//       }
//     }
//     return formattedDate;
//   }
// }

// extension DateTime1 on DateTime {
//   DateTime get formatLocale =>
//       DateTime.parse('${toIso8601String()}z').toLocal();
//   String get formatingDateTime {
//     return toIso8601String().formatTimeing(removeDays: true);
//   }

//   String get formatingHms {
//     if(Zap.context.mounted){

//     final bool is24HourFormat = MediaQuery.of(Zap.context).alwaysUse24HourFormat;

//     // Format the time based on the 24-hour or 12-hour setting
//     final String formattedTime = is24HourFormat
//         ? DateFormat.Hms(AppSettings.currentLang).format(formatLocale)
//         : DateFormat.jm(AppSettings.currentLang).format(formatLocale);
//         return formattedTime;
//     }
//     return '';
//   }

//   String get ymdString {
//     return "${year.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
//   }


//     String get formatHourOrDate {
//     final now = DateTime.now();
//     final inDay = now.year == year && now.month == month && now.day == day;

//     if (inDay) {
//       final use24Hour = MediaQuery.of(Zap.context).alwaysUse24HourFormat;
//       final formatter = use24Hour ? DateFormat.Hm() : DateFormat.jm();
//       return formatter.format(this);
//     } else {
//       return DateFormat("yyyy-MM-dd").format(this);
//     }
//   }

// }
