import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  final String avatarUrl;

  AvatarProfile({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        avatarUrl, 
        width: 100, 
        height: 100, 
        fit: BoxFit.cover,
      ),
    );
  }
}
