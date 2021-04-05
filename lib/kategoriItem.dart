class KategoriItem{
  //menginstansiasi atribut yang ada
  int _id;
  String _name;

  //membuat setter dan getter
  int get id => this._id;

  String get name => this._name;
  set name(String value) => this._name = value;

  //membuat konstruktor versi 1
  KategoriItem(this._name);

  //membuat konstruktor versi 2 : konversi dari Map ke Kategori
  KategoriItem.fromMap(Map<String, dynamic>map) {
    this._id = map['id'];
    this._name = map['name'];
  }

  //konversi kategori ke map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    return map;
  }
}