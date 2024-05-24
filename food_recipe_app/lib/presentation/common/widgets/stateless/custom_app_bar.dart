import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_management.dart';
import '../../../resources/color_management.dart';
import '../../../resources/string_management.dart';
import '../../../resources/style_management.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key , required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text(
        title,
        style: getBoldStyle(color: ColorManager.secondaryColor, fontSize: 20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          PicturePath.backArrowPath,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
