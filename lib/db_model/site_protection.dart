////TRAINING TOPIC MODEL
class SiteProtection {
  String? id;
  String? name;

  SiteProtection({this.id, this.name});

  SiteProtection.fromJson(Map<String, dynamic> json) {
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