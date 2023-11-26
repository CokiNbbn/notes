import 'package:flutter/material.dart';
import 'package:notes/task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task Detail', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title:',
              style: MyStyle.titleStyle,
            ),
            const SizedBox(height: 8.0),
            Text(task.title, style: MyStyle.subTitleStyle,),
            const SizedBox(height: 16.0),
            const Text(
              'Task Description:',
              style: MyStyle.titleStyle,
            ),
            const SizedBox(height: 8.0),
            Text(task.subtitle, style: MyStyle.subTitleStyle,),
          ],
        ),
      ),
    );
  }
}

class MyStyle {
  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Color(0xFF333333)
  );

  static const subTitleStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF333333)
  );
}
