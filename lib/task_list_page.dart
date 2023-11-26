import 'package:flutter/material.dart';
import 'package:notes/task.dart';
import 'package:notes/task_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  TextEditingController _controller = TextEditingController();
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
      _tasks.add(Task(title: _controller.text, subtitle: ''));
    } else {
      _tasks[_editingIndex].title = _controller.text;
      _editingIndex = -1;
    }
    Task.saveToSharedPreferences(prefs, _tasks);
    _controller.clear();
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
      appBar: AppBar(
        title: Text('Catatan Harian'),
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
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
                return Card(
                  child: ListTile(
                    title: Text(_tasks[index].title),
                    subtitle: Text(_tasks[index].subtitle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(task: _tasks[index]),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editTask(index);
                            _showAddTaskDialog(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(index);
                          },
                        ),
                      ],
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
          title: Text(_editingIndex == -1 ? 'Tambah Tugas' : 'Edit Tugas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Masukkan judul tugas'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _tasks[_editingIndex].subtitle = value;
                  });
                },
                decoration: InputDecoration(hintText: 'Masukkan deskripsi tugas'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editingIndex = -1;
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _saveTask();
                Navigator.of(context).pop();
              },
              child: Text(_editingIndex == -1 ? 'Simpan' : 'Edit'),
            ),
          ],
        );
      },
    );
  }
}
