class FBUser {
  String? id;
  String? name;
  String? email;

  FBUser({
    this.id,
    this.name,
    this.email
  });

  Map<String, dynamic> toJson() =>{
    'id': id,
    'name':name,
    'email':email,
  };

  static FBUser fromJson(Map<String, dynamic> json) =>FBUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
  );

}