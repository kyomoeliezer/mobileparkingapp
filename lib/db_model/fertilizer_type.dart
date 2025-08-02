////TRAINING TOPIC MODEL
class FertilizerType {
  String? id;
  String? name;

  FertilizerType({this.id, this.name});

  FertilizerType.fromJson(Map<String, dynamic> json) {
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