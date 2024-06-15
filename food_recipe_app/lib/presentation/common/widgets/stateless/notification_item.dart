import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:food_recipe_app/presentation/blocs/user_notification/user_notification_bloc.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({super.key, required this.notification});
  NotificationEntity notification;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.notificationDetailRoute,
            arguments: notification);
      },
      child: Card(
        color: notification.isRead
            ? ColorManager.greyColor
            : ColorManager.whiteOrangeColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                width: 100,
                height: 100,
                notification.imageUrl,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: getSemiBoldStyle(
                          fontSize: 16, color: ColorManager.darkBlueColor),
                    ),
                    Text(
                      maxLines: 2,
                      notification.content,
                      style: getRegularStyle()
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        GetIt.instance<UserNotificationBloc>()
                            .add(DeleteNotification(notification));
                      },
                      child: const Icon(Icons.delete_forever_outlined)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      formatDateTime(notification.createdAt),
                      style: getMediumStyle(fontSize: 14),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
