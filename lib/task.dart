import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String title;
  String subtitle;

  Task({required this.title, this.subtitle = ''});

  static List<Task> fromSharedPreferences(SharedPreferences prefs) {
    List<String>? taskTitles = prefs.getStringList('task_titles');
    List<String>? taskSubtitles = prefs.getStringList('task_subtitles');
    List<Task> tasks = [];

    if (taskTitles != null) {
      for (int i = 0; i < taskTitles.length; i++) {
        String title = taskTitles[i];
        String subtitle = taskSubtitles != null && i < taskSubtitles.length ? taskSubtitles[i] : '';
        tasks.add(Task(title: title, subtitle: subtitle));
      }
    }

    return tasks;
  }

  static void saveToSharedPreferences(SharedPreferences prefs, List<Task> tasks) {
    List<String> taskTitles = tasks.map((task) => task.title).toList();
    List<String> taskSubtitles = tasks.map((task) => task.subtitle).toList();
    prefs.setStringList('task_titles', taskTitles);
    prefs.setStringList('task_subtitles', taskSubtitles);
  }
}
