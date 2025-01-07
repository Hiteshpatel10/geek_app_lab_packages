class BankHierarchyModel {
  BankHierarchyModel({
    this.message,
    this.result,
    this.status,
  });

  BankHierarchyModel.fromJson(dynamic json) {
    print("json----------- ${json['result']}");

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
    this.banks,
    this.branch,
    this.districts,
    this.states,
  });

  Result.fromJson(dynamic json) {

    if (json['banks'] != null) {

      banks = [];
      json['banks'].forEach((v) {
        banks?.add(v);
      });
    }
    if (json['branch'] != null) {
      branch = [];
      json['branch'].forEach((v) {
        branch?.add(v);
      });
    }
    if (json['districts'] != null) {
      districts = [];
      json['districts'].forEach((v) {
        districts?.add(v);
      });
    }
    if (json['states'] != null) {
      states = [];
      json['states'].forEach((v) {
        states?.add(v);
      });
    }
  }
  List<String>? banks;
  List<String>? branch;
  List<String>? districts;
  List<String>? states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banks'] = banks;
    map['branch'] = branch;
    map['districts'] = districts;
    map['states'] = states;
    return map;
  }
}
