//
//
//

import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task(
      {super.key,
      required this.value,
      required this.id,
      required this.complete,
      this.control});
  final String value;
  final int id;
  final bool complete;
  final control;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          complete == true
              ? IconButton(
                  onPressed: () {
                    control.removeCompletedTask(id);
                  },
                  icon: const Icon(Icons.delete_outline))
              : Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          control.makeTaskCompleted(id);
                        },
                        icon: const Icon(Icons.done_outline)),
                    IconButton(
                        onPressed: () {
                          control.removeUncompletedTask(id);
                        },
                        icon: const Icon(Icons.delete_outline))
                  ],
                )
        ],
      ),
    );
  }
}
