import 'package:flutter/material.dart';

class ColorResources {

  static const Map<String, Color> buttonBackgroundColorMap ={
    'pending': Color(0xffE6EFF6),
    'accepted': Color(0xffEAF4FF),
    'ongoing': Color(0xffEAF4FF),
    'completed': Color(0xffE8F8EE),
    'canceled': Color(0xffFFEBEB),
    'approved': Color(0xffFFEBEB),
    'denied': Color(0xffFFEBEB),
  };

  static const Map<String, Color> buttonTextColorMap ={
    'pending': Color(0xff0461A5),
    'accepted': Color(0xff2B95FF),
    'ongoing': Color(0xff2B95FF),
    'completed': Color(0xff16B559),
    'canceled': Color(0xffFF3737),
    'approved': Color(0xff16B559),
    'denied':  Color(0xffFF3737),
  };

}