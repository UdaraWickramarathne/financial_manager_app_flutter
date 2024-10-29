import 'package:flutter/material.dart';

class MasterCard3 extends StatelessWidget {
  const MasterCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/mastercard3.png',
            height: 210,
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Anuara Kumara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '•••• •••• •••• ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '4135',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '02/26',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
