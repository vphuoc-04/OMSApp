import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';

class DataProfile extends StatelessWidget {
  final User userData;

  const DataProfile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userData.firstname}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                '${userData.lastname}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userData.job_title}'
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        InfoRow(icon: Icons.person, label: userData.name ?? 'No Name'),
        InfoRow(icon: Icons.email, label: userData.email ?? 'No Email'),
        InfoRow(icon: Icons.phone, label: userData.phone ?? 'No Phone'),
        InfoRow(icon: Icons.cake, label: userData.birth ?? 'No Birthdate'),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 12, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
