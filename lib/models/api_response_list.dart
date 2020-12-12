import 'package:bel_dor/models/branch_details.dart';
import 'package:bel_dor/models/department_response.dart';
import 'package:bel_dor/models/departments.dart';
import 'package:bel_dor/models/ticket_details.dart';

class ApiResponseList<T> {
  bool status;
  String errorAR;
  String errorEN;
  int pageSize;
  int pageNumber;
  int pagesTotalNumber;
  int pagesTotalRows;
  List<T> data;

  ApiResponseList(
      {this.status,
      this.errorAR,
      this.errorEN,
      this.pageSize,
      this.pageNumber,
      this.pagesTotalNumber,
      this.pagesTotalRows,
      this.data});

  ApiResponseList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorAR = json['error_AR'];
    errorEN = json['error_EN'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    pagesTotalNumber = json['pagesTotalNumber'];
    pagesTotalRows = json['pagesTotalRows'];
    if (json['data'] != null) {
      data = new List<T>();
      // add new generic class
      if (T == TicketDetails) {
        json['data'].forEach((v) {
          data.add(TicketDetails().fromJson(v));
        });
      } else if (T == BranchDetails) {
        json['data'].forEach((v) {
          data.add(BranchDetails().fromJson(v));
        });
      } else if (T == DepartmentResponse) {
        json['data'].forEach((v) {
          data.add(DepartmentResponse().fromJson(v));
        });
      } else if (T == Departments) {
        json['data'].forEach((v) {
          data.add(Departments().fromJson(v));
        });
      }
    }
  }
}
