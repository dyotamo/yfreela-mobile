import 'package:flutter/material.dart';
import 'package:free/src/models.dart';
import 'package:free/src/screens/details.dart';
import 'package:free/src/utils/net.dart';

class FreelaSearch extends SearchDelegate<Freela> {
  FreelaSearch() : super(searchFieldLabel: 'Pesquisar...');

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List>(
      future: searchFreelas(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty)
            return Center(
              child: Text('Sem resultados'),
            );
          return _buildList(context, snapshot.data);
        } else if (snapshot.hasError)
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text(snapshot.error.toString())),
          );
        return Center(child: CircularProgressIndicator());
      });

  Widget _buildList(context, List freelas) => ListView(
        children: freelas
            .map((freela) => Hero(
                  tag: freela.email,
                  child: _buildTile(context, freela),
                ))
            .toList(),
      );

  Widget _buildTile(context, Freela freela) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(freela: freela))),
      leading: CircleAvatar(backgroundImage: NetworkImage(freela.image)),
      title: Text(freela.name),
      subtitle: Text(freela.city),
    );
  }
}
