import 'package:flutter/material.dart';

class RatingDialog {
  static Future<void> showRatingDialog(BuildContext context, ValueNotifier<double> userRating) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rate Our App"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < userRating.value
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 40,
                    ),
                    onPressed: () {
                      if (userRating.value == index + 1) {
                        userRating.value = index as double;
                      } else {
                        userRating.value = index + 1;
                      }
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<double>(
                valueListenable: userRating,
                builder: (context, rating, child) {
                  return Text("Your rating: $rating");
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
