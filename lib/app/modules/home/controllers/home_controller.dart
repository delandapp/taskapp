import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taskapp/app/data/models/task.dart';
import 'package:taskapp/app/data/service/storage/repository.dart';

class HomeController extends GetxController {
  // Inisiasi varibel untuk bisa membaca dan menulis di localstorage
  TaskRepository taskRepository;

  // Membuat construktor untuk home Controller
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final chipIndex = 0.obs;
  final task = Rx<Task?>(null);
  // Membuat progress indikator
  // List Task yang akan dikerjakan
  final doingTodos = <dynamic>[].obs;
  // List Task yang sudah dikerjakan
  final doneTodos = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    editController.dispose();
    
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (var i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      // Kita buat kondisi jika status == true maka akan dimasukan ke dalam list doneTodos jika tidak akan dimasukan ke dalam list doingTodos 
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool addTask(Task task) {
    if(tasks.contains(task)) {
      return false;
    }

    tasks.add(task);
    return true;
  }

  bool updateTask(Task task,String title){
    var todos = task.todos ?? [];
    if(containeTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title,'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return  true; 
  }

  bool containeTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String editController) {
    var todo = {'title': editController, 'done' : false};
    // Melakukan pengecekan apakan ada task yang sama yang berada di doingTodos
    if(doingTodos.any((element) => mapEquals<String,dynamic>(todo, element))) {
      return false;
    }
    // Melakukan pengecekan apakan ada task yang sama yang berada di doneTodos
    var doneTodo = {'title': editController, 'done' : true};
    if(doneTodos.any((element) => mapEquals<String,dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;

  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }
 }
