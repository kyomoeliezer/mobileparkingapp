////TRAINING TOPIC MODEL
class Furnace {
  String? id;
  String? name;

  Furnace({this.id, this.name});

  Furnace.fromJson(Map<String, dynamic> json) {
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