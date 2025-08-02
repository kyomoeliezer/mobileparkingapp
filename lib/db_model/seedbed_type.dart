////TRAINING TOPIC MODEL
class SeedbedType {
  String? id;
  String? name;

  SeedbedType({this.id, this.name});

  SeedbedType.fromJson(Map<String, dynamic> json) {
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