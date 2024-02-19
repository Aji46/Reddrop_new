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
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalSpacing = screenWidth < 400 ? 20.0 : 40.0;
        
        return Column(
          children: [
           const SizedBox(height: 10), 
            Wrap(
              alignment: WrapAlignment.center,
              spacing: horizontalSpacing,
              runSpacing: 10.0,
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
        );
      },
    );
  }
}
