import 'package:fi_player/widget/drawer.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(
        title: const Text('Terms And Conditions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('''Terms and Conditions for Video Player:

These terms and conditions ("Agreement") govern your use of the Fi player ("Player") provided by us. By using the Player, you agree to be bound by this Agreement. If you do not agree to this Agreement, you may not use the Player.

1. License
We grant you a limited, non-exclusive, non-transferable license to use the Player solely for the purpose of streaming video content in accordance with this Agreement.

2. User Conduct
You may not use the Player for any unlawful purpose or in any manner that could damage, disable, overburden, or impair the Player. You may not use the Player to transmit any content that is infringing, defamatory, obscene, or otherwise offensive.

3. Intellectual Property
The Player and all content and materials associated with the Player, including but not limited to text, graphics, logos, images, and software, are the property of us or our licensors and are protected by intellectual property laws.

4. Warranty Disclaimer
The Player is provided "as is" and without warranty of any kind. We do not warrant that the Player will be uninterrupted or error-free. We disclaim all warranties, whether express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, and non-infringement.

5. Limitation of Liability
We shall not be liable for any damages arising out of or in connection with your use of the Player, including but not limited to direct, indirect, incidental, special, or consequential damages.

6. Indemnification
You agree to indemnify and hold us harmless from and against any and all claims, damages, liabilities, costs, and expenses arising out of or in connection with your use of the Player.

7. Termination
We may terminate this Agreement at any time without notice. Upon termination, you must cease all use of the Player and destroy all copies of the Player in your possession.

8. Modification
We reserve the right to modify this Agreement at any time without notice. Your continued use of the Player following any such modification constitutes your agreement to be bound by the modified Agreement.

9. Entire Agreement
This Agreement constitutes the entire agreement between you and us with respect to the subject matter hereof and supersedes all prior and contemporaneous agreements and understandings, whether written or oral.

If you have any questions or concerns about this Agreement, please contact us at damn.lebowski@protonmail.com.''',
              style:
                  TextStyle(color: allTextColor, fontSize: 16, wordSpacing: 3)),
        ),
      ),
    );
  }
}
