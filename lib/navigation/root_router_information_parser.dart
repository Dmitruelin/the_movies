import 'package:flutter/material.dart';
import 'package:the_movies/navigation/navigation_cubit.dart';

class RootRouteInformationParser
    extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    return Future.value(const StartPageState());
  }
}
