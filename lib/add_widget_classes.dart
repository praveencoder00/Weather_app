import 'dart:ui';

import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String value;

  const AddInfo({
    required this.icon,
    required this.lable,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 33,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            lable,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class Forecast extends StatelessWidget {
  final IconData icon;
  final String degree;
  final String condition;
  final String time;
  const Forecast(
      {required this.condition,
      required this.degree,
      required this.icon,
      super.key,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    degree,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Icon(
                    icon,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    condition,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
