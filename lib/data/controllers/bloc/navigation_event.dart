part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class UpdateNavigator extends NavigationEvent {}
