class Profile {
  String hnNumber;
  String firstName;
  String lastName;
  String gender;
  String birthdate;
  String therapist;
  List<int> score;

  Profile({
    this.hnNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthdate,
    this.therapist,
    this.score
  });

  factory Profile.fromJSON(Map<String, dynamic> json) {
    return Profile(
        hnNumber: json['HN'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        gender: (json['HN'] == 'นาย') ? 'ชาย' : 'หญิง',
        birthdate: json['birthdate'],
        therapist: json['therapist'],
        score: json['score'].cast<int>()
    );
  }

}