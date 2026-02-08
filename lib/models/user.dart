class User {
  final String id;
  final String username;
  final String handle;
  final String avatarUrl;
  final String? bio;
  final int followers;
  final int following;
  final bool isVerified;
  final String? bannerUrl;
  final String joinDate;

  const User({
    required this.id,
    required this.username,
    required this.handle,
    required this.avatarUrl,
    this.bio,
    required this.followers,
    required this.following,
    this.isVerified = false,
    this.bannerUrl,
    required this.joinDate,
  });
}
