
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/utils/DatabaseHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>LoginPageState();
}

class LoginPageState extends State<LoginPage>
{
  var _formkey = GlobalKey<FormState>();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<List> olddata;

  chkLogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("isLogin"))
    {
      if(prefs.getBool("isLogin")==true)
      {
        setState(() {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed("HomePage");
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/logo.jpg",height: 200.0,width: 200.0,),
                    // Text("Login",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.redAccent),),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Phone Number",
                        hintText: "Enter Phone Number",
                        border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone_android_outlined)
                      ),
                      validator: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Please Enter Phone Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Password",
                        hintText: "Enter Password",
                        border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock)
                      ),
                      validator: (value)
                      {
                        if(value.isEmpty)
                        {
                          return "Please Enter Password";
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () async{
                        if(_formkey.currentState.validate())
                        {

                          var phone = _phone.text.toString();
                          var password = _password.text.toString();

                          DatabaseHandler obj = new DatabaseHandler();
                          int result = await obj.get_login(phone, password);
                          if(result>=0)
                            {
                               olddata = obj.get_login_data(phone,password);
                               olddata.then((value) async {
                                 print(value);
                                var name = value[0]["name"].toString();
                                var phone= value[0]["phone"].toString();
                                var password = value[0]["password"].toString();
                                // print(name);

                                 SharedPreferences pref = await SharedPreferences.getInstance();
                                 pref.setBool("isLogin", true);
                                 pref.setString("name", name);
                                 pref.setString("phone", phone);
                                 pref.setString("password", password);
                                 // Navigator.of(context).pop();
                                 Navigator.of(context).pushNamed("HomePage");
                               });
                            }
                            else
                            {
                              Fluttertoast.showToast(
                                  msg: "Incorrect username or password!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }


                        // print("username :" + uname);
                        // print("password :" + pwd);

                      },
                      child: Container(
                        margin: EdgeInsets.only(top:10.0),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed("RegistrationPage");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Create New Account",
                                style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}