import 'package:flutter/material.dart';

class DashboardCustomButton extends StatelessWidget {
  final String buttonText;
  final bool isSelectedButton;
  const DashboardCustomButton({Key? key,required this.buttonText,required this.isSelectedButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: isSelectedButton ? [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
          )
        ]:null,
        color: isSelectedButton ? Theme.of(context).cardColor:Colors.grey.withOpacity(0.2),
      ),
      child:  Center(
        child: Text(
          buttonText,
          style:  TextStyle(
              fontSize: 12,color: isSelectedButton?Theme.of(context).primaryColor:Colors.grey,
              fontWeight: FontWeight.w500),
        ),
      ),

    );
  }
}
