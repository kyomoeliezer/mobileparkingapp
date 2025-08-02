////TRAINING TOPIC MODEL
class VisitingReason {
  String? id;
  String? name;

  VisitingReason({this.id, this.name});

  VisitingReason.fromJson(Map<String, dynamic> json) {
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