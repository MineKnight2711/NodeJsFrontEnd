import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../configs/colors.dart';
import '../../configs/font.dart';

class RoundTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final Icon? icon;
  final bool enable;
  const RoundTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.bgColor,
    this.left,
    this.obscureText = false,
    this.onChanged,
    this.icon,
    this.enable = true,
    this.onTap,
  });

  @override
  State<RoundTextfield> createState() => _RoundTextfieldState();
}

class _RoundTextfieldState extends State<RoundTextfield> {
  // final _textFieldErrorShakeKey = GlobalKey<ShakeWidgetState>();
  @override
  void initState() {
    super.initState();
  }

  String? _errorText;
  void checkOnchangedValidate(String? value) {
    setState(() {
      if (value != '' || value != null) {
        _errorText = widget.onChanged?.call(value);
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor ?? TextColor.textfield,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10), child: widget.icon)
              : const SizedBox.shrink(),
          if (widget.left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: widget.left!,
            ),
          Expanded(
            child: TextFormField(
              onTap: widget.onTap,
              enabled: widget.enable,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              onChanged: checkOnchangedValidate,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: CustomFonts.nunitoFont(fontSize: 14.r),
                errorText: _errorText,
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
