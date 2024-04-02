// ignore_for_file: prefer_collection_literals, unnecessary_this

class OrderResponse {
  String? address;
  String? status;
  int? orderID;
  String? orderDate;

  OrderResponse({this.address, this.status, this.orderID, this.orderDate});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    status = json['status'];
    orderID = json['orderID'];
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['status'] = this.status;
    data['orderID'] = this.orderID;
    data['orderDate'] = this.orderDate;
    return data;
  }
}
