

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
var datalist = ['TrainingTopic', 'TrainingDocument', 'VisitingReason','VisitingPlace','SeedbedType'
  ,'SeedVariety','SeedSource','SeedQuality','SiteProtection','WaterSource','WaterDelivery','IrrigationMethod','CpaProduct','PlotRidge',
  'FertilizerType','FertilizerApplicationMethod','BarnType','Furnace','Channel','Fuel','ReapingType','WorkingConditionItem'];


class SQLHelper{

  static Future<void> createTables(sql.Database database) async {
    for (var i = 0; i < datalist.length; i++) {
      await database.execute("""CREATE TABLE ${datalist[i]}(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        table_id TEXT NOT NULL,
        name TEXT NOT NULL,
       
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    }
    await database.execute("""CREATE TABLE season(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        name TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE amcos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        amcos_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE farmers(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        amcos_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE visit(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        amcos_id TEXT NOT NULL,
        reason_id TEXT NOT NULL,
        visitplace_id TEXT NOT NULL,
        note TEXT NOT NULL,
        farmers TEXT  NULL,
        visit_date TEXT NULL,
        longitude TEXT NOT NULL,
        latitude TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);


    await database.execute("""CREATE TABLE seedbed(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        seedbedtype_id TEXT NOT NULL,
        seedsource_id TEXT NOT NULL,
        seedvariety_id TEXT NOT NULL,
        seedquality_id TEXT NOT NULL,
        ha_potential TEXT NULL,
        longitude TEXT NOT NULL,
        latitude TEXT NOT NULL,
        quantity TEXT NULL,
        width TEXT NULL,
        length TEXT NULL,
        area TEXT NULL,
        date_fertilized TEXT NULL,
        date_sown TEXT NULL,
        date_reset TEXT NULL,
        date_hardened TEXT NULL,
        date_pulled TEXT NULL,
        date_distroyed TEXT NULL,
        note TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE seedbed_siteinfo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        watersource_id TEXT NOT NULL,
        waterdelivery_id TEXT NOT NULL,
        seedvariety_id TEXT NOT NULL,
        water_distance TEXT NOT NULL,
        site_protection TEXT NOT NULL,
        irrigation_method TEXT NULL,
        note TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE seedbed_cpa(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        cpaproduct_id TEXT NOT NULL,
        note TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE plot(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        seedvariety_id TEXT NOT NULL,
        note TEXT NOT NULL,
        plot_name TEXT NOT NULL,
        ownership TEXT NULL,
        hectares TEXT NULL,
        prepared_hectares TEXT NULL,
        is_soil_analysis_done INTEGER DEFAULT 0,
        is_irrigation_used INTEGER DEFAULT 0,
        date_of_first_rain TEXT NULL,
        date_of_base_fertilizer TEXT NULL,
        row_spacing TEXT NULL,
        plant_spacing TEXT NULL,
        recommended_plants TEXT NULL,
        planted_plants INTEGER DEFAULT 0,
        existing_plants INTEGER DEFAULT 0,
        date_planted TEXT NULL,
        date_replanted TEXT NULL,
        date_topping TEXT NULL,
        topping_height INTEGER DEFAULT 0,
        
        
        
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE plot_fertilizer(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        season_id TEXT NOT NULL,
        farmer_id TEXT NOT NULL,
        fertilizertype_id TEXT NOT NULL,
        applicationmethod_id TEXT NOT NULL,
        used_fertilizer_kg TEXT NOT NULL,
        fertilized_date TEXT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

static Future<sql.Database> db() async {
      return sql.openDatabase(
        'agrodata.db',
        version: 7,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        },
      );
    }


  static Future<void> deleteAll() async {
    final db = await SQLHelper.db();
    for (var i = 0; i < datalist.length; i++) {
      print('delete ${datalist[i]}');

      db.execute("delete from  ${datalist[i]}");
    }
    db.execute("delete from  season");
    db.execute("delete from  farmers");
    db.execute("delete from  amcos");
  }

  static Future<void> deleteObject(String? deleteWhat) async {
    final db = await SQLHelper.db();
    if(deleteWhat =='settings') for (var i = 0; i < datalist.length; i++) {
      print('delete ${datalist[i]}');

      db.execute("delete from  ${datalist[i]}");
    }
    if(deleteWhat =='season') db.execute("delete from  season");
    if(deleteWhat =='farmers')  db.execute("delete from  farmers");
    if(deleteWhat =='amcos') db.execute("delete from  amcos");
  }
////inhouse grades
static Future<int> addModeltoDatabase(String tableName,String name, String dataId) async {
  final db = await SQLHelper.db();
  int vr=0;
  //db.execute("delete from  ${tableName}");
  final getOB= await SQLHelper.getObjectInfoInfo(tableName,name.toString());
  print('onadding');
  print(getOB);

  if ( getOB.length <=0 ) {

    var data = {'name': name, 'table_id': dataId.toString()};
    if (tableName == 'season')  data = {'name': name, 'season_id': dataId.toString()};
  final id = await db.insert('${tableName}', data,
  conflictAlgorithm: sql.ConflictAlgorithm.replace);
  print(id);
  print('wapinmeadd');
  return id;
  }
  print('wapi');
  print(vr);
  return vr;

}


  static Future<int> addAmcostoDatabase(String tableName,String code,String name, String dataId) async {
    final db = await SQLHelper.db();
    int vr=0;
    //db.execute("delete from  ${tableName}");
    final getOB= await SQLHelper.getObjectInfoInfo(tableName,name.toString());
    print('onadding amcos');
    print(getOB);

    if ( getOB.length <=0 ) {

      var data = {'code': code,'name': name, 'amcos_id': dataId.toString()};
      final id = await db.insert('${tableName}', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print(id);
      print('wapinmeadd');
      return id;
    }
    if(getOB.length > 0) {return getOB[0]['id'];}

    print('wapi');
    print(vr);
    return vr;

  }


  static Future<int> addFarmerToDb(String tableName,String code,String name,String amcosId, String farmerId) async {
    final db = await SQLHelper.db();
    int vr=0;
    //db.execute("delete from  ${tableName}");
    final getOB= await SQLHelper.getObjectInfoInfobyCode(tableName,code.toString());
    print('onadding farmers');
    print(getOB);

    if ( getOB.length <=0 ) {

      var data = {'code': code,'name': name, 'amcos_id':amcosId,'farmer_id': farmerId.toString()};
      final id = await db.insert('${tableName}', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print(id);
      print('wapinmeadd');
      return id;
    }
    print('wapi');
    print(vr);
    return vr;

  }

static Future<List<Map<String, dynamic>>> getObjectInfoInfo(String tableName,String name) async {
      final db = await SQLHelper.db();
      return db.query('${tableName}',
          where: "name = ?", whereArgs: [name], limit: 1);
    }


  static Future<List<Map<String, dynamic>>> getObjectInfoInfobyCode(String tableName,String code) async {
    final db = await SQLHelper.db();
    return db.query('${tableName}',
        where: "code = ?", whereArgs: [code], limit: 1);
  }


  static Future<List<Map<String, dynamic>>> getVisitInfoByLike(String farmerCode) async {
    final db = await SQLHelper.db();
    return db.query('visit',
        where: "farmers LIKE  ?", whereArgs: ["%${farmerCode.toString()}%"],orderBy: "id DESC");
  }


  static Future<List<Map<String, dynamic>>> getObjectInfoInfobyTableId(String tableName,String tableId) async {
    final db = await SQLHelper.db();
    return db.query('${tableName}',
        where: "table_id = ?", whereArgs: [tableId], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getSettingData(String tableName) async {
    final db = await SQLHelper.db();
    var data= db.query('${tableName}', orderBy: "id DESC");
    print(data);
    print(tableName);
    return data;
  }

  static Future<List<Map<String, dynamic>>> getFarmerAmcosId(String ?amcosId) async {
    final db = await SQLHelper.db();
    return db.query('farmers',
        where: "amcos_id = ?", whereArgs: [amcosId]);
  }


  static Future<int> addFarmeToDb(String tableName,String code,String name,String amcosId, String farmerId) async {
    final db = await SQLHelper.db();
    int vr=0;
    //db.execute("delete from  ${tableName}");
    final getOB= await SQLHelper.getObjectInfoInfobyCode(tableName,code.toString());
    print('onadding farmers');
    print(getOB);

    if ( getOB.length <=0 ) {

      var data = {'code': code,'name': name, 'amcos_id':amcosId,'farmer_id': farmerId.toString()};
      final id = await db.insert('${tableName}', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print(id);
      print('wapinmeadd');
      return id;
    }
    print('wapi');
    print(vr);
    return vr;

  }

  static Future<int> addVisit(String amcos_id,String reason_id,String farmers,String note, String _visitPlaceId, String longitude,String latitude) async {
    final db = await SQLHelper.db();
    int vr=0;

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

      var data = {'amcos_id': amcos_id,'farmers': farmers, 'visit_date': formatted.toString(),'note':note,'visitplace_id':_visitPlaceId,'longitude':longitude,'latitude':latitude,'reason_id':reason_id};
      final id = await db.insert('visit', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print(id);
      print('');
      return id;

    print('wapi');
    print(vr);
    return vr;

  }
  static Future<int> updateVisitByMap( int visitId,Map<String, dynamic> data) async {
    final db = await SQLHelper.db();


    final result = await db.update('visit', data,
        where: "id = ?", whereArgs: [visitId]);
    return result;
  }
  static Future<int> addObjectByMap( String tableName,Map<String, dynamic> data) async {
    final db = await SQLHelper.db();


    final id = await db.insert('${tableName}', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String, dynamic>>> getVisitInfoWithId(int id) async {
    final db = await SQLHelper.db();
    return db.query('visit',
        where: "id = ?", whereArgs: [id], limit: 1);
  }
  static Future<List<Map<String, dynamic>>> getSeedBedByAppId(int id) async {
    final db = await SQLHelper.db();
    return db.query('seedbed',
        where: "id = ?", whereArgs: [id], limit: 1);
  }
  static Future<List<Map<String, dynamic>>> getSeedBedByAppWithRelationId(int id) async {
    final db = await SQLHelper.db();
    return  db.rawQuery('select SeedSourceSeedbedType.name as TypeName,SeedVariety.name as verietyName,seedbed.id as AppSeedBedId from seedbed join SeedVariety on seedvariety_id=SeedVariety.table_id inner join SeedbedType on SeedbedType.table_id=seedbedtype_id  inner join SeedSource on SeedSource.table_id=seedsource_id   where seedbed.id =${id} LIMIT 100');

    return db.query('seedbed',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getSeedBedByFarmerId(String farmerId) async {
    final db = await SQLHelper.db();
    return  db.rawQuery('select SeedbedType.name as TypeName,SeedVariety.name as verietyName,seedbed.id as AppSeedBedId from seedbed join SeedVariety on seedvariety_id=SeedVariety.table_id inner join SeedbedType on SeedbedType.table_id=seedbedtype_id   where farmer_id = "${farmerId}" LIMIT 100');
  }






}