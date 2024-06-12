class SendOtpModel {
  String? statusCode;
  String? statusMessage;
  String? datetime;
  Data? data;

  SendOtpModel({this.statusCode, this.statusMessage, this.datetime, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    datetime = json['datetime'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['datetime'] = this.datetime;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? mobile;
  ReferralData? referralData;

  Data({this.mobile, this.referralData});

  Data.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    referralData = json['referral_data'] != null
        ? new ReferralData.fromJson(json['referral_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    if (this.referralData != null) {
      data['referral_data'] = this.referralData!.toJson();
    }
    return data;
  }
}

class ReferralData {
  ReferralData();

  ReferralData.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
