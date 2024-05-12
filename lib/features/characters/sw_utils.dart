// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/data_base/base_data_bloc.dart';
import 'package:star_wars_app/features/characters/data/model/sw_update_params.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_bloc.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_params.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_bloc.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_event.dart';

class SWUtils {
  SWUtils._internal();
  static final SWUtils _instance = SWUtils._internal();
  static SWUtils get instance => _instance;
  _Character<Character> get character => _Character<Character>();
  _Films get films => _Films();
}

class _Character<T> {
  Future<void> update(
    BuildContext context,
    SWUpdateParams? params,
  ) async {
    context.read<SWListBloc<T>>()
      ..add(SWListResetEvent<T>())
      ..add(
        SWListFetchEvent<T>(
          clearList: true,
        ),
      );
  }

  Future<void> fetch(
    BuildContext context,
    SWUpdateParams? params,
  ) async {
    BlocProvider.of<SWListBloc<T>>(context).add(
      SWListFetchEvent<T>(
        totalItems: params?.totalItems,
      ),
    );
  }

  Future<void> clear(BuildContext context) async {
    BlocProvider.of<SWListBloc<T>>(context).add(SWListResetEvent<T>());
  }
}

class _Films {
  Future<void> update(BuildContext context, List<int> ids) async {
    context.read<SWFilmsBloc>().add(CallAction(
            params: SWFilmsParams(
          ids: ids,
        )));
  }

  Future<void> fetch(BuildContext context, List<int> ids) async {
    context.read<SWFilmsBloc>().add(CallAction(
            params: SWFilmsParams(
          ids: ids,
        )));
  }

  Future<void> clear(BuildContext context) async {
    context.read<SWFilmsBloc>().add(const RestoreData());
  }
}
