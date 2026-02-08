import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ComposeTweetSheet extends StatefulWidget {
  final Function(String) onPost;

  const ComposeTweetSheet({
    super.key,
    required this.onPost,
  });

  @override
  State<ComposeTweetSheet> createState() => _ComposeTweetSheetState();
}

class _ComposeTweetSheetState extends State<ComposeTweetSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _canPost = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _canPost = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _canPost
                      ? () {
                          widget.onPost(_controller.text);
                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    disabledBackgroundColor: AppTheme.primaryBlue.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: _canPost ? Colors.white : Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppTheme.borderColor, height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.borderColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      maxLength: 280,
                      autofocus: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        hintText: "What's happening?",
                        hintStyle: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                        counterStyle: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppTheme.borderColor, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _MediaButton(icon: Icons.image_outlined, onTap: () {}),
                _MediaButton(icon: Icons.gif_box_outlined, onTap: () {}),
                _MediaButton(icon: Icons.poll_outlined, onTap: () {}),
                _MediaButton(icon: Icons.emoji_emotions_outlined, onTap: () {}),
                _MediaButton(icon: Icons.schedule_outlined, onTap: () {}),
                _MediaButton(icon: Icons.location_on_outlined, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MediaButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: AppTheme.primaryBlue,
          size: 24,
        ),
      ),
    );
  }
}
