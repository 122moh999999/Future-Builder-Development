import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

enum FieldType { text, dropdown, date, time }

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.perfixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.color,
    this.autofocus = false,
    this.keyboardType,
    this.validator,
    this.fieldType = FieldType.text,
    this.dropdownItems,
    this.onDateSelected,
    this.maxLines = 1,
    this.minLines,
    this.onTimeChanged,
  });
  final FieldType fieldType;
  final String? hintText;
  final void Function(String? v)? onChanged, onFieldSubmitted;
  final TextEditingController? controller;
  final Widget? suffixIcon, perfixIcon;
  final TextInputAction? textInputAction;
  final bool autofocus, obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? color;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final void Function(DateTime)? onDateSelected;
  final void Function(TimeOfDay)? onTimeChanged;
  final int? minLines, maxLines;
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0.8,
        color: Colors.black,
      ),
    );
    var decoration = InputDecoration(
      hintText: hintText,
      border: border,
      suffixIcon: suffixIcon,
      prefixIcon: perfixIcon,
      enabledBorder: border,
      filled: true,
      fillColor:Colors.white  // color ?? (isDarkMode ? null : Colors.white),
      ,focusedBorder: border,
    );
    bool isText = fieldType == FieldType.text;
    if (fieldType == FieldType.dropdown) {
      return DropdownButtonFormField<String>(
        items: dropdownItems,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        validator: validator,
        decoration: decoration,
        onChanged: onChanged,
      );
    }
    return InkWell(
      onTap: () async {
        if (fieldType == FieldType.date) {
          final DateTime currentDate = DateTime.now();
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: currentDate,
            lastDate: currentDate.add(const Duration(days: 365)),
          );

          if (pickedDate != null && context.mounted) {
            final format = intl.DateFormat('yyyy-MM-dd');
            controller?.text = format.format(
                DateTime(pickedDate.year, pickedDate.month, pickedDate.day));
            onDateSelected?.call(pickedDate);
          }
        } else if (fieldType == FieldType.time) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null && context.mounted) {
            final formattedTime = pickedTime.format(context);
            controller?.text = formattedTime;
            onTimeChanged?.call(pickedTime);
          }
        }
      },
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autofocus,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        enabled: isText,
        textInputAction: textInputAction,
        decoration: decoration,
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}
