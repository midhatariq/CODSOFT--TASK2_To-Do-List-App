import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(TaskListApp());
}

class TaskListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task List',


      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        // title: Text('Task Management App'),
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Icon(
              Icons.menu,
              color:Colors.black26,
              size: 30,
            ),
            Text('ToDo List App'),
            Container(
              height: 48,
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("image/logo.jpeg"),
              ),
            )
          ],),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title,style: TextStyle(fontSize: 16,color: Colors.black,decoration: task.isCompleted? TextDecoration.lineThrough:null)),

            //title: Text(tasks[index].title),

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)
            ),

            tileColor: Colors.black12,
            trailing: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (value) {
                setState(() {
                  tasks[index].isCompleted = value!;
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    task: tasks[index],
                    onSave: (editedTask) {
                      setState(() {
                        tasks[index] = editedTask;
                      });
                      Navigator.pop(context);
                    },
                    onDelete: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskScreen(
                onSave: (newTask) {
                  setState(() {
                    tasks.add(newTask);
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateTaskScreen extends StatefulWidget {
  final Function(Task) onSave;

  CreateTaskScreen({required this.onSave});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text.trim();
                if (title.isNotEmpty) {
                  Task newTask = Task(title: title, isCompleted: false);
                  widget.onSave(newTask);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onSave;
  final Function() onDelete;

  EditTaskScreen({
    required this.task,
    required this.onSave,
    required this.onDelete,
  });

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _isCompleted = widget.task.isCompleted;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Completed'),
              value: _isCompleted,
              onChanged: (value) {
                setState(() {
                  _isCompleted = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      String title = _titleController.text.trim();
                      if (title.isNotEmpty) {
                        Task editedTask = Task(
                          title: title,
                          isCompleted: _isCompleted,
                        );
                        widget.onSave(editedTask);
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onDelete,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, required this.isCompleted});
}
