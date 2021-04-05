class Kategori{
  //menginstansiasi atribut yang ada
  String _kategoriCode;
  String _kategoriName;

  //membuat setter dan getter
  String get kategoriCode => this._kategoriCode;
  set kategoriCode(String value) => this._kategoriCode = value;

  String get kategoriName => this._kategoriName;
  set kategoriName(String value) => this._kategoriName = value;

  //membuat konstruktor versi 1
  Kategori(this._kategoriCode, this._kategoriName);

  //membuat konstruktor versi 2 : konversi dari Map ke Kategori
  Kategori.fromMap(Map<String, dynamic>map) {
    this._kategoriCode = map['kategoriCode'];
    this._kategoriName = map['kategoriName'];
  }

  //konversi kategori ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['kategoriCode'] = kategoriCode;
    map['kategoriName'] = kategoriName;
    return map;
  }
}