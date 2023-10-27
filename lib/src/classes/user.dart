import 'dart:io';

class SirenUser {
  SirenUser(this.email, this.password, {this.profile}) {
    profile = profile ?? SirenProfile();
  }

  late String email;
  late String password;
  late SirenProfile? profile;
}

class SirenProfile {
  SirenProfile({this.firstName, this.birthdate, this.city, this.bio, this.interests, this.photos});

  late String? firstName, city, bio;
  late DateTime? birthdate;
  late List<String>? interests;
  late List<File>? photos;
}
