
import 'dart:io';

void main() {
  List<String> tasks = [];
  List<bool> completed = [];

  while (true) {
    print('\n===== TODO APP =====');
    print('1. Add Task');
    print('2. View Tasks');
    print('3. Complete Task');
    print('4. Delete Task');
    print('5. Exit');

    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter your task: ');
        String? task = stdin.readLineSync();

        if (task != null && task.trim().isNotEmpty) {
          tasks.add(task.trim());
          completed.add(false);
          print('Task added successfully!');
        } else {
          print('Task cannot be empty!');
        }
        break;

      case '2':
        print('\n===== YOUR TASKS =====');

        if (tasks.isEmpty) {
          print('No tasks available.');
        } else {
          for (int i = 0; i < tasks.length; i++) {
            String status = completed[i] ? 'Completed' : 'Pending';

            print('${i + 1}. ${tasks[i]} [$status]');
          }
        }
        break;

      case '3':
        if (tasks.isEmpty) {
          print('No tasks available to complete.');
          break;
        }

        stdout.write('Enter task number to complete: ');
        String? input = stdin.readLineSync();
        int? index = int.tryParse(input ?? '');

        if (index != null && index >= 1 && index <= tasks.length) {
          completed[index - 1] = true;
          print('Task marked as completed!');
        } else {
          print('Invalid task number!');
        }
        break;

      case '4':
        if (tasks.isEmpty) {
          print('No tasks available to delete.');
          break;
        }

        stdout.write('Enter task number to delete: ');
        String? input = stdin.readLineSync();
        int? index = int.tryParse(input ?? '');

        if (index != null && index >= 1 && index <= tasks.length) {
          tasks.removeAt(index - 1);
          completed.removeAt(index - 1);
          print('Task deleted successfully!');
        } else {
          print('Invalid task number!');
        }
        break;

      case '5':
        print('Thank you for using Todo App!');
        return;

      default:
        print('Invalid choice! Please enter 1 to 5.');
    }
  }
}
