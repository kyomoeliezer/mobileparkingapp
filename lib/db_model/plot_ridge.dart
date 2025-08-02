////TRAINING TOPIC MODEL
class PlotRidge {
  String? id;
  String? name;

  PlotRidge({this.id, this.name});

  PlotRidge.fromJson(Map<String, dynamic> json) {
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