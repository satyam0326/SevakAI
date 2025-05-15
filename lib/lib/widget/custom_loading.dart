import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/csload.json', width: 500);
  }
}

class Animatt extends StatelessWidget {
  const Animatt({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/animatt.json');
  }
}
