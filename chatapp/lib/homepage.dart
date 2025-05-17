import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF00221F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Greeting and Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome back,",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      color: const Color(0xFFFABF02),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFFFABF02),
                    child: Icon(Icons.person, color: Color(0xFF00221F)),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Balance Glass Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFFABF02),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        color: const Color(0xFFFABF02),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$12,340.56",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Scrollable Category Chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _categoryChip("All"),
                    _categoryChip("Food"),
                    _categoryChip("Shopping"),
                    _categoryChip("Bills"),
                    _categoryChip("Travel"),
                    _categoryChip("Entertainment"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Latest Categorized Transactions
              Text(
                "Recent Activity",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: const Color(0xFFFABF02),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _transactionTile(
                    "McDonald's",
                    "\$12.99",
                    "Food",
                    Icons.fastfood,
                  ),
                  _transactionTile(
                    "Amazon",
                    "\$89.00",
                    "Shopping",
                    Icons.shopping_cart,
                  ),
                  _transactionTile(
                    "Netflix",
                    "\$15.99",
                    "Entertainment",
                    Icons.movie,
                  ),
                  _transactionTile(
                    "Uber",
                    "\$25.00",
                    "Travel",
                    Icons.directions_car,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00221F),
        selectedItemColor: const Color(0xFFFABF02),
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _categoryChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(label),
        backgroundColor: const Color(0xFFFABF02),
        labelStyle: GoogleFonts.inter(
          color: const Color(0xFF00221F),
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget _transactionTile(
    String name,
    String amount,
    String category,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF00221F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFABF02), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFABF02), size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  category,
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.playfairDisplay(
              color: const Color(0xFFFABF02),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
