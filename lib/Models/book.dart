/// bookname : "kdslnlk"
/// file : "kdslnlk"
/// publistdate : "kdslnlk"
/// dar : "kdslnlk"
/// bookcover : "kdslnlk"
/// authername : "kdslnlk"
/// autherage : "kdslnlk"
/// education : "kdslnlk"
/// city : "kdslnlk"
/// autherimage : "kdslnlk"

class Book {
  Book({
    String? id,
      String? bookname, 
      String? file, 
      String? publistdate, 
      String? dar, 
      String? bookcover, 
      String? authername, 
      String? autherage, 
      String? education, 
      String? city, 
      String? autherimage,}){
    _id = id;
    _bookname = bookname;
    _file = file;
    _publistdate = publistdate;
    _dar = dar;
    _bookcover = bookcover;
    _authername = authername;
    _autherage = autherage;
    _education = education;
    _city = city;
    _autherimage = autherimage;
}

  Book.fromJson(dynamic json) {
    _bookname = json['bookname'];
    _file = json['file'];
    _publistdate = json['publistdate'];
    _dar = json['dar'];
    _bookcover = json['bookcover'];
    _authername = json['authername'];
    _autherage = json['autherage'];
    _education = json['education'];
    _city = json['city'];
    _autherimage = json['autherimage'];
    _autherimage = json['id'];

  }
  String? _bookname;
  String? _file;
  String? _publistdate;
  String? _dar;
  String? _bookcover;
  String? _authername;
  String? _autherage;
  String? _education;
  String? _city;
  String? _autherimage;
  String? _id;

  String? get bookname => _bookname;
  String? get file => _file;
  String? get publistdate => _publistdate;
  String? get dar => _dar;
  String? get bookcover => _bookcover;
  String? get authername => _authername;
  String? get autherage => _autherage;
  String? get education => _education;
  String? get city => _city;
  String? get autherimage => _autherimage;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookname'] = _bookname;
    map['file'] = _file;
    map['publistdate'] = _publistdate;
    map['dar'] = _dar;
    map['bookcover'] = _bookcover;
    map['authername'] = _authername;
    map['autherage'] = _autherage;
    map['education'] = _education;
    map['city'] = _city;
    map['autherimage'] = _autherimage;
    map['id'] = _id;

    return map;
  }

}