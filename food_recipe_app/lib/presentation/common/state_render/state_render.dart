import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';


class CommonTextInput extends StatefulWidget {
  final String label;
  final bool isRequired;
  final String hintText;
  final bool isObscure;
  bool isOn = true;

  final String? Function(String?)? validator; // Updated to accept nullable return value

  CommonTextInput({
    Key? key,
    this.hintText = '',
    this.isObscure = false,
    required this.label,
    this.isRequired = false,
    this.validator, // Updated to accept nullable function
  }) : super(key: key);

  TextEditingController getController() {
    return CommonTextInputState().controller;
  }

  @override
  CommonTextInputState createState() => CommonTextInputState();
}

class CommonTextInputState extends State<CommonTextInput> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller; // Define _controller getter

  IconButton _buildSuffixIcon() {
    return IconButton(
      icon: Icon(
        widget.isOn ? Icons.visibility_off : Icons.visibility,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          widget.isOn = !widget.isOn;
        });
      },
    );
  }
  Row _buildLabel(){
    return Row(
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.isRequired)
          const Text(
            ' *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildLabel(),// Label here
        Container(
          decoration: getBoxDecorationShadow(),// box shadow for input
          child: TextFormField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: interFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              suffixIcon: widget.isObscure ? _buildSuffixIcon() : null,
            ),
            style: const TextStyle(
              fontFamily: interFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            controller: _controller,
            obscureText: widget.isObscure && widget.isOn,
            validator: widget.validator ?? (value) => null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

