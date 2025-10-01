// import 'package:flutter/material.dart';
// import 'package:odoo_hr/core/utils/themes.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton(
//       {super.key,
//       required this.onPressed,
//       required this.child,
//       this.isEnabled = true,
//       this.color,
//       this.borderRadius});
//   final Widget child;
//   final void Function()? onPressed;
//   final bool isEnabled;
//   final Color? color;
//   final double? borderRadius;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: WidgetStatePropertyAll(
//           color ?? (isEnabled ? AppColor.buttonColor : Colors.grey),
//         ),

//         shape: WidgetStatePropertyAll(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius ?? 10),
//           ),
//         ),
//       ),
//       onPressed: isEnabled ? onPressed : () {},
//       child: Center(child: child),
//     );
//   }
// }
