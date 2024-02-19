import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/bloodgroups.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/widget/wigets.dart' as widgets;

class Containerpageview extends StatefulWidget {
  const Containerpageview({super.key});
  @override
  State<Containerpageview> createState() => _ContainerpageviewState();
}
class _ContainerpageviewState extends State<Containerpageview> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardWidth = screenWidth < 400 ? 70.0 : 100.0;
        final cardHeight = screenWidth < 400 ? 55.0 : 80.0;
        final horizontalSpacing = screenWidth < 400 ? 20.0 : 40.0;
        
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10), // Add space at the top
              Wrap(
                alignment: WrapAlignment.center,
                spacing: horizontalSpacing,
                runSpacing: 10.0, // Adjust as needed
                children: [
                  for (String bloodGroup in bloodGroups) ...[
                    widgets.BloodCard(
                      bloodGroup: bloodGroup,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonorGroup(
                              selectedBloodGroup: bloodGroup,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
