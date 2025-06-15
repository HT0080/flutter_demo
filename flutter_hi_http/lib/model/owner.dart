class Owner {
  String? name;
  String? face;
  int fans;

  Owner({this.name, this.face, this.fans=-1});

 factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'] as String?,
      face: json['face'] as String?,
      fans: json['fans'] is num ? (json['fans'] as num).toInt() : -1,
    );
  }

  // 将mo 转化成map
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    return data;
  }

}