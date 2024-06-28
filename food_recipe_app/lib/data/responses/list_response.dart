class ListResponse<T> {
  List<T> data;
  int? status;
  String? message;
  ListResponse(this.data, this.status, this.message);
}
