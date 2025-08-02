////TRAINING TOPIC MODEL
class YearModel {
  String? id;
  String? season_name;
  String? season_id;

  YearModel({this.id,this.season_id, this.season_name});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    season_name = json['season_name'];
    season_id = json['season_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['season_name'] = season_name;
    data['season_id']=season_id;

    return data;
  }
}