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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Task Detail',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  const Text(
                    'Task Title:',
                    style: MyStyle.titleStyle,
                  ),
                  Text(
                    task.title,
                    style: MyStyle.subTitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Task Description:',
                    style: MyStyle.titleStyle,
                  ),
                  Text(
                    task.subtitle,
                    style: MyStyle.subTitleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStyle {
  static const TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF333333));

  static const subTitleStyle =
      TextStyle(fontSize: 16, color: Color(0xFF333333));
}
