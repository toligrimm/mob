class UserModel {
  final String gender;
  final String title;
  final String first;
  final String last;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String picture;
  final String phone;

  const UserModel({
    required this.gender,
    required this.title,
    required this.first,
    required this.last,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.picture,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'] as String,
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      postcode: json['postcode'] as String,
      picture: json['picture']['large'] as String,
      phone: json['phone'] as String,
    );
  }
}
