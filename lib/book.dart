import 'package:tugas_uts/bookform.dart';
import 'package:tugas_uts/dbhelper.dart';
import 'package:tugas_uts/bookItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class Book extends StatefulWidget {
  
  @override
  BookState createState() => BookState();
}

class BookState extends State<Book> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<BookItem> itemList;

  @override
  // untuk menampilkan data yang sudah diinputkan ketika pertama kali membuka apk
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<BookItem>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Book',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertBookItem(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Future<BookItem> navigateToEntryForm(
      BuildContext context, BookItem bookItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BookEntryForm(bookItem);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(8),
          child: ListTile(
            // widget yang akan menampilkan sebelum title
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.auto_stories),
            ),
            title: Text(
              this.itemList[index].title,
              style: textStyle,
            ),
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    var item = await navigateToEntryForm(
                        context, this.itemList[index]);
                    //TODO 4 Panggil Fungsi untuk Edit data
                    if (item != null) editItem(item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                    deleteItem(itemList[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //delete Item
  void deleteItem(BookItem object) async {
    int result = await dbHelper.deleteBookItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(BookItem object) async {
    int result = await dbHelper.updateBookItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<BookItem>> itemListFuture = dbHelper.getBookItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}