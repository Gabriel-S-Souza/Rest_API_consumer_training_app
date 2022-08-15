import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/home/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = HomeController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeController.readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
            animation: homeController,
            builder: (context, child) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Tarefa',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: homeController.isAddTaskLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.add),
                      onPressed: () {
                        if(titleController.text.isEmpty) return;
                        homeController.create(titleController.text);
                        titleController.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Tarefas', style: TextStyle(fontSize: 24)),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: homeController.isLoading
                          ? const [
                              SizedBox(height: 28),
                              Center(child: CircularProgressIndicator()),
                            ]
                          : homeController.tasks.map((task) {
                              return ListTile(
                                title: Text(task.title),
                                subtitle: Text(task.status),
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
