import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';

class Tok2DocTextField extends StatefulWidget {
  final TextEditingController? controller;
  RxBool? obscureText;
  bool? enabled;
  final bool? readOnly;
  final String? hintText;
  final prefixIcon;
  TextInputType? keyboardType;
  GestureTapCallback? onTap;
  FormFieldValidator<String>? validator;
  List<TextInputFormatter>? inputFormatters;

  Tok2DocTextField(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.obscureText,
      this.prefixIcon,
      this.onTap,
      this.keyboardType,
      this.validator,
      this.enabled,
      this.inputFormatters,
      this.readOnly = false})
      : super(key: key);

  @override
  State<Tok2DocTextField> createState() => _Tok2DocTextFieldState();
}

class _Tok2DocTextFieldState extends State<Tok2DocTextField> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText!.value,
        validator: widget.validator,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        readOnly: widget.readOnly!,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          errorMaxLines: 2,
          hintText: widget.hintText,
          fillColor: AppTheme.primaryColor.withOpacity(0.04),
          filled: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.hintText == "Password"
              ? GestureDetector(
                  onTap: () {
                    widget.obscureText!.value = !widget.obscureText!.value;
                  },
                  child: widget.obscureText!.value == false
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.remove_red_eye_outlined))
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
    });
  }
}
