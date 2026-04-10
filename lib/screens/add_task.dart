import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {

  final Function(Task) onAdd;

  AddTaskScreen(this.onAdd);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool remind = false;
  String remindType = "Chuông";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm công việc"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Tên công việc",
              ),
            ),

            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Thời gian",
              ),
            ),

            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "Địa điểm",
              ),
            ),

            SwitchListTile(
              title: Text("Nhắc việc"),
              value: remind,
              onChanged: (value){
                setState(() {
                  remind = value;
                });
              },
            ),

            if(remind)
              DropdownButton<String>(
                value: remindType,
                items: [
                  DropdownMenuItem(
                    value: "Chuông",
                    child: Text("Chuông"),
                  ),
                  DropdownMenuItem(
                    value: "Email",
                    child: Text("Email"),
                  ),
                  DropdownMenuItem(
                    value: "Thông báo",
                    child: Text("Thông báo"),
                  ),
                ],
                onChanged: (value){
                  setState(() {
                    remindType = value!;
                  });
                },
              ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Ghi lại công việc"),
              onPressed: (){

                Task newTask = Task(
                  name: nameController.text,
                  time: timeController.text,
                  location: locationController.text,
                  remind: remind,
                  remindType: remindType,
                );

                widget.onAdd(newTask);

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}