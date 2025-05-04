import 'package:expensetracker/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../screens/add_screen.dart';
import '../screens/analytics_screen.dart';
import '../screens/home_screen.dart';

class MyNavBar extends StatefulWidget {
  final int index;
  final Function(int)? onIndexChanged;

  const MyNavBar({super.key, required this.index, this.onIndexChanged});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor:
          AppColors.primaryIconColor, // Color for selected icon and label
      unselectedItemColor:
          AppColors.secondaryIconColor, // Color for unselected icon and label
      selectedLabelStyle: TextStyle(
        color: AppColors.primaryIconColor, // Color for selected label
        fontSize: AppSizes.tertiaryFontSize, // Font size for selected label
        fontWeight: FontWeight.bold, // Font weight for selected label
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.secondaryIconColor, // Color for unselected label
        fontSize: AppSizes.tertiaryFontSize, // Font size for unselected label
      ),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded), label: 'Home', tooltip: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Transactions',
            tooltip: "Transactions"),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics), label: 'Stats', tooltip: "Stats"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add), label: 'Add', tooltip: "Add"),
      ],
      onTap: (index) {
        if (widget.index != index) {
          if (widget.onIndexChanged != null) {
            widget.onIndexChanged!(index);
          }
          switch (index) {
            case 0:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const HomeScreen(),
                  transitionDuration: Duration.zero, // No transition duration
                  reverseTransitionDuration:
                      Duration.zero, // No reverse transition duration
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const TransactionsScreen(),
                  transitionDuration: Duration.zero, // No transition duration
                  reverseTransitionDuration:
                      Duration.zero, // No reverse transition duration
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const AnalyticsScreen(),
                  transitionDuration: Duration.zero, // No transition duration
                  reverseTransitionDuration:
                      Duration.zero, // No reverse transition duration
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ServicesScreen(),
                  transitionDuration: Duration.zero, // No transition duration
                  reverseTransitionDuration:
                      Duration.zero, // No reverse transition duration
                ),
              );
              break;
          }
        }
      },
    );
  }
}
