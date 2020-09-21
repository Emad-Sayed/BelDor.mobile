class LoginSuccessResponse {
  String token;
  List<String> roles;

  LoginSuccessResponse({this.token, this.roles});

  LoginSuccessResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }
}
