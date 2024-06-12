import 'package:dio/dio.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/responses/base_response.dart';
import 'package:food_recipe_app/data/responses/notification_response.dart';

abstract class NotificationRemoteDataSource {
  Future<BaseResponse<List<AppNotificationResponse>>> getNotification(int page);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio _dio;
  final notificationEndpoint = '${Constant.baseUrl}/Notification';

  NotificationRemoteDataSourceImpl(this._dio);

  @override
  Future<BaseResponse<List<AppNotificationResponse>>> getNotification(
      int page) async {
    Response response = await _dio.get('$notificationEndpoint/$page');
    return BaseResponse.fromJson(
        response, AppNotificationResponse.fromJsonList);
  }
}
