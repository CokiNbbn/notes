import 'package:flutter/material.dart';
import 'package:notes/task.dart';
import 'package:notes/task_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_dev_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

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

  @override
  void dispose() {
    _controller.dispose();
    _controllerSubtitle.dispose();
    super.dispose();
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
      _tasks.add(
          Task(title: _controller.text, subtitle: _controllerSubtitle.text));
    } else {
      _tasks[_editingIndex].title = _controller.text;
      _tasks[_editingIndex].subtitle = _controllerSubtitle.text;
      _editingIndex = -1;
    }
    Task.saveToSharedPreferences(prefs, _tasks);
    _loadTasks();
    _controller.clear();
    _controllerSubtitle.clear(); // Clear subtitle controller
  }

  void _editTask(int index) {
    setState(() {
      _editingIndex = index;
      _controller.text = _tasks[index].title;
      _controllerSubtitle.text = _tasks[index].subtitle;
    });
  }

  void _deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
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
          'To Do',
          style: MyStyle.titleStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              iconSize: 15.0,
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutDeveloperPage()),
                );
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _controller.clear();
          _controllerSubtitle.clear();
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
            child: _tasks.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'All Done',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.done_rounded,
                        size: 100,
                        color: Colors.green,
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              _tasks[index].title,
                              style: MyStyle.titleStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              _tasks[index].subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    _editingIndex == -1 ? 'Add New Task' : 'Edit Task',
                    style: MyStyle.titleStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      style: MyStyle.subTitleStyle,
                      decoration: InputDecoration(
                        hintText: 'Enter the task title',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _controllerSubtitle,
                      maxLines: null,
                      style: MyStyle.subTitleStyle,
                      decoration: InputDecoration(
                        hintText: 'Enter the task description',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _editingIndex = -1;
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _saveTask();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            _editingIndex == -1 ? 'Save' : 'Edit',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
