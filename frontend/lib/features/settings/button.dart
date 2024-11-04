import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final Color? color;
  final void Function()? onTap;
  MyButton({super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        width: 200,
        height: 200,
        child:  const Center(child: Text('Click me')),
      ),
    );
  }
}