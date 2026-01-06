class AppUser {
  final String uid;
  final String email;
  final String username;

  AppUser({required this.uid, required this.email, required this.username});

  //convert app user -> json and viceversa (for potential firebase auth handling)
  Map<String, dynamic> toJson() {
    return {
      '_id': uid,
      'email': email,
      'username': username
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(uid: jsonUser['_id'], email:  jsonUser['email'], username:  jsonUser['username']);
  }
}
