class BookItem{
  int _id;
  int _kategoriId;
  String _title;
  String _author;
  String _desc;


  //membuat setter dan getter
  int get id => this._id;

  get kategoriId => this._kategoriId;

  get title => this._title;
  set title( value) => this._title = value;

  String get author => this._author;
  set author(String value) => this._author = value;

  String get desc => this._desc;
  set desc(String value) => this._desc = value;

  //konstruktor versi 1
  BookItem(this._title, this._author, this._desc);

  //konstruktor versi 2 : konversi dari Map ke Book
  BookItem.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._kategoriId = map['kategoriId'];
    this._title = map['title'];
    this._author = map['author'];
    this._desc = map['desc'];
  }

  //konversi book ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kategoriId'] = this._kategoriId;
    map['title'] = title;
    map['author'] = author;
    map['desc'] = desc;
    return map;
  }
}