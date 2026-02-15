import 'package:flutter/material.dart';
import '../models/tweet.dart';
import '../theme/app_theme.dart';

class TweetCard extends StatefulWidget {
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

  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartScale;
  late Animation<double> _heartOpacity;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(CurvedAnimation(
      parent: _heartController,
      curve: Curves.easeOut,
    ));
    _heartOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_heartController);

    _heartController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showHeart = false);
      }
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    if (!widget.tweet.isLiked) {
      widget.onLike?.call();
    }
    setState(() => _showHeart = true);
    _heartController.forward(from: 0.0);
  }

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
      onTap: widget.onTap,
      onDoubleTap: _onDoubleTap,
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
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.borderColor,
                  child: Text(
                    widget.tweet.username[0].toUpperCase(),
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
                              widget.tweet.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.tweet.isVerified) ...[
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
                              '@${widget.tweet.handle}',
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
                            widget.tweet.timeAgo,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.tweet.content,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                        ),
                      ),
                      if (widget.tweet.imageUrl != null) ...[
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
                            count: widget.tweet.replies,
                            onTap: widget.onReply,
                          ),
                          _ActionButton(
                            icon: widget.tweet.isRetweeted
                                ? Icons.repeat
                                : Icons.repeat,
                            count: widget.tweet.retweets,
                            color: widget.tweet.isRetweeted ? Colors.green : null,
                            onTap: widget.onRetweet,
                          ),
                          _ActionButton(
                            icon: widget.tweet.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            count: widget.tweet.likes,
                            color: widget.tweet.isLiked ? Colors.pink : null,
                            onTap: widget.onLike,
                          ),
                          _ActionButton(
                            icon: Icons.bar_chart,
                            count: widget.tweet.views,
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
            if (_showHeart)
              Positioned.fill(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _heartController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _heartOpacity.value,
                        child: Transform.scale(
                          scale: _heartScale.value,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.pinkAccent,
                            size: 80,
                            shadows: [
                              Shadow(
                                blurRadius: 20,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
