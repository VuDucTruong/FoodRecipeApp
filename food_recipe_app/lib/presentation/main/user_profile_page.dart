import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/presentation/blocs/user_notification/user_notification_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/notification_item.dart';
import 'package:food_recipe_app/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe_app/presentation/edit_profile/bloc/edit_profile_bloc.dart';

import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_description.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_introduction.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_social_status.dart';

import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

import '../resources/font_manager.dart';
import '../resources/route_management.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ChefEntity currentUser;

  final UserNotificationBloc _userNotificationBloc =
      GetIt.instance<UserNotificationBloc>();
  List<NotificationEntity> notificationList = [];
  ScrollController scrollController = ScrollController();
  int page = 0;

  @override
  void initState() {
    super.initState();
    notificationList = [];
    currentUser = GetIt.instance<BackgroundDataManager>().convertToChefEntity();
    _userNotificationBloc.add(LoadUserNotification(page));
    scrollController.addListener(continueLoading);
  }

  void continueLoading() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (_userNotificationBloc.state.isLastPage) {
        return;
      }
      //await Future.delayed(Duration(seconds: 1));
      _userNotificationBloc.add(LoadUserNotification(++page));
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(continueLoading);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.yourProfile.tr(),
                  style: getBoldStyle(
                      color: ColorManager.secondaryColor,
                      fontSize: FontSize.s20),
                ),
              ],
            ),
            BlocBuilder<EditProfileBloc, EditProfileState>(
              bloc: GetIt.instance<EditProfileBloc>(),
              builder: (context, state) {
                if (state is EditProfileSubmitSuccess) {
                  currentUser = GetIt.instance<BackgroundDataManager>()
                      .convertToChefEntity();
                }
                return Column(
                  children: [
                    UserIntroduction(
                      entity: currentUser,
                    ),
                    UserDescription(
                      entity: currentUser,
                    ),
                    UserSocialStatus(
                      entity: currentUser,
                    ),
                  ],
                );
              },
            ),
            Center(
              child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.editProfileRoute);
                      },
                      child: Text(AppStrings.editProfile.tr())),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: ColorManager.blueColor),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.followerListRoute);
                      },
                      child: Text(AppStrings.seeAllFollowers.tr())),
                ],
              ),
            ),
            const Divider(
              color: Colors.black26,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.myNotifications.tr(),
                style: getSemiBoldStyle(fontSize: 16),
              ),
            ),
            BlocConsumer<UserNotificationBloc, UserNotificationState>(
              bloc: _userNotificationBloc,
              listener: (context, state) {
                if (state is UserNotificationErrorState) {
                  showAnimatedDialog1(context,
                      AppErrorDialog(content: state.failure.toString()));
                }
                if (state is UserNotificationLoadedState) {
                  if (state.notificationList.length < 10 && !state.isLastPage) {
                    _userNotificationBloc.add(LoadUserNotification(++page));
                  }
                }
              },
              builder: (context, state) {
                if (state is UserNotificationLoadingState) {
                  return const LoadingWidget();
                }
                if (state is UserNotificationUpdateSuccess) {
                  int index = notificationList.indexOf(state.notification);
                  if (index != -1) {
                    notificationList[index] = state.notification..isRead = true;
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notificationList.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= notificationList.length) {
                        if (state.isLastPage) {
                          return const NoItemWidget();
                        } else {
                          return const LoadingWidget();
                        }
                      }
                      return NotificationItem(
                          notification: notificationList[index]);
                    },
                  );
                }
                if (state is UserNotificationDeleteSuccess) {
                  notificationList.remove(state.notification);
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notificationList.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= notificationList.length) {
                        if (state.isLastPage) {
                          return const NoItemWidget();
                        } else {
                          return const LoadingWidget();
                        }
                      }
                      return NotificationItem(
                          notification: notificationList[index]);
                    },
                  );
                }
                if (state is UserNotificationLoadedState) {
                  notificationList.addAll(state.notificationList);
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notificationList.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= notificationList.length) {
                        if (state.isLastPage) {
                          return const NoItemWidget();
                        } else {
                          return const LoadingWidget();
                        }
                      }
                      return NotificationItem(
                          notification: notificationList[index]);
                    },
                  );
                }
                if (state is UserNotificationErrorState) {
                  return Center(
                    child: ErrorText(
                      failure: state.failure,
                    ),
                  );
                }
                return const NoItemWidget();
              },
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
