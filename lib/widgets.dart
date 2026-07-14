import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        color: Colors.brown,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          spacing: 10,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}