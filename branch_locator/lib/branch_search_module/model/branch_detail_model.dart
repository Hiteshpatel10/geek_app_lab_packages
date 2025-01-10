class BranchDetailModel {
  BranchDetailModel({
    this.message,
    this.result,
    this.status,
  });

  BranchDetailModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(BranchDetail.fromJson(v));
      });
    }
    status = json['status'];
  }
  String? message;
  List<BranchDetail>? result;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class BranchDetail {
  BranchDetail({
    this.id,
    this.bankName,
    this.ifsc,
    this.branch,
    this.address,
    this.state,
    this.micr,
    this.contact,
    this.upi,
    this.neft,
    this.city,
    this.centre,
    this.district,
    this.rtgs,
    this.imps,
    this.swift,
    this.iso3166,
    this.createdAt,
    this.updatedAt,
  });

  BranchDetail.fromJson(dynamic json) {
    id = json['id'];
    bankName = json['bank'];
    ifsc = json['ifsc'];
    branch = json['branch'];
    address = json['address'];
    state = json['state'];
    micr = json['micr'];
    contact = json['contact'];
    upi = json['upi'];
    neft = json['neft'];
    city = json['city'];
    centre = json['centre'];
    district = json['district'];
    rtgs = json['rtgs'];
    imps = json['imps'];
    swift = json['swift'];
    iso3166 = json['iso3166'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? bankName;
  String? ifsc;
  String? branch;
  String? address;
  String? state;
  String? micr;
  String? contact;
  bool? upi;
  bool? neft;
  String? city;
  String? centre;
  String? district;
  bool? rtgs;
  bool? imps;
  String? swift;
  String? iso3166;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bank_name'] = bankName;
    map['ifsc'] = ifsc;
    map['branch'] = branch;
    map['address'] = address;
    map['state'] = state;
    map['micr'] = micr;
    map['contact'] = contact;
    map['upi'] = upi;
    map['neft'] = neft;
    map['city'] = city;
    map['centre'] = centre;
    map['district'] = district;
    map['rtgs'] = rtgs;
    map['imps'] = imps;
    map['swift'] = swift;
    map['iso3166'] = iso3166;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
