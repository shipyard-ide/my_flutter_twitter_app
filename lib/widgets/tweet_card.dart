import 'package:flutter/material.dart';
import '../models/tweet.dart';
import '../theme/app_theme.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;
  final VoidCallback? onLike;
  final VoidCallback? onRetweet;
  final VoidCallback? onReply;
  final VoidCallback? onTap;

  const TweetCard({
    super.key,
    required this.tweet,
    this.onLike,
    this.onRetweet,
    this.onReply,
    this.onTap,
  });

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.borderColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppTheme.borderColor,
              child: Text(
                tweet.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tweet.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (tweet.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: AppTheme.primaryBlue,
                          size: 16,
                        ),
                      ],
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '@${tweet.handle}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '·',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tweet.timeAgo,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tweet.content,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  if (tweet.imageUrl != null) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: AppTheme.cardColor,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 48,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(
                        icon: Icons.chat_bubble_outline,
                        count: tweet.replies,
                        onTap: onReply,
                      ),
                      _ActionButton(
                        icon: tweet.isRetweeted
                            ? Icons.repeat
                            : Icons.repeat,
                        count: tweet.retweets,
                        color: tweet.isRetweeted ? Colors.green : null,
                        onTap: onRetweet,
                      ),
                      _ActionButton(
                        icon: tweet.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        count: tweet.likes,
                        color: tweet.isLiked ? Colors.pink : null,
                        onTap: onLike,
                      ),
                      _ActionButton(
                        icon: Icons.bar_chart,
                        count: tweet.views,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.bookmark_border,
                              size: 18,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.share_outlined,
                              size: 18,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.count,
    this.color,
    this.onTap,
  });

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: color ?? AppTheme.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            _formatNumber(count),
            style: TextStyle(
              color: color ?? AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
