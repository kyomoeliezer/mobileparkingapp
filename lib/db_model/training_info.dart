import 'dart:ffi';

////TRAINING TOPIC MODEL
class TrainingInfo {
  String? id;
  int ? visitinfo_id;
  String? trainingtopic_id;
  String? note;
  String ? amcos_id;
  String ? farmers;




  TrainingInfo({this.id,  this.visitinfo_id, this.trainingtopic_id,this.note, this.amcos_id, this.farmers});

  TrainingInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitinfo_id = json['visitinfo_id'];
    trainingtopic_id = json['trainingtopic_id'];
    note = json['note'];
    amcos_id = json['amcos_id'];
    amcos_id = json['amcos_id'];
    farmers = json['farmers'];
    note = json['note'];
    farmers = json['farmers'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json['id']=id;
    json['visitinfo_id']=visitinfo_id;
    json['trainingtopic_id']=trainingtopic_id;
    json['note']=note;
   json['amcos_id']=amcos_id;
    json['amcos_id']=amcos_id;
    json['note']=note;
    json['farmers']=farmers;


    return json;
  }
}