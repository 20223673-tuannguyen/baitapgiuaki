import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task.dart';

class TaskListScreen extends StatefulWidget {

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  List<Task> tasks = [];

  void addTask(Task task){
    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleDone(int index){
    setState(() {
      tasks[index].done = !tasks[index].done;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách công việc"),
        centerTitle: true,
      ),

      body: tasks.isEmpty
          ? Center(
        child: Text(
          "Chưa có công việc",
          style: TextStyle(fontSize: 18),
        ),
      )

          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context,index){

          Task task = tasks[index];

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,

            child: ListTile(

              leading: Checkbox(
                value: task.done,
                onChanged: (value){
                  toggleDone(index);
                },
              ),

              title: Text(
                task.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: task.done
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("⏰ ${task.time}"),
                  Text("📍 ${task.location}"),

                  if(task.remind)
                    Text("🔔 ${task.remindType}")
                ],
              ),

              trailing: IconButton(
                icon: Icon(Icons.delete,color: Colors.red),
                onPressed: (){
                  deleteTask(index);
                },
              ),
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