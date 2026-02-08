import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'like',
      'user': 'Elon Musk',
      'handle': 'elonmusk',
      'isVerified': true,
      'content': 'liked your post',
      'tweet': 'Just shipped my first Flutter app!',
      'time': '2h',
    },
    {
      'type': 'retweet',
      'user': 'Flutter Dev',
      'handle': 'flutterdev',
      'isVerified': true,
      'content': 'reposted your post',
      'tweet': 'Flutter makes mobile development fun!',
      'time': '4h',
    },
    {
      'type': 'follow',
      'user': 'Tech News',
      'handle': 'technews',
      'isVerified': true,
      'content': 'followed you',
      'time': '6h',
    },
    {
      'type': 'mention',
      'user': 'Sarah Developer',
      'handle': 'sarahcodes',
      'isVerified': false,
      'content': 'mentioned you in a post',
      'tweet': '@yourhandle Check out this awesome Flutter package!',
      'time': '8h',
    },
    {
      'type': 'like',
      'user': 'Design Matters',
      'handle': 'designmatters',
      'isVerified': true,
      'content': 'liked your post',
      'tweet': 'UI/UX design is underrated',
      'time': '12h',
    },
    {
      'type': 'follow',
      'user': 'Coffee & Code',
      'handle': 'coffeeandcode',
      'isVerified': false,
      'content': 'followed you',
      'time': '1d',
    },
    {
      'type': 'retweet',
      'user': 'Google Developers',
      'handle': 'googledevs',
      'isVerified': true,
      'content': 'reposted your post',
      'tweet': 'Firebase + Flutter = ❤️',
      'time': '2d',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'like':
        return Icons.favorite;
      case 'retweet':
        return Icons.repeat;
      case 'follow':
        return Icons.person;
      case 'mention':
        return Icons.alternate_email;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'like':
        return Colors.pink;
      case 'retweet':
        return Colors.green;
      case 'follow':
        return AppTheme.primaryBlue;
      case 'mention':
        return AppTheme.primaryBlue;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              backgroundColor: AppTheme.borderColor,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryBlue,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Verified'),
            Tab(text: 'Mentions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(_notifications),
          _buildNotificationList(
            _notifications.where((n) => n['isVerified'] == true).toList(),
          ),
          _buildNotificationList(
            _notifications.where((n) => n['type'] == 'mention').toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 48,
              color: AppTheme.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'No notifications yet',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _NotificationItem(
          icon: _getNotificationIcon(notification['type']),
          iconColor: _getNotificationColor(notification['type']),
          user: notification['user'],
          handle: notification['handle'],
          isVerified: notification['isVerified'],
          content: notification['content'],
          tweet: notification['tweet'],
          time: notification['time'],
        );
      },
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String user;
  final String handle;
  final bool isVerified;
  final String content;
  final String? tweet;
  final String time;

  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.user,
    required this.handle,
    required this.isVerified,
    required this.content,
    this.tweet,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
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
            Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.borderColor,
                        child: Text(
                          user[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: user,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (isVerified) ...[
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.verified,
                                color: AppTheme.primaryBlue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                        TextSpan(
                          text: ' $content',
                          style: const TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: ' · $time',
                          style: const TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  if (tweet != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      tweet!,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
