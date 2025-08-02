import 'dart:ffi';

////TRAINING TOPIC MODEL
class ReadingDocumentGiven {
  String? id;
  int ? visitinfo_id;
  String? document_id;
  String ? amcos_id;
  String ? farmers;




  ReadingDocumentGiven({this.id,  this.visitinfo_id, this.document_id, this.amcos_id, this.farmers});

  ReadingDocumentGiven.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitinfo_id = json['visitinfo_id'];
    document_id = json['document_id'];
    amcos_id = json['amcos_id'];
    farmers = json['farmers'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    json['id']=id;
    json['visitinfo_id']=visitinfo_id;
    json['document_id']=document_id;
   json['amcos_id']=amcos_id;
    json['farmers']=farmers;
    

    return json;
  }
}