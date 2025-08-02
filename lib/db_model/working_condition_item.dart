////TRAINING TOPIC MODEL
class WorkingConditionItem {
  String? id;
  String? name;

  WorkingConditionItem({this.id, this.name});

  WorkingConditionItem.fromJson(Map<String, dynamic> json) {
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