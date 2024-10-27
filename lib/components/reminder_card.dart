import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({super.key});

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard>
    with SingleTickerProviderStateMixin {
  double _borderRadius = 15.0;
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
    _slidableController.animation.addListener(() {
      if (_slidableController.animation.value > 0) {
        setState(() {
          _borderRadius = 0.0;
        });
      } else {
        setState(() {
          _borderRadius = 15.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
        right: 20,
        bottom: 20,
      ),
      child: Slidable(
        controller: _slidableController,
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(179, 69, 109, 254),
              ),
            ),
            const SizedBox(width: 20),
            const Column(
              children: [
                Text(
                  '06',
                  style: TextStyle(fontSize: 20),
                ),
                Text('THU'),
              ],
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    bottomLeft: const Radius.circular(15),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Yoga',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.notifications_outlined,
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '16:40',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text('Every week'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
