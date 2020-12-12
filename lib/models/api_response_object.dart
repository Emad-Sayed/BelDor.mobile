import 'package:bel_dor/models/ticket_details.dart';

class ApiResponseObject<T> {
  bool status;
  String errorAR;
  String errorEN;
  int pageSize;
  int pageNumber;
  int pagesTotalNumber;
  int pagesTotalRows;
  T data;

  ApiResponseObject(
      {this.status,
      this.errorAR,
      this.errorEN,
      this.pageSize,
      this.pageNumber,
      this.pagesTotalNumber,
      this.pagesTotalRows,
      this.data});

  ApiResponseObject.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorAR = json['error_AR'];
    errorEN = json['error_EN'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    pagesTotalNumber = json['pagesTotalNumber'];
    pagesTotalRows = json['pagesTotalRows'];
    if (json['data'] != null) {
      // add new generic class
      if (T == TicketDetails) {
        data = TicketDetails().fromJson(json['data']);
      }
    }
  }
}
