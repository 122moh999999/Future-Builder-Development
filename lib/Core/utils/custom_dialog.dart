// import 'package:flutter/material.dart';
// import 'package:odoo_hr/core/widgets/custom_text.dart';
// import 'package:zapx/zapx.dart';

// Future<T> customDialog<T>(BuildContext ctx,
//     {String? title, Widget? content, List<Widget>? actions}) async {
//   return await showDialog(
//       context: ctx,
//       builder: (c) => AlertDialog(
//             backgroundColor: Colors.white,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (title != null) Expanded(child: CustomText(title)),
//                 IconButton(onPressed: Zap.back, icon: const Icon(Icons.close))
//               ],
//             ),
//             content: content,
//             actions: actions,
//           ));
// }
