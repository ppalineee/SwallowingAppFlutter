class Profile {
  String hnNumber;
  String firstName;
  String lastName;
  String gender;
  String birthdate;
  String therapist;

  Profile({
    this.hnNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthdate,
    this.therapist
  });

  factory Profile.fromJSON(Map<String, dynamic> json) {
    return Profile(
        hnNumber: json['HN'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        gender: (json['HN'] == 'นาย') ? 'ชาย' : 'หญิง',
        birthdate: json['birthdate'],
        therapist: json['therapist']
    );
  }

}