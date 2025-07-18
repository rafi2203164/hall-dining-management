class UserModel {
  final String fullName;
  final String email;
  final String password;
  final int availableTokens;
  final int availableCredit;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.availableTokens,
    required this.availableCredit,
  });
}
