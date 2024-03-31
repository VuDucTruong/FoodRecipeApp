import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserDescription extends StatelessWidget {
  const UserDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      child: const Text(
          'Hola! I’m Claudia, a passionate chef and a part time designer. I learnt cooking '
          'from my grandmother and mom...'),
    );
  }
}
