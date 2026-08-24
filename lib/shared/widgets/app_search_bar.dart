import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class AppSearchBar extends StatelessWidget {
  final Color? fillColor;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  const AppSearchBar({
    super.key,
    this.fillColor,
    this.controller,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      style: TextStyle(color: colors.onSurface),
      cursorColor: colors.onSurface,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,

      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hint: Center(
          child: Text(
            hintText ?? '',
            style: TextStyle(color: colors.onSurface, fontFamily: fontFamily),
          ),
        ),
        // hintText: hintText,
        // hintStyle: TextStyle(
        //   color: colors.onSurface,
        //   fontFamily: fontFamily,
        // ),
        prefixIcon: prefixIcon,
        prefixIconColor: colors.onSurface,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
