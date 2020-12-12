class TicketDetails {
  int id;
  String createTime;
  int ticketNumber;
  int visitorId;
  String visitorName;
  int statusId;
  String statusNameAR;
  String statusNameEN;
  int branchId;
  String branchNameAR;
  String branchNameEN;
  int departementId;
  String departementNameAR;
  String departementNameEN;
  int branchDepartementId;
  int currentNumber;
  String employeeName;
  String information;

  TicketDetails(
      {this.id,
      this.createTime,
      this.ticketNumber,
      this.visitorId,
      this.visitorName,
      this.statusId,
      this.statusNameAR,
      this.statusNameEN,
      this.branchId,
      this.branchNameAR,
      this.branchNameEN,
      this.departementId,
      this.departementNameAR,
      this.departementNameEN,
      this.branchDepartementId,
      this.currentNumber,
      this.employeeName,
      this.information});

  fromJson(Map<String, dynamic> json) {
    return TicketDetails(
        id: json['id'],
        createTime: json['createTime'],
        ticketNumber: json['ticketNumber'],
        visitorId: json['visitorId'],
        visitorName: json['visitorName'],
        statusId: json['statusId'],
        statusNameAR: json['statusNameAR'],
        statusNameEN: json['statusNameEN'],
        branchId: json['branchId'],
        branchNameAR: json['branchNameAR'],
        branchNameEN: json['branchNameEN'],
        departementId: json['departementId'],
        departementNameAR: json['departementNameAR'],
        departementNameEN: json['departementNameEN'],
        branchDepartementId: json['branchDepartementId'],
        currentNumber: json['currentNumber'],
        employeeName: json['employeeName'],
        information: json['information']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['ticketNumber'] = this.ticketNumber;
    data['visitorId'] = this.visitorId;
    data['visitorName'] = this.visitorName;
    data['statusId'] = this.statusId;
    data['statusNameAR'] = this.statusNameAR;
    data['statusNameEN'] = this.statusNameEN;
    data['branchId'] = this.branchId;
    data['branchNameAR'] = this.branchNameAR;
    data['branchNameEN'] = this.branchNameEN;
    data['departementId'] = this.departementId;
    data['departementNameAR'] = this.departementNameAR;
    data['departementNameEN'] = this.departementNameEN;
    data['branchDepartementId'] = this.branchDepartementId;
    data['currentNumber'] = this.currentNumber;
    data['employeeName'] = this.employeeName;
    data['information'] = this.information;
    return data;
  }
}
