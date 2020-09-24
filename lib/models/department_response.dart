import 'package:bel_dor/models/deparment_details.dart';

class DepartmentResponse {
  int branchId;
  String branchAR;
  String branchEN;
  List<DepartmentDetails> departements;

  DepartmentResponse(
      {this.branchId, this.branchAR, this.branchEN, this.departements});

  fromJson(Map<String, dynamic> json) {
    var deps = new List<DepartmentDetails>();
    if (json['departements'] != null) {
      json['departements'].forEach((v) {
        deps.add(new DepartmentDetails.fromJson(v));
      });
    }
    return DepartmentResponse(
        branchId: json['branchId'],
        branchAR: json['branchAR'],
        branchEN: json['branchEN'],
        departements: deps);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this.branchId;
    data['branchAR'] = this.branchAR;
    data['branchEN'] = this.branchEN;
    if (this.departements != null) {
      data['departements'] = this.departements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
