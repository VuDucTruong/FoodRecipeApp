import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/object/user_search_object.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/list_chef_page/chef_item.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';

class ListChefPage extends StatefulWidget {
  const ListChefPage({super.key, this.search = ''});
  final String search;
  @override
  _ListChefPageState createState() {
    return _ListChefPageState();
  }
}

class _ListChefPageState extends State<ListChefPage> {
  ScrollController scrollController = ScrollController();
  VerifiedChefsBloc verifiedChefsBloc = GetIt.instance<VerifiedChefsBloc>();
  List<ChefEntity> chefList = [];
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  @override
  void initState() {
    super.initState();
    verifiedChefsBloc.add(SearchChefs(UserSearchObject(widget.search)));
    scrollController.addListener(() async {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (verifiedChefsBloc.state.isLastPage) {
          return;
        }
        //await Future.delayed(Duration(seconds: 1));
        verifiedChefsBloc.add(SearchChefs(UserSearchObject(widget.search,
            page: (chefList.length ~/ 10) + 1)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reload() {
    resetData();
    verifiedChefsBloc.add(SearchChefs(UserSearchObject(widget.search)));
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
          AppStrings.verifiedChefs.tr(),
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
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
                      isFollowed: backgroundUser.followingIds.contains(chef.id),
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
