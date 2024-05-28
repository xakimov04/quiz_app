import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/todo.dart';
import 'package:quiz_app/providers/todo_provider.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoState = Provider.of<TodoState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Todos',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: todoState.todos.length,
          itemBuilder: (context, index) {
            final todo = todoState.todos[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(todo.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo.description),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          todo.date.toString().substring(0, 11),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          todo.time.format(context),
                        )
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    todoState.removeTodo(todo.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoEditScreen(todo: todo),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoEditScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TodoEditScreen extends StatelessWidget {
  final Todo? todo;

  const TodoEditScreen({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController =
        TextEditingController(text: todo?.description ?? '');
    final dateController = TextEditingController(
        text: todo != null ? '${todo!.date.toLocal()}'.split(' ')[0] : '');
    final timeController = TextEditingController(
        text: todo != null ? todo!.time.format(context) : '');

    final todoState = Provider.of<TodoState>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          todo == null ? 'Add Todo' : 'Edit Todo',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: todo?.date ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text = '${pickedDate.toLocal()}'.split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: todo?.time ?? TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (todo == null) {
                  todoState.addTodo(
                    Todo(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.parse(dateController.text),
                      time: TimeOfDay(
                        hour: int.parse(timeController.text.split(':')[0]),
                        minute: int.parse(
                          timeController.text.split(":")[0],
                        ),
                      ),
                    ),
                  );
                } else {
                  todo?.title = titleController.text;
                  todo?.description = descriptionController.text;
                  todo?.date = DateTime.parse(dateController.text);
                  todo?.time = TimeOfDay(
                    hour: int.parse(timeController.text.split(':')[0]),
                    minute: int.parse(
                      timeController.text.split(':')[1],
                    ),
                  );
                  todoState.updateTodo(todo!);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
