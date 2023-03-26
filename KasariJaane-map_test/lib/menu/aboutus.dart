import 'package:flutter/material.dart';
import 'package:kasarijaane/components/constants.dart';

class Developer {
  final String name;
  final String position;
  final String bio;
  final String photo;

  Developer({
    required this.name,
    required this.position,
    required this.bio,
    required this.photo,
  });
}

final List<Developer> developers = [
  Developer(
      name: 'Smriti karki',
      position: 'Backend Development',
      bio:
          'John has over 10 years of experience in software development. He is an expert in Flutter, React Native, and other cross-platform development frameworks.',
      photo:
          'https://media.licdn.com/dms/image/C5603AQFYX5dk1MyQCQ/profile-displayphoto-shrink_800_800/0/1662094551419?e=1684972800&v=beta&t=n6AogYxB0XjuIPT5qQq-sljtjQP3k9GDsKMOL_Gozjw'),
  Developer(
    name: 'Sujata Chaudhary',
    position: 'Frontend Development',
    bio:
        'Jane is a talented designer with a passion for creating beautiful and intuitive user interfaces. She has worked on a number of successful mobile app projects.',
    photo:
        'https://scontent.fktm3-1.fna.fbcdn.net/v/t39.30808-6/332304851_739396224485144_6892657727829939851_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ENKvHCFe83kAX8Sdy12&_nc_ht=scontent.fktm3-1.fna&oh=00_AfCVjFz2ZqWea41kL8UlMUDSUv7Jl8yg4diQzEgttyH2hQ&oe=641E8E33',
  ),
  Developer(
    name: 'Roshan Jha',
    position: 'Data Collection',
    bio:
        'Bob is a skilled backend developer with experience in building scalable . He is proficient in Python, Node.js, and other backend technologies.',
    photo:
        'https://media.licdn.com/dms/image/C4D03AQFWwNoPDFDn7w/profile-displayphoto-shrink_800_800/0/1652820232452?e=1684972800&v=beta&t=M9Ld5Cci5qLVGcuEE9-I9GHaAvjsc8-qOA4uj5SobgY',
  ),
];

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
        ),
        backgroundColor: ktheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Team',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: developers.length,
                itemBuilder: (BuildContext context, int index) {
                  return DeveloperCard(developer: developers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final Developer developer;

  const DeveloperCard({Key? key, required this.developer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(developer.photo),
            ),
            SizedBox(height: 16),
            Text(
              developer.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              developer.position,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
            Text(
              developer.bio,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
