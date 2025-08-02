////TRAINING TOPIC MODEL
class SeedVariety {
  String? id;
  String? name;

  SeedVariety({this.id, this.name});

  SeedVariety.fromJson(Map<String, dynamic> json) {
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