// ignore_for_file: prefer_const_constructors

import 'package:education_app/resources/exports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Profile',
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      // backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text('Muhammad Anfal',
                        style: AppTextStyle.profileTitleText),
                    Text('anfalshah72@gmail.com',
                        style: AppTextStyle.profileSubTitleText),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              SizedBox(height: 20),
              Text('Account Settings', style: AppTextStyle.profileTitleText),
              SizedBox(height: 10),
              ProfileActionButton(
                icon: Icons.person,
                text: 'Edit Profile',
                onPressed: () {},
              ),
              ProfileActionButton(
                icon: Icons.lock,
                text: 'Change Password',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
