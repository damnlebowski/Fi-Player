import 'package:flutter/material.dart';
import '../../widget/drawer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBGColor,
        appBar: AppBar(
          title: const Text('Privacy Policy'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              textAlign: TextAlign.start,
              '''Privacy Policy for Fi Player:

We are committed to protecting the privacy and security of our users. This privacy policy describes how we collect, use, and share information about you when you use our media player.
                  
            
1. Information We Collect
            
When you use our media player, we may collect the following information:
• Usage information: We may collect information about how you use the media player, such as the videos you watch, the features you use, and the settings you choose.
                  
            
2. How We Use Your Information
            
We may use the information we collect for the following purposes:
• To provide and maintain the media player
• To analyze and improve the media player
• To personalize your experience and provide you with relevant content
• To communicate with you and respond to your inquiries and requests
• To protect our rights and the rights of our users
                  
            
3. How We Share Your Information
            
We don't share your information
                  
            
4. Your Choices and Rights
            
You have certain choices and rights regarding the information we collect about you, including the right to access, correct, and delete your personal information. You may also opt-out of certain data collection and use by adjusting your settings in the media player or contacting us directly.
                  
            
5. Data Security
            
We take appropriate measures to protect the security of your information, including physical, electronic, and procedural safeguards. However, no security measures are perfect or impenetrable, and we cannot guarantee the security of your information.
                  
            
6. Changes to This Policy
            
We may update this privacy policy from time to time. We will notify you of any material changes by posting the new policy on the media player.
                  
            
7. Contact Us
            
If you have any questions or concerns about this privacy policy or our data practices, please contact us at damn.lebowski@protonmail.com''',
              style:
                  TextStyle(color: allTextColor, fontSize: 16, wordSpacing: 3),
            ),
          ),
        ));
  }
}
