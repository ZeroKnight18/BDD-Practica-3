import 'package:flutter/material.dart';

class EntradaTarea extends StatelessWidget {
  final Function(String) onAgregarTarea;
  final TextEditingController _tareaController = TextEditingController();

  EntradaTarea({required this.onAgregarTarea});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _tareaController,
              decoration: InputDecoration(labelText: 'Nueva tarea'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onAgregarTarea(_tareaController.text);
              _tareaController.clear();
            },
          ),
        ],
      ),
    );
  }
}
