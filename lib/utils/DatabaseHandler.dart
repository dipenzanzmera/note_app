import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler
{

  Database db;

  Future<Database> create_db() async
  {
    if(db!=null)
    {
      return db;
    }
    else
    {
      Directory dir=await getApplicationDocumentsDirectory();
      String path =join(dir.path,"employee_db");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
  }

  // ignore: non_constant_identifier_names
  create_table(Database db,int version)
  {
    db.execute("create table userstbl (user_id integer primary key autoincrement,name text,phone text,password text)");
    db.execute("create table tasktbl (task_id integer primary key autoincrement,task_name text,description text,start_date text,user_id integer)");
    print("Table Created");
  }

  Future<int> get_login(phone,password) async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from userstbl where phone=? and password=?",[phone,password]);
    return data.toList().length;
  }

  Future<List> get_login_data(phone,password) async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from userstbl where phone=? and password=?",[phone,password]);
    return data.toList();
  }

  Future<int> add_notes(title,description,date) async
  {
    var db = await create_db();
    int id = await db.rawInsert("insert into tasktbl (task_name,description,start_date) values (?,?,?)",[title,description,date]);
    return id;
  }

  Future<int> add_user(name,phone,password) async
  {
    var db = await create_db();
    int id = await db.rawInsert("insert into userstbl (name,phone,password) values (?,?,?)",[name,phone,password]);
    return id;
  }

  Future<List> get_all_task() async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from tasktbl");
    return data.toList();
  }

  Future<int> deletetask(taskid) async
  {
    var db = await create_db();
    int id = await db.rawInsert("delete from tasktbl where task_id=?",[taskid]);
    return id;
  }
  Future<List> get_task_byid(task_id) async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from tasktbl where task_id=?",[task_id]);
    return data.toList();
  }

  Future<List> getdatabydate(date) async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from tasktbl where start_date=?",[date]);
    return data.toList();
  }
  Future<List> getdatabyname(name) async
  {
    var db=await create_db();
    var data = await db.rawQuery("select * from tasktbl where task_name like '%"+name+"%'");
    return data.toList();
  }

  Future<int> update_task(taskid,title,description,date) async
  {
    var db = await create_db();
    int id = await db.rawInsert("update tasktbl set task_name=?,description=?,start_date=? where task_id=?",[title,description,date,taskid]);
    return id;
  }
}