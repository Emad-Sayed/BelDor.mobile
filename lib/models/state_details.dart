class StateDetails {
  int id;
  String nameAR;
  String nameEN;
  bool isSelected = false;

  StateDetails({this.id, this.nameAR, this.nameEN});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAR'] = this.nameAR;
    data['nameEN'] = this.nameEN;
    return data;
  }
}
