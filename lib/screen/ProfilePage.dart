

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>ProfilePageState();
}


class ProfilePageState extends State<ProfilePage>
{

  var name,phone,password;
  getuserdata () async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name=pref.getString("name").toString();
    phone=pref.getString("phone").toString();
    password=pref.getString("password").toString();
    print(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.teal,
        title: Text("User Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Column(
            children: [
              Container(
                height: 269,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius:60.0,
                        child: Text(name.toString()[0].toUpperCase(),
                          style:TextStyle(
                            fontSize: 30.0,
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(name.toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20.0),),

                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.red,
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    child:ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person,color: Colors.redAccent,),
                          title: Text(phone.toString()),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                // color: Colors.red,
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    child:ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.lock,color: Colors.redAccent,),
                          title: Text(password.toString()),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}