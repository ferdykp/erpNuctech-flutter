class LoginResponse {
  final bool status;
  final String message;
  final LoginUser? data;

  LoginResponse({required this.status, required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginUser.fromJson(json['data']) : null,
    );
  }
}

class LoginUser {
  final int id;
  final String username;
  final String role;
  final int refXtyhId;

  LoginUser({
    required this.id,
    required this.username,
    required this.role,
    required this.refXtyhId,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      refXtyhId: json['ref_XTYH_ID'],
    );
  }
}
