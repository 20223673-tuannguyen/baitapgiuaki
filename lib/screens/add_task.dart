import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {

  final Function(Task) onAdd;

  AddTaskScreen(this.onAdd);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool remind = false;
  String remindType = "Chuông";

  Future pickDateTime() async {

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if(date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(time == null) return;

    setState(() {
      timeController.text =
      "${date.day}/${date.month}/${date.year} - ${time.format(context)}";
    });
  }

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
              readOnly: true,
              onTap: pickDateTime,
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

                Task task = Task(
                  name: nameController.text,
                  time: timeController.text,
                  location: locationController.text,
                  remind: remind,
                  remindType: remindType,
                );

                widget.onAdd(task);

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}