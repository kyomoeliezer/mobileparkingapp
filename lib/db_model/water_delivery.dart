////TRAINING TOPIC MODEL
class WaterDelivery {
  String? id;
  String? name;

  WaterDelivery({this.id, this.name});

  WaterDelivery.fromJson(Map<String, dynamic> json) {
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