

import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';

class BloodCard extends StatelessWidget {
  const BloodCard({Key? key, required this.bloodGroup, required this.onTap})
      : super(key: key);

  final String bloodGroup;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.mycolor2,
        boxShadow: const [
          BoxShadow(
            color: MyColors.mycolor5,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
            backgroundColor: MyColors.mycolor4,
            radius: 30,
            child: Text(
              bloodGroup,
              style: const TextStyle(
                color: MyColors.mycolor2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
