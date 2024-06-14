class OrderModel {
  String? id;
  String? billNo;
  String? orderNumber;
  String? orderDeliveryDatetime;
  String? deliveryType;
  String? orderStatus;
  String? createdDate;
  String? amount;
  String? deliveryId;
  String? orderMode;
  String? orderStatusDisplayText;
  String? orderStatusDisplay;

  OrderModel(
      {this.id,
        this.billNo,
        this.orderNumber,
        this.orderDeliveryDatetime,
        this.deliveryType,
        this.orderStatus,
        this.createdDate,
        this.amount,
        this.deliveryId,
        this.orderMode,
        this.orderStatusDisplayText,
        this.orderStatusDisplay});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNo = json['bill_no'];
    orderNumber = json['order_number'];
    orderDeliveryDatetime = json['order_delivery_datetime'];
    deliveryType = json['delivery_type'];
    orderStatus = json['order_status'];
    createdDate = json['created_date'];
    amount = json['amount'].toString();
    deliveryId = json['delivery_id'].toString();
    orderMode = json['order_mode'];
    orderStatusDisplayText = json['order_status_display_text'];
    orderStatusDisplay = json['order_status_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_no'] = this.billNo;
    data['order_number'] = this.orderNumber;
    data['order_delivery_datetime'] = this.orderDeliveryDatetime;
    data['delivery_type'] = this.deliveryType;
    data['order_status'] = this.orderStatus;
    data['created_date'] = this.createdDate;
    data['amount'] = this.amount;
    data['delivery_id'] = this.deliveryId;
    data['order_mode'] = this.orderMode;
    data['order_status_display_text'] = this.orderStatusDisplayText;
    data['order_status_display'] = this.orderStatusDisplay;
    return data;
  }
}
