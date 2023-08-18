//
//
//

import 'package:flutter/material.dart';
import 'package:project_1/control/controller.dart';
import 'package:project_1/model/task.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: ChangeNotifierProvider(
        create: (context) => Controller(),
        builder: (context, child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text(
                      "To Do",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.blue,
                    bottom: const TabBar(tabs: [
                      Tab(
                        text: "Uncompleted Tasks",
                      ),
                      Tab(
                        text: "Completed Tasks",
                      ),
                    ]),
                  ),
                  body: TabBarView(
                    children: [
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _textController,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            value.addTask(_textController.text);
                                            _textController.clear();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue[100])),
                                          child: const Text(
                                            "Add task",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  // padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: value.uncompletedTasks.isEmpty
                                      ? const Center(
                                          child: Text("No Tasks Yet :)"),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              value.uncompletedTasks.length,
                                          itemBuilder: (context, index) {
                                            return Task(
                                              value:
                                                  value.uncompletedTasks[index],
                                              id: index,
                                              complete: false,
                                              control: value,
                                            );
                                          },
                                        ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          return Container(
                            margin: const EdgeInsets.all(15),
                            // padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: value.completedTasks.isEmpty
                                ? const Center(child: Text("No Tasks Yet :)"))
                                : ListView.builder(
                                    itemCount: value.completedTasks.length,
                                    itemBuilder: (context, index) {
                                      return Task(
                                        value: value.completedTasks[index],
                                        id: index,
                                        complete: true,
                                        control: value,
                                      );
                                    },
                                  ),
                          );
                        },
                      )
                    ],
                  )));
        },
      ),
    );
  }
}
