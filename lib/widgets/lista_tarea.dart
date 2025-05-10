import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tarea.dart';

class ListaTarea extends StatelessWidget {
  final Box<Tarea> box;
  final Function(int) onEliminarTarea;

  ListaTarea({required this.box, required this.onEliminarTarea});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<Tarea> box, _) {
        if (box.isEmpty) return Center(child: Text('Sin tareas aún'));
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final tarea = box.getAt(index);
            return ListTile(
              title: Text(tarea?.nombre ?? ''),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onEliminarTarea(index),
              ),
            );
          },
        );
      },
    );
  }
}
