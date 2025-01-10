class PostOfficeModel {
  PostOfficeModel({
      this.message, 
      this.result, 
      this.status,});

  PostOfficeModel.fromJson(dynamic json) {
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }
  String? message;
  Result? result;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

class Result {
  Result({
      this.id, 
      this.officeName, 
      this.pincode, 
      this.officeType, 
      this.deliveryStatus, 
      this.divisionName, 
      this.regionName, 
      this.circleName, 
      this.taluk, 
      this.districtName, 
      this.stateName, 
      this.telephone, 
      this.relatedSubOffice, 
      this.relatedHeadOffice,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    officeName = json['office_name'];
    pincode = json['pincode'];
    officeType = json['office_type'];
    deliveryStatus = json['delivery_status'];
    divisionName = json['division_name'];
    regionName = json['region_name'];
    circleName = json['circle_name'];
    taluk = json['taluk'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    telephone = json['telephone'];
    relatedSubOffice = json['related_sub_office'];
    relatedHeadOffice = json['related_head_office'];
  }
  num? id;
  String? officeName;
  String? pincode;
  String? officeType;
  String? deliveryStatus;
  String? divisionName;
  String? regionName;
  String? circleName;
  String? taluk;
  String? districtName;
  String? stateName;
  String? telephone;
  String? relatedSubOffice;
  String? relatedHeadOffice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_name'] = officeName;
    map['pincode'] = pincode;
    map['office_type'] = officeType;
    map['delivery_status'] = deliveryStatus;
    map['division_name'] = divisionName;
    map['region_name'] = regionName;
    map['circle_name'] = circleName;
    map['taluk'] = taluk;
    map['district_name'] = districtName;
    map['state_name'] = stateName;
    map['telephone'] = telephone;
    map['related_sub_office'] = relatedSubOffice;
    map['related_head_office'] = relatedHeadOffice;
    return map;
  }

}