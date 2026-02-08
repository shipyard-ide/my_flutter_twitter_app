class Tweet {
  final String id;
  final String username;
  final String handle;
  final String avatarUrl;
  final String content;
  final String timeAgo;
  final int likes;
  final int retweets;
  final int replies;
  final int views;
  final bool isLiked;
  final bool isRetweeted;
  final String? imageUrl;
  final bool isVerified;

  const Tweet({
    required this.id,
    required this.username,
    required this.handle,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.retweets,
    required this.replies,
    required this.views,
    this.isLiked = false,
    this.isRetweeted = false,
    this.imageUrl,
    this.isVerified = false,
  });

  Tweet copyWith({
    String? id,
    String? username,
    String? handle,
    String? avatarUrl,
    String? content,
    String? timeAgo,
    int? likes,
    int? retweets,
    int? replies,
    int? views,
    bool? isLiked,
    bool? isRetweeted,
    String? imageUrl,
    bool? isVerified,
  }) {
    return Tweet(
      id: id ?? this.id,
      username: username ?? this.username,
      handle: handle ?? this.handle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      timeAgo: timeAgo ?? this.timeAgo,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      replies: replies ?? this.replies,
      views: views ?? this.views,
      isLiked: isLiked ?? this.isLiked,
      isRetweeted: isRetweeted ?? this.isRetweeted,
      imageUrl: imageUrl ?? this.imageUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
