import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shuffle_app/presentation/ui/screens/home_screen/data/Data.dart';
import 'package:shuffle_app/services/hive_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controllerFiled = TextEditingController();

  @override
  void initState() {
    personList.addAll(Hive.box("myBox").values.toList());
    personList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShuffleApp"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          setState(() {
            if (_controllerFiled.text.isNotEmpty) {
              MyDB.writeToBox(_controllerFiled.text);
              personList.clear();
              personList.addAll(Hive.box("myBox").values.toList());
              personList.shuffle();
              _controllerFiled.clear();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Diqqat!!!'),
                    content: const Text('Iltimos ro`yxatga isim qushish uchun avval ismni kiriting'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            }
          });
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: "Input Name"),
              controller: _controllerFiled,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: personList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: index < personList.length / 2
                      ? Colors.yellow
                      : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      personList[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
