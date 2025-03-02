// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:education_app/resources/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription", style: AppTextStyle.appBarText),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose Your Plan",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Unlock premium features to enhance your learning experience.",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              SubscriptionCard(
                title: "Free Plan",
                price: "\$0/month",
                features: ["Basic Quizzes", "Limited Access", "Ads Included"],
                isRecommended: false,
              ),
              SubscriptionCard(
                title: "Premium Plan",
                price: "\$9.99/month",
                features: [
                  "Unlimited Quizzes",
                  "No Ads",
                  "Exclusive Content",
                  "Personalized Insights"
                ],
                isRecommended: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isRecommended;

  SubscriptionCard(
      {required this.title,
      required this.price,
      required this.features,
      required this.isRecommended});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: isRecommended ? 8 : 4,
        color: isRecommended ? AppColors.primaryColor : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isRecommended ? Colors.white : Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                price,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isRecommended ? Colors.white70 : Colors.grey[800]),
              ),
              SizedBox(height: 10),
              Column(
                children: features
                    .map((feature) => Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: isRecommended
                                    ? Colors.white
                                    : AppColors.primaryColor),
                            SizedBox(width: 8),
                            Text(feature,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isRecommended
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isRecommended ? Colors.white : AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Select Plan",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          isRecommended ? AppColors.primaryColor : Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
