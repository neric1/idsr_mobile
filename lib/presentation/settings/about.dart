import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔷 Logo (optional)
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child:    Image.asset('assets/logo2.png',height: 200,width: 200,fit: BoxFit.contain,),

            ),

            const SizedBox(height: 12),

            const Text(
              "SEMS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            const Text("Version 1.0.3"),

            const SizedBox(height: 20),

            // ✅ About Card
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 8),
                      Text(
                        "About This App",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This application is developed in collaboration with WHO AFRO.\n\n"
                        "The app supports public health monitoring by providing access to outbreak and surveillance data across the African region.\n\n"
                        "All information is sourced from official WHO platforms and national Ministries of Health.\n\n"
                       "The application is currently published under an individual developer account and is not an official WHO-owned Play Store account.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔗 Sources Card
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.link),
                      SizedBox(width: 8),
                      Text(
                        "Official Sources",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  _linkItem(
                    title: "WHO AFRO",
                    url: "https://www.afro.who.int/",
                  ),

                  _linkItem(
                    title: "WHO Disease Outbreak News",
                    url:
                    "https://www.who.int/emergencies/disease-outbreak-news",
                  ),
                  _linkItem(
                    title: "WHO AFRO IDSR Data",
                    url:
                    "https://idsr.afro.who.int",
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),

             Text(
              "© ${DateTime.now().year} WHO AFRO. All rights reserved.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Card Widget
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  // 🔹 Link item
  Widget _linkItem({required String title, required String url}) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => _openUrl(url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const Icon(Icons.open_in_new, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}