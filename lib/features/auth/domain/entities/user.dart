abstract class User {
  final String uid;
  final String email;
  bool isProfileComplete;

  User({
    required this.uid,
    required this.email,
    this.isProfileComplete = false,
  });
}
