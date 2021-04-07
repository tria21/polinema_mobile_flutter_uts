class BookItem{
  //instansiasi atribut yang dibutuhkan
  int _id;
  String _title;
  String _author;
  String _desc;
  String _kategoriName;

  //membuat setter dan getter
  int get id => this._id;

  get title => this._title;
  set title( value) => this._title = value;

  String get author => this._author;
  set author(String value) => this._author = value;

  String get desc => this._desc;
  set desc(String value) => this._desc = value;

  String get kategoriName => this._kategoriName;
  set kategoriName(String value) => this._kategoriName = value;

  //konstruktor versi 1
  BookItem(this._title, this._author, this._desc, this._kategoriName);

  //konstruktor versi 2 : konversi dari Map ke Book
  BookItem.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._title = map['title'];
    this._author = map['author'];
    this._desc = map['desc'];
    this._kategoriName = map['kategoriName'];
  }

  //konversi book ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['author'] = author;
    map['desc'] = desc;
    map['kategoriName'] = kategoriName;
    return map; //digunakan untuk menampilkan item buku di list
  }
}