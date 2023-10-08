import 'package:flutter/material.dart';
import 'package:m03/components/ShoppingList.dart';
import 'package:m03/components/itemScreen.dart';
import 'package:m03/components/myProvider.dart';
import 'package:m03/components/shopping_list_dialog.dart';
import 'package:m03/dtbase/dtbase.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int id = 0;
  final DBHelper _dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    var tmp = Provider.of<ListProductProvider>(context, listen: true);
    _dbHelper.getmyShoppingList().then((value) => tmp.setShoppingList = value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
          )
        ],
      ),
      body: ListView.builder(
          itemCount:
              // ignore: unnecessary_null_comparison
              tmp.getShoppingList != null ? tmp.getShoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(tmp.getShoppingList[index].id.toString()),
              onDismissed: (direction) {
                String tmpName = tmp.getShoppingList[index].name;
                int tmpId = tmp.getShoppingList[index].id;
                setState(() {
                  tmp.deleteById(tmp.getShoppingList[index]);
                });
                _dbHelper.deleteShoppingList(tmpId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$tmpName deleted"),
                  ),
                );
              },
              child: ListTile(
                title: Text(tmp.getShoppingList[index].name),
                leading: CircleAvatar(
                    child: Text("${tmp.getShoppingList[index].sum}")),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ItemScreen(tmp.getShoppingList[index]);
                    }),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ShoppingListDialog(_dbHelper).buildDialog(
                              context, tmp.getShoppingList[index], false);
                        });
                    _dbHelper
                        .getmyShoppingList()
                        .then((value) => tmp.setShoppingList = value);
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return ShoppingListDialog(_dbHelper)
                    .buildDialog(context, ShoppingList(++id, "", 0), true);
              });
          _dbHelper
              .getmyShoppingList()
              .then((value) => tmp.setShoppingList = value);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dbHelper.closeDB();
  }
}
