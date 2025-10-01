// import 'package:flutter/material.dart';
// import 'package:odoo_hr/core/utils/custom_dialog.dart';
// import 'package:odoo_hr/core/utils/extensions.dart';
// import 'package:odoo_hr/core/utils/themes.dart';
// import 'package:odoo_hr/core/widgets/custom_container.dart';
// import 'package:odoo_hr/core/widgets/custom_text.dart';
// import 'package:odoo_hr/features/notifications/data/model/notification_model.dart';

// class CustomNotificationCard extends StatelessWidget {
//   final NotificationModel notification;
//   final String type;
//   final IconData icon;
//   final Color iconColor;
// g
//   const CustomNotificationCard({
//     super.key,
//     required this.notification,
//     required this.icon,
//     required this.iconColor,
//     required this.type,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomContainer(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         color: isDarkMode ? AppColor.darkGrey : Colors.grey.shade200,
//         borderRadius: 12,
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//         child: ListTile(
//           onTap: () {
//             customDialog(context,
//                 title: type, content: CustomText(notification.message));
//           },
//           leading: CircleAvatar(
//             backgroundColor: Colors.grey.shade100,
//             child: Icon(icon, color: iconColor),
//           ),
//           title: CustomText(
//             notification.message,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: CustomText(notification.date.formatHourOrDate),
//         ));
//   }
// }
