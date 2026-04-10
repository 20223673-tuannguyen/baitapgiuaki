import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  List<Task> tasks = [];

  void addTask(Task task){
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách công việc"),
      ),

      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context,index){

          return ListTile(
            title: Text(tasks[index].name),
            subtitle: Text(
                "${tasks[index].time} - ${tasks[index].location}"
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>AddTaskScreen(addTask),
            ),
          );
        },
      ),
    );
  }
}