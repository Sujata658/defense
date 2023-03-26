import 'package:flutter/material.dart';
import '../auth/signin.dart';
import '../components/constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usermode = 'user';
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
        backgroundColor: ktheme,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Viewing as $usermode',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ktheme, // text color
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text('Go to driver mode.'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(String title, String content, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(content),
              ],
            ),
          ),
          SizedBox(width: 16),
          Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
