import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/screens/home/home_view.dart';
import 'package:flutter/material.dart';

/// A controller for the [HomeRoute].
class HomeController extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) => HomeView(this);
}
