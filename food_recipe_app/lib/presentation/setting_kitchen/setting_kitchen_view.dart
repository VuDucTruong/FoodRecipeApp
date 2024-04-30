
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/bloc/create_profile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../resources/font_manager.dart';
import '../resources/value_manament.dart';
import 'create_profile/create_profile_view.dart';
import 'food_type/setting_food_type_view.dart';

class SettingKitchenView extends StatefulWidget {
  final ThirdPartySignInAccount? thirdPartySignInAccount;
  const SettingKitchenView({super.key,this.thirdPartySignInAccount});

  @override
  _SettingKitchenViewState createState() {
    return _SettingKitchenViewState();
  }
}

class _SettingKitchenViewState extends State<SettingKitchenView> {
  late PageController _pageController;
  bool isOn = true;
  int pageIndex = 0;
  List<Widget> pages = [const SettingFoodTypeView()];
  late CreateProfileBloc _createProfileBloc;
  @override
  void initState() {
    _pageController = PageController(keepPage: false, initialPage: 0);
    ThirdPartySignInAccount? thirdPartySignInAccount = widget.thirdPartySignInAccount;
    if (thirdPartySignInAccount != null) {
      final createProfile = CreateProfileView(
          thirdPartySignInAccount: thirdPartySignInAccount,);
      pages.insert(0, createProfile);
    }
    else{
      const createProfile = CreateProfileView();
      pages.insert(0, createProfile);
    }
    _createProfileBloc=GetIt.instance<CreateProfileBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m6),
          child: BlocConsumer(
            bloc: _createProfileBloc,
            listener: (context,state){
              if(state is CreateProfileSubmitNavigateOptional)
                {
                  _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  // Navigator.of(context).pushNamed(Routes.mainRoute);
                }

            },
            builder: (context,state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Text(
                      AppStrings.setUpKitchen,
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s20),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
              onPressed: () {
                _createProfileBloc.add(CreateProfileOnContinue());
              },
              child: Text(
                AppStrings.continueOnly,
                style:
                    getMediumStyle(color: Colors.white, fontSize: FontSize.s20),
              )),
          const SizedBox(
            height: 8,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
