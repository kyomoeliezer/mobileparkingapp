////TRAINING TOPIC MODEL
class CpaProduct {
  String? id;
  String? name;

  CpaProduct({this.id, this.name});

  CpaProduct.fromJson(Map<String, dynamic> json) {
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