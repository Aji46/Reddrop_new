
import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/images/background1.png',
      width: 150,
      height: 150,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomText({super.key, 
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}


class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
final TextInputType keyboardType;

  final bool obscureText;
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,        
    this.obscureText = false,         
    required this.hintText,

  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey), // Adjust border color as needed
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
              ),
              keyboardType: widget.keyboardType,        
              obscureText: widget.obscureText && _obscureText,        
            ),
          ),
          if (widget.obscureText)
            IconButton(
              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
               _obscureText = !_obscureText;
                });
              },
            ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}



class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({super.key, 
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.mycolor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomTextButton({super.key, 
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: MyColors.mycolor7,
          decoration: TextDecoration.underline,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
