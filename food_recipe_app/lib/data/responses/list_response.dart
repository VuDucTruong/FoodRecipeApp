import 'package:food_recipe_app/data/responses/base_response.dart';

class ListResponse<T> {
  List<T> data;
  int? status;
  String? message;
  ListResponse(this.data, this.status, this.message);
}
