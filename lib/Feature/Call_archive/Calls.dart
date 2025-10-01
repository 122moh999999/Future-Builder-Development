import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/services/SQFlite.dart';


class Calls extends StatefulWidget {
  const Calls({Key? key}) : super(key: key);

  @override
  _CallsState createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> itemsFuture;
  final Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    setState(() {
      itemsFuture = dbHelper.getItems();
      selectedIndices.clear();
    });
  }

  Future<void> _deleteSelectedItems() async {
    final items = await dbHelper.getItems();
    for (final index in selectedIndices) {
      await dbHelper.deleteItem(items[index]['id']);
    }
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Archive',style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          if (selectedIndices.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelectedItems,
              tooltip: 'Delete Selected',
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items available.'));
          }

          final items = snapshot.data!;

          return ListView.builder(

            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = selectedIndices.contains(index);

              return ListTile(
                title: Text('you Contact with ${item['phone']} for ${item['type']} in ${item['location']}'),
                tileColor: isSelected ? Colors.blue.withOpacity(0.3) : null,
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : null,
                onLongPress: () {
                  setState(() {
                    selectedIndices.contains(index)
                        ? selectedIndices.remove(index)
                        : selectedIndices.add(index);
                  }
                  );
                },


              );
            },
          );
        },
      ),
    );
  }
}
