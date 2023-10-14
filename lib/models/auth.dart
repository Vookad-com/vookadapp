class JwtToken {
  final String token;

  JwtToken(this.token);

  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(json['token']);
  }
}