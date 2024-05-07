import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
      required this.validator,
      this.icon,
      required this.hint,
      required this.controller,
      this.maxLines = 1,
      required this.isPassword})
      : super(key: key);

  late String hint;
  String? Function(String? x) validator;
  Widget? icon;
  TextEditingController controller;
  int maxLines;
  bool isPassword;
  @override
  _CustomTextFormFieldState createState() {
    return _CustomTextFormFieldState();
  }
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isVisible;
  @override
  void initState() {
    super.initState();
    isVisible = widget.isPassword;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? _errorMessage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          surfaceTintColor: Colors.white70,
          color: Colors.white,
          child: TextFormField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            validator: (value) {
              final error = widget.validator.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _errorMessage = error;
                });
              });
              return _errorMessage;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: isVisible,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword ? _getPasswordIcon() : widget.icon,
              hintText: widget.hint,
            ),
          ),
        ),
        _errorMessage != null
            ? Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  _errorMessage!,
                  style: getMediumStyle(color: Colors.red),
                ),
              )
            : const SizedBox(height: 16)
      ],
    );
  }

  Widget _getPasswordIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isVisible
            ? SvgPicture.asset(
                width: 24,
                height: 24,
                PicturePath.eyeSolidPath,
                colorFilter: const ColorFilter.mode(
                    ColorManager.blueColor, BlendMode.srcIn),
              )
            : SvgPicture.asset(
                width: 24,
                height: 24,
                PicturePath.eyeSplashSolidPath,
                colorFilter: const ColorFilter.mode(
                    ColorManager.blueColor, BlendMode.srcIn),
              ),
      ),
    );
  }
}
