import 'package:flutter/material.dart';
import 'package:rooh/core/const/app_const.dart';

class AppSearchBar extends StatefulWidget {
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
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {});
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      style: TextStyle(color: colors.onSurface),
      cursorColor: colors.onSurface,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,

      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colors.onSurface, fontFamily: fontFamily),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: colors.onSurface,

        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close_rounded, color: colors.onSurface),
                onPressed: _clearText,
              )
            : null,

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
