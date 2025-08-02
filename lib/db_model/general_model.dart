////TRAINING TOPIC MODEL
class GeneralModel {
  int? id;
  String? name;


  GeneralModel({this.id, this.name});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}