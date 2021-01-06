class JWTToken {
  var token;
  String type;

  JWTToken({
    this.token,
    this.type,
  });

  factory JWTToken.fromJSON(Map<String, dynamic> json) {
    return JWTToken(
        token: json['token'],
        type: json['type']
    );
  }
}