import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/list_chef_page/chef_item.dart';
import 'package:get_it/get_it.dart';

class FollowerListPage extends StatefulWidget {
  const FollowerListPage({super.key});
  @override
  _FollowerListPageState createState() {
    return _FollowerListPageState();
  }
}

class _FollowerListPageState extends State<FollowerListPage> {
  ScrollController scrollController = ScrollController();
  VerifiedChefsBloc verifiedChefsBloc = GetIt.instance<VerifiedChefsBloc>();
  List<ChefEntity> chefList = [];
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  @override
  void initState() {
    super.initState();
    print(backgroundUser.followingIds);
    verifiedChefsBloc.add(GetChefsByIds(backgroundUser.followingIds));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reload() {
    resetData();
    verifiedChefsBloc.add(GetChefsByIds(backgroundUser.followingIds));
  }

  void resetData() {
    chefList.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.followers.tr(),
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
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            BlocConsumer<VerifiedChefsBloc, VerifiedChefsState>(
              bloc: verifiedChefsBloc,
              listener: (context, state) {
                if (state is VerifiedChefsLoadedState) {
                  chefList.addAll(state.verifiedChefList);
                }
                if (state is VerifiedChefsErrorState) {
                  handleBlocFailures(context, state.failure, reload);
                }
              },
              buildWhen: (previous, current) =>
                  current is! VerifiedChefsActionState,
              builder: (context, state) {
                if (state is VerifiedChefsLoadingState) {
                  return const Center(child: LoadingWidget());
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chefList.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (chefList.length == index) {
                      if (state.isLastPage) {
                        return const NoItemWidget();
                      } else {
                        return const LoadingWidget();
                      }
                    }
                    ChefEntity chef = chefList[index];
                    return ChefItem(
                      chefEntity: chef,
                      isFollowed: true,
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
