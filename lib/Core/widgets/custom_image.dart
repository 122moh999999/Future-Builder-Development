// // ignore_for_file: library_prefixes, deprecated_member_use

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:zap_sizer/zap_sizer.dart';

// class CustomImage extends StatelessWidget {
//   const CustomImage(
//     this.path, {
//     super.key,
//     this.fit,
//     this.width,
//     this.height,
//     this.radius,
//     this.color,
//     this.size,
//   });

//   final String path;
//   final BoxFit? fit;
//   final Color? color;
//   final double? width, height, radius, size;
//   static ImageProvider provider(String path) {
//     final type = _getType(path);
//     switch (type) {
//       case 'svg_asset':
//         return svgProvider.Svg(
//           path,
//           source: svgProvider.SvgSource.asset,
//         );
//       case 'asset':
//         return AssetImage(path);
//       case 'file':
//         return FileImage(File(path));
//       case 'network':
//         return CachedNetworkImageProvider(path);
//       default:
//         throw Exception('Unsupported image type');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isAppBar =
//         context.findAncestorWidgetOfExactType<CustomAppBar>() != null;
//     final isButton =
//         context.findAncestorWidgetOfExactType<IconButton>() != null ||
//             context.findAncestorWidgetOfExactType<CustomButton>() != null;

//     Color? getColor() => isAppBar ? (color ?? Colors.white) : color;

//     double? getSize() => isButton ? (size ?? 22) : size;

//     final type = _getType(path);

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius ?? 1),
//       child: Builder(
//         builder: (_) {
//           switch (type) {

//             case 'svg_asset':
//               return SvgPicture.asset(
//                 path,
//                 fit: fit ?? BoxFit.contain,
//                 width: getSize()?.sp ?? width,
//                 color: getColor(),
//                 height: getSize()?.sp ?? height,
//               );
//             case 'asset':
//               return Image.asset(
//                 path,
//                 fit: fit,
//                 width: getSize()?.sp ?? width,
//                 color: getColor(),
//                 height: getSize()?.sp ?? height,
//               );
//             case 'file':
//               return Image.file(
//                 File(path),
//                 fit: fit,
//                 width: getSize()?.sp ?? width,
//                 color: getColor(),
//                 height: getSize()?.sp ?? height,
//               );
//             case 'base64':
//               return Image.memory(
//                 base64Decode(_extractBase64Data(path)),
//                 fit: fit,
//                 width: getSize()?.sp ?? width,
//                 height: getSize()?.sp ?? height,
//               );

//             case 'network':
//               return CachedNetworkImage(
//                 imageUrl: path,
//                 fit: fit,
//                 width: getSize()?.sp ?? width,
//                 height: getSize()?.sp ?? height,
//                 placeholder: (_, __) =>
//                     const Center(child: CircularProgressIndicator()),
//                 errorWidget: (_, __, ___) =>
//                     const Icon(Icons.error, color: Colors.red),
//               );
//             default:
//               return const Icon(Icons.error, color: Colors.red);
//           }
//         },
//       ),
//     );
//   }

//   static String _getType(String path) {
//     if (path.endsWith('.svg') && path.startsWith('assets/')) return 'svg_asset';
//     if (path.startsWith('assets/')) return 'asset';
//     if (path.startsWith('data:image/')) return 'base64';
//     if (path.startsWith('/data/user')) return 'file';
//     if (path.startsWith('http') || path.startsWith('https')) return 'network';
//     return 'unsupported';
//   }

//   static String _extractBase64Data(String base64String) {
//     final parts = base64String.split(',');
//     return parts.length > 1 ? parts[1] : base64String;
//   }
// }

import 'package:flutter/material.dart';
import 'package:future_builder_app/Core/widgets/custom_container.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, this.width, this.height, this.image});
  final double? width;
  final double? height;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: width,
      height: height,
      image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image!)),
    );
  }
}
