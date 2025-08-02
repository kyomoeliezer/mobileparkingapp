////TRAINING TOPIC MODEL
class SeedQuality {
  String? id;
  String? name;

  SeedQuality({this.id, this.name});

  SeedQuality.fromJson(Map<String, dynamic> json) {
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