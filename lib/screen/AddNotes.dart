
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utils/DatabaseHandler.dart';

class AddNotes extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => AddNotesState();
}

class AddNotesState extends State<AddNotes>
{

  var _formkey= GlobalKey<FormState>();
  TextEditingController _taskname = TextEditingController();
  TextEditingController _description= TextEditingController();
  TextEditingController _startdate=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key:_formkey,
            child: Column(
              children: [
                // Image.network("https://i.pinimg.com/originals/33/b8/69/33b869f90619e81763dbf1fccc896d8d.jpg", height: 150),
                // SizedBox(height: 5),
                TextFormField(
                  controller: _taskname,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    labelText: "Task Title",
                    hintText: "Enter task",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _description,
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    labelText: "Task Description",
                    hintText: "Enter Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                // TextFormField(
                //   controller: _startdate,
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: Colors.white,
                //     isDense: true,
                //     labelText: "Date",
                //     hintText: "Enter Start Date",
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                DateTimePicker(
                  controller: _startdate,
                  type: DateTimePickerType.date,
                  dateMask: 'dd-MMM-yyyy',
                  // initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  // timeLabelText: "Hour",
                  // selectableDayPredicate: (date) {
                  //   // Disable weekend days to select from the calendar
                  //   if (date.weekday == 6 || date.weekday == 7) {
                  //     return false;
                  //   }
                  //
                  //   return true;
                  // },
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                InkWell(
                  onTap: () async {
                    var tasktitle = _taskname.text.toString();
                    var taskdesc = _description.text.toString();
                    var date = _startdate.text.toString();


                    DatabaseHandler obj = new DatabaseHandler();
                    int id = await obj.add_notes(tasktitle, taskdesc, date);
                    print("Record Inserted at : "+id.toString());
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("HomePage");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text("Add Task",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}