////TRAINING TOPIC MODEL
class FarmerModel {
  String? id;
  String?amcos_id;
  String?farmer_id;
  String? code;
  String? name;

  FarmerModel({this.id, this.name,this.amcos_id,this.farmer_id,this.code});

  FarmerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amcos_id = json['amcos_id'];
    farmer_id = json['farmer_id'];
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amcos_id']=amcos_id;
    data['farmer_id']=farmer_id;
    data['code']=code;
    return data;
  }
}


class AmcosModel {
  String? id;
  String?amcos_id;
  String? code;
  String? name;


  AmcosModel({this.id, this.name,this.amcos_id,this.code});

  AmcosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amcos_id = json['amcos_id'];
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amcos_id']=amcos_id;
    data['code']=code;
    return data;
  }


}
