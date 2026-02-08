import 'package:flutter/material.dart';
import '../models/tweet.dart';
import '../theme/app_theme.dart';
import '../widgets/tweet_card.dart';
import '../widgets/compose_tweet_sheet.dart';
import 'drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Tweet> _tweets = [
    const Tweet(
      id: '1',
      username: 'Elon Musk',
      handle: 'elonmusk',
      avatarUrl: '',
      content: 'The future of AI is incredibly exciting. We are on the verge of creating something truly remarkable. 🚀',
      timeAgo: '2h',
      likes: 125000,
      retweets: 23400,
      replies: 8700,
      views: 2500000,
      isVerified: true,
    ),
    const Tweet(
      id: '2',
      username: 'Flutter Dev',
      handle: 'flutterdev',
      avatarUrl: '',
      content: 'Flutter 3.x is here! Build beautiful apps for iOS, Android, web, and desktop from a single codebase. 💙\n\n#FlutterDev #MobileDevelopment',
      timeAgo: '4h',
      likes: 8500,
      retweets: 2100,
      replies: 450,
      views: 98000,
      isVerified: true,
    ),
    const Tweet(
      id: '3',
      username: 'Tech News',
      handle: 'technews',
      avatarUrl: '',
      content: 'BREAKING: Major tech companies announce new AI initiatives for 2025. This could change everything we know about machine learning.',
      timeAgo: '6h',
      likes: 3200,
      retweets: 890,
      replies: 156,
      views: 45000,
      isVerified: true,
    ),
    const Tweet(
      id: '4',
      username: 'Sarah Developer',
      handle: 'sarahcodes',
      avatarUrl: '',
      content: 'Just shipped my first Flutter app to production! 🎉 The developer experience is amazing. Hot reload is a game changer.',
      timeAgo: '8h',
      likes: 1250,
      retweets: 145,
      replies: 89,
      views: 12000,
      isVerified: false,
    ),
    const Tweet(
      id: '5',
      username: 'Design Matters',
      handle: 'designmatters',
      avatarUrl: '',
      content: 'Great UI is invisible. Great UX makes users smile. Never forget the human element in your designs. ✨',
      timeAgo: '10h',
      likes: 5600,
      retweets: 1200,
      replies: 234,
      views: 67000,
      isVerified: true,
    ),
    const Tweet(
      id: '6',
      username: 'Coffee & Code',
      handle: 'coffeeandcode',
      avatarUrl: '',
      content: 'Morning routine:\n☕ Coffee\n💻 Code\n🐛 Debug\n🔄 Repeat\n\nWho else can relate?',
      timeAgo: '12h',
      likes: 2800,
      retweets: 456,
      replies: 123,
      views: 34000,
      isVerified: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showComposeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ComposeTweetSheet(
        onPost: (content) {
          setState(() {
            _tweets.insert(
              0,
              Tweet(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                username: 'You',
                handle: 'yourhandle',
                avatarUrl: '',
                content: content,
                timeAgo: 'now',
                likes: 0,
                retweets: 0,
                replies: 0,
                views: 0,
                isVerified: false,
              ),
            );
          });
        },
      ),
    );
  }

  void _toggleLike(int index) {
    setState(() {
      final tweet = _tweets[index];
      _tweets[index] = tweet.copyWith(
        isLiked: !tweet.isLiked,
        likes: tweet.isLiked ? tweet.likes - 1 : tweet.likes + 1,
      );
    });
  }

  void _toggleRetweet(int index) {
    setState(() {
      final tweet = _tweets[index];
      _tweets[index] = tweet.copyWith(
        isRetweeted: !tweet.isRetweeted,
        retweets: tweet.isRetweeted ? tweet.retweets - 1 : tweet.retweets + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
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
          '𝕏',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
            Tab(text: 'For you'),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            color: AppTheme.primaryBlue,
            child: ListView.builder(
              itemCount: _tweets.length,
              itemBuilder: (context, index) {
                return TweetCard(
                  tweet: _tweets[index],
                  onLike: () => _toggleLike(index),
                  onRetweet: () => _toggleRetweet(index),
                  onReply: () {},
                  onTap: () {},
                );
              },
            ),
          ),
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            color: AppTheme.primaryBlue,
            child: ListView.builder(
              itemCount: _tweets.where((t) => t.isVerified).length,
              itemBuilder: (context, index) {
                final verifiedTweets = _tweets.where((t) => t.isVerified).toList();
                final tweetIndex = _tweets.indexOf(verifiedTweets[index]);
                return TweetCard(
                  tweet: verifiedTweets[index],
                  onLike: () => _toggleLike(tweetIndex),
                  onRetweet: () => _toggleRetweet(tweetIndex),
                  onReply: () {},
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showComposeSheet,
        backgroundColor: AppTheme.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
