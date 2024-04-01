class Users {
  Users(
      {required this.nickname,
        required this.lookingTo,
        required this.interests,
        required this.memberOf,
        required this.organizerOf,
        required this.userId,
        required this.background

      });

  final String nickname;
  final List<dynamic> lookingTo;
  final List<dynamic> interests;
  final List<dynamic> memberOf;
  final List<dynamic> organizerOf;
  final String userId;
  final String background;

}
