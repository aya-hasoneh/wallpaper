import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedButton extends StatelessWidget {
  Icon? icon;
  Color? colors;
  VoidCallback? onPressed;

  SharedButton({Key? key,required this.icon,required this.colors,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 100.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: colors,boxShadow: [
          BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 5)
          )
        ]),
        child: icon,
      ),
    );
  }
}
