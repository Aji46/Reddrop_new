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
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (bloodGroups.length ~/ 4),
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },

        // Display 4 items at a time
        itemBuilder: (context, index) {
          final firstItemIndex = index * 4;

          if (firstItemIndex >= bloodGroups.length) {
            // Prevent accessing an index that is out of range
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    widgets.BloodCard(
                      bloodGroup: bloodGroups[firstItemIndex],
                      onTap: () {
                        String selectedBloodGroup = bloodGroups[firstItemIndex];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonorGroup(
                                selectedBloodGroup: selectedBloodGroup),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                        width:
                            40.0), // Adjust the width based on your preference
                    widgets.BloodCard(
                      bloodGroup: bloodGroups[firstItemIndex + 1],
                      onTap: () {
                        String selectedBloodGroup =
                            bloodGroups[firstItemIndex + 1];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonorGroup(
                                selectedBloodGroup: selectedBloodGroup),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // Adjust the height based on your preference
                Row(
                  children: [
                    widgets.BloodCard(
                      bloodGroup: bloodGroups[firstItemIndex + 2],
                      onTap: () {
                        String selectedBloodGroup =
                            bloodGroups[firstItemIndex + 2];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonorGroup(
                                selectedBloodGroup: selectedBloodGroup),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                        width: 40), // Adjust the width based on your preference
                    widgets.BloodCard(
                      bloodGroup: bloodGroups[firstItemIndex + 3],
                      onTap: () {
                        String selectedBloodGroup =
                            bloodGroups[firstItemIndex + 3];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodDonorGroup(
                                selectedBloodGroup: selectedBloodGroup),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
