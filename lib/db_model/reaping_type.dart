////TRAINING TOPIC MODEL
class ReapingType {
  String? id;
  String? name;

  ReapingType({this.id, this.name});

  ReapingType.fromJson(Map<String, dynamic> json) {
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