import 'package:tugas_uts/kategoriItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KategoriEntryForm extends StatefulWidget {
  final KategoriItem kategoriItem;
  KategoriEntryForm(this.kategoriItem);
  @override
  KategoriEntryFormState createState() => KategoriEntryFormState(this.kategoriItem);
}

class KategoriEntryFormState extends State<KategoriEntryForm> {
  KategoriItem kategoriItem;
  KategoriEntryFormState(this.kategoriItem);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (kategoriItem != null) {
      nameController.text = kategoriItem.name;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: kategoriItem == null ? Text('Tambah') : Text('Ubah'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //kategoriName
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Kategori Name',
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
                        if (kategoriItem == null) {
                          // tambah data
                          kategoriItem = KategoriItem(
                            nameController.text,
                          );
                        } else {
                          // ubah data
                          kategoriItem.name = nameController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, kategoriItem);
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