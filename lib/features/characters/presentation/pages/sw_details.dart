import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/data_base/base_data_bloc.dart';
import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_films.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_bloc.dart';
import 'package:star_wars_app/features/characters/sw_utils.dart';

class SWItemDetailsPage extends StatefulWidget {
  const SWItemDetailsPage({super.key, required this.character});
  final Character character;

  @override
  State<SWItemDetailsPage> createState() => _SWItemDetailsPageState();
}

class _SWItemDetailsPageState extends State<SWItemDetailsPage> {
  List<int> ids = [];
  @override
  void initState() {
    ids = filmIds(widget.character.films);
    SWUtils.instance.films.fetch(context, ids);
    super.initState();
  }

  List<int> filmIds(List<String> films) {
    if (films.isEmpty) return [];
    return films.map((filmUrl) {
      List<String> parts = filmUrl.split("/");
      String idString = parts[parts.length - 2];
      int id = int.tryParse(idString) ?? 0;
      return id;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(widget.character.name.substring(0, 2),
                style: TextStyle(
                    fontSize: 96,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.character.name,
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).primaryColor)),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.character.gender.toName,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                )),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Movies',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor)),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<SWFilmsBloc, BaseDataState<List<Film>>>(
            builder: (context, state) {
              if (state.status.isNoInternet) {
                return const Center(child: Text('No internet'));
              }
              if (state.status.isError) {
                return const Center(child: Text('Error'));
              }
              if (state.status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Film> films = state.value ?? [];
              if (films.isEmpty) {
                return const Center(child: Text('No data found'));
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return ListTile(
                      title: Text(film.title),
                      subtitle: Text('Director: ${film.director}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
