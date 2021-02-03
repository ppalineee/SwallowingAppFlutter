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
        gender: (json['title'] == 'นาย') ? 'ชาย' : 'หญิง',
        birthdate: json['birthdate'],
        therapist: json['caretaker'],
        score: json['score'].cast<int>()
    );
  }

  factory Profile.fromMap(Map<String, dynamic> json) {
    return Profile(
        hnNumber: json['hnNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        birthdate: json['birthdate'],
        therapist: json['therapist'],
        score: json['score'].cast<int>()
    );
  }

  Map<String, dynamic> toJson() => {
    "hnNumber": hnNumber,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "birthdate": birthdate,
    "therapist": therapist,
    "score": score
  };
}