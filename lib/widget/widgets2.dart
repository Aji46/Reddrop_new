import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/navigator/navigator.dart';

class DonorListWidget extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;
  final List<DocumentSnapshot> donors;

  const DonorListWidget({super.key, 
    required this.listKey,
    required this.donors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: donors.length,
      itemBuilder: (context, index, animation) {
        if (index >= donors.length) return const SizedBox.shrink();
        final DocumentSnapshot donorSnap = donors[index];
        return buildDonorListItem(context, donorSnap, animation);
      },
    );
  }

  Widget buildDonorListItem(BuildContext context, DocumentSnapshot donorSnap, Animation<double> animation) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth > 600 ? 35.0 : 30.0;
    double fontSizeTitle = screenWidth > 600 ? 22.0 : 20.0;
    double fontSizeSubtitle = screenWidth > 600 ? 17.0 : 15.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.mycolor2,
            boxShadow: const [BoxShadow(color: MyColors.mycolor5, blurRadius: 10)],
          ),
          child: InkWell(
            onTap: () => navigateToViewDonor(context, donorSnap),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),
                CircleAvatar(
                  backgroundColor: MyColors.mycolor4,
                  radius: avatarRadius,
                  child: Text(
                    donorSnap['group'] as String? ?? '',
                    style: const TextStyle(color: MyColors.mycolor2, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        donorSnap['name'] as String? ?? '',
                        style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        donorSnap['phone'].toString(),
                        style: TextStyle(fontSize: fontSizeSubtitle),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    PhoneUtils.shareContact(donorSnap['phone'] as String? ?? '');
                  },
                  tooltip: 'Share',
                  icon: const Icon(Icons.share_outlined),
                  color: MyColors.mycolor3,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({super.key, 
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double paddingValue = screenWidth > 600 ? 50 : 30;

    return Padding(
      padding: EdgeInsets.only(top: 20, right: paddingValue, left: paddingValue),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
          keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: MyColors.mycolor2,
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(color: MyColors.mycolor7),
        ),
        validator: validator,
      ),
    );
  }
}


