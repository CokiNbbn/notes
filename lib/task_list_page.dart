import 'package:flutter/material.dart';
import 'package:notes/task.dart';
import 'package:notes/task_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerSubtitle = TextEditingController();

  List<Task> _tasks = [];
  int _editingIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = Task.fromSharedPreferences(prefs);
    });
  }

  void _saveTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_editingIndex == -1) {
      _tasks.add(Task(title: _controller.text, subtitle: _controllerSubtitle.text));
    } else {
      _tasks[_editingIndex].title = _controller.text;
      _tasks[_editingIndex].subtitle = _controllerSubtitle.text;
      _editingIndex = -1;
    }
    Task.saveToSharedPreferences(prefs, _tasks);
    _controller.clear();
    _controllerSubtitle.clear(); // Clear subtitle controller
    _loadTasks();
  }

  void _editTask(int index) {
    setState(() {
      _editingIndex = index;
      _controller.text = _tasks[index].title;
    });
  }

  void _deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.removeAt(index);
      _editingIndex = -1; // Reset editing index after deletion
    });
    Task.saveToSharedPreferences(prefs, _tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'DoItNow',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        label: const Text('Add New Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    elevation: 4,
                    child: ListTile(
                      title: Text(_tasks[index].title, style: MyStyle.titleStyle,),
                      subtitle: Text(_tasks[index].subtitle),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskDetailPage(task: _tasks[index]),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editTask(index);
                              _showAddTaskDialog(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_editingIndex == -1 ? 'Add New Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Enter the task title'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _controllerSubtitle.text = value;
                    _tasks[_editingIndex].subtitle = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Enter the task description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editingIndex = -1;
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveTask();
                Navigator.of(context).pop();
              },
              child: Text(_editingIndex == -1 ? 'Save' : 'Edit'),
            ),
          ],
        );
      },
    );
  }
}
