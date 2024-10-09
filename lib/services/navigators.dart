import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> bottomNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Bottom');

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Global');

final GlobalKey<NavigatorState> dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Dashboard');

final GlobalKey<NavigatorState> transactionNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Transaction');

final GlobalKey<NavigatorState> profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'Profile');
