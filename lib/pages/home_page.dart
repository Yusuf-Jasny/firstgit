import 'package:apptodo/Data/database.dart';
import 'package:apptodo/utilities/dialogbox.dart';
import 'package:apptodo/utilities/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override

  void initState() {
    //If this is the first t ime ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }else{
      //there already exists data
      db.loadData();
    }


    super.initState();
  }

//text controller 
  final _controller = TextEditingController();



  //checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1]; 
    });
    db.updateDataBase();
  }

//Save New Task
void SaveNewTask(){
  setState(() {
    db.todolist.add([_controller.text, false]);
  });
  db.updateDataBase();
  Navigator.of(context).pop();
}

  //creating new task
  void createnewtask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: SaveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }


  //delete task
  void deleteTask(int index){
        setState(() {
          db.todolist.removeAt(index);
        });
        db.updateDataBase();
      }


  @override




  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        child: Icon(Icons.add),
      ),





      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: db.todolist[index][0],
            taskcompleted: db.todolist[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (Context) => deleteTask(index),
            );
        },
          
        
      ),
      
    );
  }
}