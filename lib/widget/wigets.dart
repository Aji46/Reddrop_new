import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/policy/termsandpolicy.dart';

//App bar
//.............................
class CustomAppBar {
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Red',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontFamily: 'Italiana',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Drop ',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Italiana',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: PopupMenuButton(
                      itemBuilder: (context) => [   
                            PopupMenuItem(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Pryvacypage(),
                                      ));
                                },
                                child: const Text('Terms & policy')),
                          ],
                      child: const Icon(
                        Icons.more_vert,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
        ),
      ],
    );
  }
}

//grid pages blood boxes
//.......................................
class BloodCard extends StatelessWidget {
  const BloodCard({Key? key, required this.bloodGroup, required this.onTap})
      : super(key: key);

  final String bloodGroup;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 400 ? 80.0 : 100.0;
    final cardHeight = screenWidth < 400 ? 60.0 : 80.0;
    final avatarRadius = screenWidth < 400 ? 20.0 : 30.0;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 190, 24, 24),
            radius: avatarRadius,
            child: Text(
              bloodGroup,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//grid pages container decoration
//.......................................
class MyDecorations {
  static  BoxDecoration pageContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow:  const [
      BoxShadow(
        color: Color.fromARGB(95, 104, 41, 41),
        blurRadius: 20,
      )
    ],
  );

 static BoxDecoration bottomContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: const [
    BoxShadow(
      color: Color.fromARGB(95, 19, 82, 153), // Set alpha to 255 for full opacity
      blurRadius: 20,
    ),
  ],
);

}

//grid pages container text
//.......................................
class MyButton extends MaterialButton {
  final String text;
  final VoidCallback onTap;

  MyButton({required this.text, required this.onTap})
      : super(
          onPressed: onTap,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            text,
            style: const TextStyle(color: MyColors.mycolor3, fontSize: 30,fontWeight:FontWeight.bold ),
          ),
        );
}

