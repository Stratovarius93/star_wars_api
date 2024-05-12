import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_bloc.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_bloc.dart';
import 'package:star_wars_app/injector_container.dart' as di;

List<SingleChildWidget> swBlocs = [
  BlocProvider(create: (context) => di.sl<SWListBloc<Character>>()),
  BlocProvider(create: (context) => di.sl<SWFilmsBloc>()),
];
