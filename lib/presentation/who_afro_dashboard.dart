import 'package:flutter/material.dart';
import 'package:idsr/presentation/chart.dart';
import 'package:idsr/presentation/map.dart';

class WhoAfrDashboard extends StatelessWidget {
  const WhoAfrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Quick stats",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                  ),
                ),
                _buildQuickStats(),
                const SizedBox(height: 24),
                const SizedBox(height: 16),
                SizedBox(
                  height: 400,
                  child: MyMapWidget(),
                ),
                SizedBox(height: 20,),
                const SizedBox(height: 24),
                _buildPriorityAndTrends(),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WHO AFRO",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "IDSR Event Tracker",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "Epi Week 47, 2025",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        // const CircleAvatar(radius: 20, backgroundColor: Colors.grey)
      ],
    );
  }

  Widget _buildQuickStats() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statCard("New Events", ["Grade 3", "Grade 2"], [Color(0xFFdb711a),Color(0xFFfd8601)]),
          _statCard("Ongoing Outbreaks", ["Grade 1"], [Color(0xFFbe474c),Color(0xFFfe4740)]),
          _statCard("Humanitarian Events", ["Protracted 3", "Protracted 2"], [Color(0xFF7352b2),Color(0xFF965ff7)]),
          _statCard("Controlled Events", ["Protracted 1"], [Color(0xFF03784c),Color(0xFF029342)]),
        ],
      ),
    );
  }

  Widget _statCard(String title, List<String> levels, List<Color> color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            colors: color,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            for (final l in levels)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Text(l, style: const TextStyle(color: Colors.white, fontSize: 11))),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Africa_satellite_orthographic.jpg/640px-Africa_satellite_orthographic.jpg",
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: _mapButton(Icons.settings),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _mapButton(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _mapButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildPriorityAndTrends() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _priorityCard()),
        const SizedBox(width: 10),
        Expanded(child: _trendsCard()),
      ],
    );
  }

  Widget _priorityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF262b3f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Priority Events", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
          SizedBox(height: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children:[ Row(
              children: [
                Text("Priority Events",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600 ,fontSize: 14),),
                Icon(Icons.check_circle, color: Colors.green,size: 15,)
              ],
            ),
            Text("Kur vesven leconton, ot Kover auil, 2018",style: TextStyle(color: Colors.white,fontSize: 11),),
]
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
              children: [
                Text("Hontolled Avents",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize: 14),),
                Icon(Icons.check_circle, color: Colors.green,size: 15,)
              ],
            ),
              Text("Kur vesven leconion, ot Kover auil, 2016",style: TextStyle(color: Colors.white,fontSize: 11),),

            ]

          ),
        ],
      ),
    );
  }

  Widget _trendsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Trends", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          // Placeholder(fallbackHeight: 150),
          LineChartSample5()
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      ],
    );
  }
}
