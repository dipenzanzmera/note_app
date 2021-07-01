
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utils/DatabaseHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>HomePageState();
}

class HomePageState extends State<HomePage>
{

  var name,phone,password;
  Future<List> taskdata,searchResult;
  TextEditingController _search = TextEditingController();
  getData() async
  {
    setState(() {
      DatabaseHandler obj = new DatabaseHandler();
      taskdata = obj.get_all_task();
    });
  }
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        setState(() {
          DatabaseHandler obj = new DatabaseHandler();
          taskdata = obj.getdatabydate(selectedDate.toString().split(" ")[0]);
        });
      });
  }



  
  getuserdata () async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name=pref.getString("name").toString();
    phone=pref.getString("phone").toString();
    password=pref.getString("password").toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectDate(context);
        },
        child: const Icon(Icons.calendar_today_sharp),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(name.toString()[0].toUpperCase()),
              ),
              accountName: Text(name.toString().toUpperCase()),
            ),
            ListTile(
              title: Text("Add Task"),
              onTap: (){
                Navigator.of(context).pushNamed("AddNotes");
              },
            ),
            ListTile(
              title: Text("My Profile"),
              onTap: (){
                Navigator.of(context).pushNamed("ProfilePage");
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: ()async{
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setBool("isLogin", false);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("LoginPage");
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _search,
            ),
          ),
          RaisedButton(onPressed: () {
            setState(() {
              DatabaseHandler obj = new DatabaseHandler();
              taskdata = obj.getdatabyname(_search.text.toString());
            });
          },
          child: Text("Search"),
          ),
          Expanded(
            child: FutureBuilder(
                future: taskdata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Text("No Data Found!"),
                      );
                    }
                    else {
                      return RefreshIndicator(
                        onRefresh:(){
                          return Future.delayed(Duration(seconds: 1),(){
                            setState(() {
                              DatabaseHandler obj = new DatabaseHandler();
                              taskdata = obj.get_all_task();
                            });
                          });
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, position) {
                            // return Card(
                            //   child: ListTile(
                            //     contentPadding: EdgeInsets.all(5.0),
                            //     leading: Text(" "),
                            //     title:Text(snapshot.data[position].row[1].toString()),
                            //     // subtitle: Text(snapshot.data[position].row[5].toString()),
                            //     trailing: Text(snapshot.data[position].row[3].toString()),
                            //     onTap: (){
                            //       var id = snapshot.data[position].row[0].toString();
                            //       print("ID : "+id);
                            //     },
                            //   ),
                            // );
                            return Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration( //                    <-- BoxDecoration
                                border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                    )),
                              ),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                      snapshot.data[position].row[1].toString()),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[position].row[2].toString()),
                                      Text(snapshot.data[position].row[3].toString()),
                                    ],
                                  ),
                                  trailing: Wrap(
                                    spacing: -7, // space between two icons
                                    children:[
                                      IconButton(
                                        icon: new Icon(Icons.edit),
                                        onPressed: () async{
                                          var id = snapshot.data[position].row[0].toString();
                                          DatabaseHandler obj = new DatabaseHandler();
                                          Navigator.of(context).pushNamed("UpdateNotes",arguments: {"task_id":id});
                                          print(id);
                                        },
                                      ), // icon-1
                                      IconButton(
                                        icon: new Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () async{
                                          var id = snapshot.data[position].row[0].toString();
                                          DatabaseHandler obj = new DatabaseHandler();
                                          int result = await obj.deletetask(id);
                                          getData();
                                        },
                                      ), // icon-2
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

}