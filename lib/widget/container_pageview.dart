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
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (bloodGroups.length ~/ 4),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final firstItemIndex = index * 4;

                    if (firstItemIndex >= bloodGroups.length) {
                      return Container();
                    }
                    return Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widgets.BloodCard(
                                    bloodGroup: bloodGroups[firstItemIndex],
                                    onTap: () {
                                      String selectedBloodGroup =
                                          bloodGroups[firstItemIndex];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BloodDonorGroup(
                                            selectedBloodGroup:
                                                selectedBloodGroup,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: horizontalSpacing),
                                  widgets.BloodCard(
                                    bloodGroup:
                                        bloodGroups[firstItemIndex + 1],
                                    onTap: () {
                                      String selectedBloodGroup =
                                          bloodGroups[firstItemIndex + 1];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BloodDonorGroup(
                                            selectedBloodGroup:
                                                selectedBloodGroup,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widgets.BloodCard(
                                    bloodGroup:
                                        bloodGroups[firstItemIndex + 2],
                                    onTap: () {
                                      String selectedBloodGroup =
                                          bloodGroups[firstItemIndex + 2];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BloodDonorGroup(
                                            selectedBloodGroup:
                                                selectedBloodGroup,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: horizontalSpacing),
                                  widgets.BloodCard(
                                    bloodGroup:
                                        bloodGroups[firstItemIndex + 3],
                                    onTap: () {
                                      String selectedBloodGroup =
                                          bloodGroups[firstItemIndex + 3];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BloodDonorGroup(
                                            selectedBloodGroup:
                                                selectedBloodGroup,
                                          ),
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
              ),
              
              DotIndicator(
                currentPageIndex: _currentPageIndex,
                pageCount: (bloodGroups.length ~/ 4),
              ),
            ],
          ),
        );
      },
    );
  }
}


class DotIndicator extends StatelessWidget {
  final int currentPageIndex;
  final int pageCount;

  const DotIndicator({
    Key? key,
    required this.currentPageIndex,
    required this.pageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) {
          return Container(
            width: 7.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric( horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPageIndex == index ? MyColors.mycolor4 : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
