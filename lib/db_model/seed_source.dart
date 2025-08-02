////TRAINING TOPIC MODEL
class SeedSource {
  String? id;
  String? name;

  SeedSource({this.id, this.name});

  SeedSource.fromJson(Map<String, dynamic> json) {
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