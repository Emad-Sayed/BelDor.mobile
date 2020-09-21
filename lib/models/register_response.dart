class RegisterResponse {
  bool status;
  String errorAR;
  String errorEN;
  int pageSize;
  int pageNumber;
  int pagesTotalNumber;
  int pagesTotalRows;
  String data;

  RegisterResponse(
      {this.status,
      this.errorAR,
      this.errorEN,
      this.pageSize,
      this.pageNumber,
      this.pagesTotalNumber,
      this.pagesTotalRows,
      this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorAR = json['error_AR'];
    errorEN = json['error_EN'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    pagesTotalNumber = json['pagesTotalNumber'];
    pagesTotalRows = json['pagesTotalRows'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error_AR'] = this.errorAR;
    data['error_EN'] = this.errorEN;
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    data['pagesTotalNumber'] = this.pagesTotalNumber;
    data['pagesTotalRows'] = this.pagesTotalRows;
    data['data'] = this.data;
    return data;
  }
}
