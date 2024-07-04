import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/presentation/blocs/user_notification/user_notification_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/common_heading.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:get_it/get_it.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  UserNotificationBloc userNotificationBloc =
      GetIt.instance<UserNotificationBloc>();
  late NotificationEntity notificationEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNotificationBloc.add(UpdateNotificationStatus(widget.notification));
    notificationEntity = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.notification.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: width * 0.5,
                  height: width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 1)
                      ],
                      image: DecorationImage(
                        image: NetworkImage(notificationEntity.imageUrl),
                        onError: (exception, stackTrace) =>
                            const AssetImage(PicturePath.emptyAvatarPngPath),
                      )),
                ),
              ),
              Row(
                children: [
                  CommonHeading(content: "${AppStrings.title.tr()}: "),
                  Text(
                    notificationEntity.title,
                    maxLines: 20,
                  )
                ],
              ),
              Row(
                children: [
                  CommonHeading(content: "${AppStrings.createdAt.tr()}: "),
                  Text(
                    formatDateTime(notificationEntity.createdAt),
                    maxLines: 2,
                  )
                ],
              ),
              Row(
                children: [
                  CommonHeading(content: "${AppStrings.content.tr()}: "),
                  Text(
                    notificationEntity.content,
                    maxLines: 100,
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {
                      userNotificationBloc
                          .add(DeleteNotification(notificationEntity));
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings.delete.tr()),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
