import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/long_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/on_off_switch.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/default_heads.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/create_profile_view.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/bloc/food_type_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/food_type/widgets/food_item.dart';
import 'package:get_it/get_it.dart';

class SettingFoodTypeView extends StatefulWidget {
  final UserRegisterProfileBasics userRegisterProfile;
  SettingFoodTypeView({super.key, required this.userRegisterProfile});
  @override
  State<SettingFoodTypeView> createState() => _SettingFoodTypeViewState();
}

class _SettingFoodTypeViewState extends State<SettingFoodTypeView> {
  List<String> typeList = Constant.typeList;
  Map<String, bool> typePreferencesMap = {};
  MutableVariable<int> headNumber = MutableVariable(2);
  MutableVariable<bool> isVeg = MutableVariable(true);

  late FoodTypeBloc _foodTypeBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typePreferencesMap = {
      for (int i = 0; i < typeList.length; i++) typeList[i]: false
    };
    _foodTypeBloc = GetIt.instance<FoodTypeBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer(
            bloc: _foodTypeBloc,
            listener: (context, state) async {
              Navigator.popUntil(context, (route) => route is! DialogRoute);
              if (state is FoodTypeLoading) {
                showDialog(
                    context: context,
                    builder: (context) => const LoadingDialog());
              } else if (state is FoodTypeSubmitFailure) {
                final failure = state.failure;
                handleBlocFailures(
                    context, failure, () => Navigator.of(context).pop());
              } else if (state is FoodTypeSubmitSuccess) {
                showAnimatedDialog2(context, CongratulationDialog())
                    .then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginRoute,
                      ModalRoute.withName(Routes.loginRoute));
                });
              }
            },
            builder: (context, state) {
              double appWidth = MediaQuery.of(context).size.width;
              return Column(
                children: [
                  _buildTitleSetupKitchen(),
                  _buildSubTitleSelectPreference(),
                  _buildLongSwitch(appWidth),
                  _buildTypeList(appWidth),
                  _buildHungryHeads(),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  _buildNotificationOption(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: FilledButton(
                        onPressed: () {
                          _handleOnPressed();
                        },
                        child: Text(
                          AppStrings.continueOnly,
                          style: getMediumStyle(
                              color: Colors.white, fontSize: FontSize.s20),
                        )),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    int count = 0;
    for (var element in typePreferencesMap.values) {
      if (element) count++;
      if (count >= 3) break;
    }
    if (count < 3) {
      showDialog(
          context: context,
          builder: (context) =>
              AppErrorDialog(content: 'Please select at least 3 preferences'));
    } else {
      _foodTypeBloc
          .add(FoodTypeSubmit(userRegisterProfile: gatherProfileSubmit()));
    }
  }

  Widget _buildTitleSetupKitchen() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Text(
        AppStrings.setUpKitchen,
        style: getBoldStyle(color: Colors.black, fontSize: FontSize.s20),
      ),
    );
  }

  Widget _buildLongSwitch(double appWidth) {
    return Center(
      child: LongSwitch(
        onContent: AppStrings.veg,
        offContent: AppStrings.nonVeg,
        onColor: ColorManager.linearGradientLightTheme,
        offColor: ColorManager.linearGradientNonVeg,
        width: appWidth * 0.65,
        height: 40,
      ),
    );
  }

  Widget _buildSubTitleSelectPreference() {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            child: Text(
              AppStrings.selectPreferences,
              style: getSemiBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s20),
            )),
      ],
    );
  }

  Widget _buildHungryHeads() {
    return Row(
      children: [
        Text(
          AppStrings.hungryHeads,
          style: getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s18),
        ),
        const Spacer(),
        DefaultHeads(
          headNumber: headNumber,
        ),
      ],
    );
  }

  Widget _buildNotificationOption() {
    return Row(
      children: [
        Text(
          AppStrings.newDishNotification,
          style: getSemiBoldStyle(color: Colors.black, fontSize: FontSize.s18),
        ),
        const Spacer(),
        OnOffSwitch(
          isOn: isVeg,
        )
      ],
    );
  }

  UserRegisterProfileAdvanced gatherProfileSubmit() {
    List<String> categories = [];
    typePreferencesMap.forEach((key, value) {
      if (value) {
        categories.add(key);
      }
    });
    return UserRegisterProfileAdvanced(
      userRegisterProfile: widget.userRegisterProfile,
      isVegan: isVeg.value,
      categories: categories,
      hungryHeads: headNumber.value,
    );
  }

  SizedBox _buildTypeList(double appWidth) {
    return SizedBox(
      height: 300,
      child: Center(
          child: Wrap(
              runSpacing: 8,
              spacing: 16,
              children: List.generate(
                  typeList.length,
                  (index) => FoodItem(
                        width: appWidth / 2.5,
                        foodTypeMap: typePreferencesMap,
                        foodName: typeList[index],
                      )))),
    );
  }
}
