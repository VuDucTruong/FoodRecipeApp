
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';

class LoadingScreen extends StatefulWidget{
  const LoadingScreen({super.key});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
              decoration: const BoxDecoration(
                gradient: ColorManager.linearGradientPink,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    PicturePath.logoSVGPath,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 35),
                  // centered aligned text
                  const Center(
                    child: Text(
                      AppStrings.sologan,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
