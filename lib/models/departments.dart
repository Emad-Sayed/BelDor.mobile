class Departments {
  int id;
  String nameAR;
  String nameEN;
  int createdyId;
  String createdName;
  bool isSelected = false;

  Departments(
      {this.id, this.nameAR, this.nameEN, this.createdyId, this.createdName});

  fromJson(Map<String, dynamic> json) {
    return Departments(
      id: json['id'],
      nameAR: json['nameAR'],
      nameEN: json['nameEN'],
      createdyId: json['createdyId'],
      createdName: json['createdName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAR'] = this.nameAR;
    data['nameEN'] = this.nameEN;
    data['createdyId'] = this.createdyId;
    data['createdName'] = this.createdName;
    return data;
  }
}
