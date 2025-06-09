import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double width;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final VoidCallback? onTapped;
  final bool setBorderRadius;

  const CustomButton({super.key, 
    required this.width, required this.height, required this.buttonColor, required this.buttonText,
    required this.onTapped, required this.setBorderRadius, this.textColor = Colors.black
  });

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {

  @override void initState(){
    super.initState();
  }

  @override void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width, height: widget.height,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.onTapped == null ? Colors.white.withOpacity(0.5) : widget.buttonColor,
          borderRadius: widget.setBorderRadius ? const BorderRadius.all(Radius.circular(20)) : BorderRadius.zero
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: (){
              widget.onTapped!();
            },
            child: Center(
              child: Text(widget.buttonText, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: widget.textColor))
            )
          ),
        ),
      )
    );
  }

}
