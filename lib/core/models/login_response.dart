class LoginResponse {
  bool success;
  String message;
  LoginData data;

  LoginResponse({this.success, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class LoginData {
  String name;
  String phoneNumber;
  String notificationToken;
  String deviceId;
  String emailId;
  bool is_verified;

  LoginData(
      {this.name,
        this.phoneNumber,
        this.notificationToken,
        this.deviceId,
        this.emailId,
        this.is_verified});

  LoginData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    notificationToken = json['notification_token'];
    deviceId = json['device_id'];
    emailId = json['email_id'];
    is_verified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['notification_token'] = this.notificationToken;
    data['device_id'] = this.deviceId;
    data['email_id'] = this.emailId;
    data['is_verified'] = this.is_verified;
    return data;
  }
}
