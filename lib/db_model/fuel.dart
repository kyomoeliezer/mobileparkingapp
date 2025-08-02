////TRAINING TOPIC MODEL
class Fuel {
  String? id;
  String? name;

  Fuel({this.id, this.name});

  Fuel.fromJson(Map<String, dynamic> json) {
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