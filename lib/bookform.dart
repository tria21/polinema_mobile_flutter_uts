import 'package:tugas_uts/bookItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookEntryForm extends StatefulWidget {
  final BookItem bookItem;
  BookEntryForm(this.bookItem);
  @override
  BookEntryFormState createState() => BookEntryFormState(this.bookItem);
}

class BookEntryFormState extends State<BookEntryForm> {
  BookItem bookItem;
  BookEntryFormState(this.bookItem);
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (bookItem != null) {
      titleController.text = bookItem.title;
      authorController.text = bookItem.author;
      descController.text = bookItem.desc;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: bookItem == null ? Text('Tambah') : Text('Ubah'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back), //icon back
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //bookName form
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Book Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //author form
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: authorController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //desc form
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            // button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  // tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (bookItem == null) {
                          // tambah data
                          bookItem = BookItem(
                            titleController.text,
                            authorController.text,
                            descController.text,
                          );
                        } else {
                          // ubah data
                          bookItem.title = titleController.text;
                          bookItem.author = authorController.text;
                          bookItem.desc = descController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek book
                        Navigator.pop(context, bookItem);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  // tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}