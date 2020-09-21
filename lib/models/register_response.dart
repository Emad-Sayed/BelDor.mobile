class RegisterResponse {
  bool status;
  String errorAR;
  String errorEN;

  RegisterResponse({this.status, this.errorAR, this.errorEN});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorAR = json['error_AR'];
    errorEN = json['error_EN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error_AR'] = this.errorAR;
    data['error_EN'] = this.errorEN;
    return data;
  }
}
