import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _trendingTopics = [
    {
      'category': 'Technology · Trending',
      'topic': 'Flutter',
      'posts': '125K',
    },
    {
      'category': 'Sports · Trending',
      'topic': 'NFL Playoffs',
      'posts': '456K',
    },
    {
      'category': 'Entertainment · Trending',
      'topic': 'Grammy Awards',
      'posts': '234K',
    },
    {
      'category': 'Business · Trending',
      'topic': 'Stock Market',
      'posts': '89K',
    },
    {
      'category': 'Politics · Trending',
      'topic': 'Election 2024',
      'posts': '567K',
    },
    {
      'category': 'Science · Trending',
      'topic': 'SpaceX Launch',
      'posts': '145K',
    },
    {
      'category': 'Gaming · Trending',
      'topic': '#GTA6',
      'posts': '890K',
    },
    {
      'category': 'Music · Trending',
      'topic': 'Taylor Swift',
      'posts': '1.2M',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: AppTheme.textSecondary),
              prefixIcon: Icon(
                Icons.search,
                color: AppTheme.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Trends for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _trendingTopics.length,
              itemBuilder: (context, index) {
                final trend = _trendingTopics[index];
                return _TrendingItem(
                  category: trend['category'],
                  topic: trend['topic'],
                  posts: trend['posts'],
                  index: index + 1,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Show more',
                  style: TextStyle(color: AppTheme.primaryBlue),
                ),
              ),
            ),
            const Divider(color: AppTheme.borderColor),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Who to follow',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _SuggestedUser(
              name: 'Flutter Dev',
              handle: 'flutterdev',
              isVerified: true,
              onFollow: () {},
            ),
            _SuggestedUser(
              name: 'Dart Lang',
              handle: 'dart_lang',
              isVerified: true,
              onFollow: () {},
            ),
            _SuggestedUser(
              name: 'Google Developers',
              handle: 'googledevs',
              isVerified: true,
              onFollow: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Show more',
                  style: TextStyle(color: AppTheme.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendingItem extends StatelessWidget {
  final String category;
  final String topic;
  final String posts;
  final int index;

  const _TrendingItem({
    required this.category,
    required this.topic,
    required this.posts,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$index · $category',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    topic,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$posts posts',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppTheme.textSecondary,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestedUser extends StatefulWidget {
  final String name;
  final String handle;
  final bool isVerified;
  final VoidCallback onFollow;

  const _SuggestedUser({
    required this.name,
    required this.handle,
    required this.isVerified,
    required this.onFollow,
  });

  @override
  State<_SuggestedUser> createState() => _SuggestedUserState();
}

class _SuggestedUserState extends State<_SuggestedUser> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.borderColor,
            child: Text(
              widget.name[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
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
                        widget.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        color: AppTheme.primaryBlue,
                        size: 16,
                      ),
                    ],
                  ],
                ),
                Text(
                  '@${widget.handle}',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isFollowing = !_isFollowing;
              });
              widget.onFollow();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFollowing ? Colors.transparent : Colors.white,
              foregroundColor: _isFollowing ? Colors.white : Colors.black,
              side: _isFollowing
                  ? const BorderSide(color: AppTheme.borderColor)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              _isFollowing ? 'Following' : 'Follow',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
