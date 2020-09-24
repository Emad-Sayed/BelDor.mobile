class DepartmentDetails {
  int departementId;
  String departementNameAR;
  String departementNameEN;

  DepartmentDetails(
      {this.departementId, this.departementNameAR, this.departementNameEN});

  DepartmentDetails.fromJson(Map<String, dynamic> json) {
    departementId = json['departementId'];
    departementNameAR = json['departementNameAR'];
    departementNameEN = json['departementNameEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departementId'] = this.departementId;
    data['departementNameAR'] = this.departementNameAR;
    data['departementNameEN'] = this.departementNameEN;
    return data;
  }
}
