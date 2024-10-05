import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const BigButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xff2A291E),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Color(0xffEEEEEE)),
          backgroundColor: WidgetStatePropertyAll(Color(0xff2A291E)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 110,),
            SizedBox(height: 10),
            Text(text,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
          ],
        ),
      ),
    );
  }
}
