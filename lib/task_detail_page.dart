import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/task.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul Tugas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(task.title),
            SizedBox(height: 16.0),
            Text(
              'Deskripsi Tugas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(task.subtitle),
          ],
        ),
      ),
    );
  }
}
