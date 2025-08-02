import 'dart:ffi';

////TRAINING TOPIC MODEL
class VisitInfo {
  String? id;
  int ? visitreason_id;
  String? season_id;
  String?visitwho;
  Bool ? is_farmer_group_visit;
  String? amcos_id;
  String? farmers;
  String? note;
  String? visit_date;
  Float ?latitude;
  Float ?longtude;




  VisitInfo({this.id,  this.visitreason_id, this.season_id,this.visitwho,this.is_farmer_group_visit, this.amcos_id, this.note, this.visit_date,this.latitude,this.longtude,this.farmers});

  VisitInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitreason_id = json['visitreason_id'];
    season_id = json['season_id'];
    visitwho = json['visitwho'];
    is_farmer_group_visit = json['is_farmer_group_visit'];
    amcos_id = json['amcos_id'];
    farmers = json['farmers'];
    note = json['note'];
    visit_date = json['visit_date'];
    latitude = json['latitude'];
    longtude = json['longtude'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json['id']=id;
    json['visitreason_id']=visitreason_id;
    json['season_id']=season_id;
    json['visitwho']=visitwho;
   json['is_farmer_group_visit']=is_farmer_group_visit;
    json['amcos_id']=amcos_id;
    json['note']=note;
    json['visit_date']=visit_date;
    json['latitude']=latitude;
    json['longtude']=longtude;
    json['farmers']=farmers;

    return json;
  }
}