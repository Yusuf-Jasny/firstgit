import 'package:hive/hive.dart';

class ToDoDataBase  {

  List todolist = [];

  //reference our box
  final _myBox = Hive.box('mybox');

//If this is the fisrt time ever opening the app
  void createInitialData() {
    todolist = [
      ["Complete the HomeWork", false],
      ["Prepare for Advi Scripts", false],
      ["Live Sceince Spot exams", true],

    ];
  }

//load the data from the database
void loadData() {
  todolist = _myBox.get("TODOLIST");

}


//Update the database (If user makes any changes
void updateDataBase() {
_myBox.put("TODOLIST", todolist);
}

}