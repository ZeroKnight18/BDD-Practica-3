import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_3_bdd/widgets/entrada_tarea.dart';
import 'models/tarea.dart';
import 'widgets/lista_tarea.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(TareaAdapter());
  await Hive.openBox<Tarea>('tareas');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ListaTareaScreen(),
    );
  }
}

class ListaTareaScreen extends StatefulWidget {
  @override
  _ListaTareaScreenState createState() => _ListaTareaScreenState();
}

class _ListaTareaScreenState extends State<ListaTareaScreen> {
  final Box<Tarea> box = Hive.box<Tarea>('tareas');

  void _agregarTarea(String nombre) {
    if (nombre.isNotEmpty) {
      final tarea = Tarea(id: box.length, nombre: nombre);
      box.add(tarea);
    }
  }

  void _eliminarTarea(int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: Column(
        children: [
          EntradaTarea(onAgregarTarea: _agregarTarea),
          Expanded(
            child: ListaTarea(box: box, onEliminarTarea: _eliminarTarea),
          ),
        ],
      ),
    );
  }
}
