
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/utils/DatabaseHandler.dart';

class RegistrationPage extends StatefulWidget
{
  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<RegistrationPage>
{

  var _formkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  // TextEditingController _confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("Login",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.redAccent),),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Name",
                      hintText: "Enter Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)
                    ),
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "Please Enter Username";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Phone Number",
                      hintText: "Enter Phone Number",
                      border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_android_rounded)
                    ),
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "Please Enter Username";
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
                  SizedBox(height: 10.0),
                  // TextFormField(
                  //   controller: _confirmpassword,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     isDense: true,
                  //     labelText: "Confirm Password",
                  //     hintText: "Enter Confirm Password",
                  //     border: OutlineInputBorder(),
                  //       prefixIcon: Icon(Icons.lock)
                  //   ),
                  //   validator: (value)
                  //   {
                  //     if(value.isEmpty)
                  //     {
                  //       return "Please Enter Password";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  InkWell(
                    onTap: () async{
                      if(_formkey.currentState.validate())
                      {
                        var name = _name.text.toString();
                        var phone = _phone.text.toString();
                        var password = _password.text.toString();

                        DatabaseHandler obj = new DatabaseHandler();
                        int id = await obj.add_user(name, phone, password);
                        print("Record Inserted at : "+id.toString());
                        Navigator.of(context).pop();
                        // Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("LoginPage");

                      }
                      else
                        {
                          Fluttertoast.showToast(
                              msg: "Incorrect Phone or password!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("LoginPage");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: RichText(
                        text: TextSpan(
                          text: "Already Register ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Login",
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
    );
  }

}