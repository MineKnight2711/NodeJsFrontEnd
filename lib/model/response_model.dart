class ResponseModel {
  bool success;
  dynamic data;

  ResponseModel({required this.success, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataJson = <String, dynamic>{};
    dataJson['success'] = success;
    dataJson['data'] = data;
    return dataJson;
  }
}
