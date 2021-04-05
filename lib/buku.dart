class Book{
  String _kategoriCode;
  String _bookCode;
  String _bookName;
  String _author;

  String _desc;


  //membuat setter dan getter
  String get kategoriCode => this._kategoriCode;
  set kategoriCode(String value) => this._kategoriCode = value;

  String get bookCode => this._bookCode;
  set bookCode(String value) => this._bookCode = value;

  get bookName => this._bookName;
  set bookName( value) => this._bookName = value;

  String get author => this._author;
  set author(String value) => this._author = value;

  String get desc => this._desc;
  set desc(String value) => this._desc = value;

  //konstruktor versi 1
  Book(this._kategoriCode, this._bookCode, this._bookName, this._author, this._desc);

  //konstruktor versi 2 : konversi dari Map ke Book
  Book.fromMap(Map<String, dynamic>map){
    this._kategoriCode = map['kategoriCode'];
    this._bookCode = map['bookCode'];
    this._bookName = map['bookName'];
    this._author = map['author'];
    this._desc = map['desc'];
  }

  //konversi book ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['kategoriCode'] = kategoriCode;
    map['bookCode'] = bookCode;
    map['bookName'] = bookName;
    map['author'] = author;
    map['desc'] = desc;
  }
}