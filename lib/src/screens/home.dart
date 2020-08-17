import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:free/src/models.dart';
import 'package:free/src/screens/details.dart';
import 'package:free/src/utils/delegate.dart';
import 'package:free/src/utils/net.dart';
import 'package:grouped_list/grouped_list.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: FreelaSearch()),
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: allFreelas(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return _buildList(context, snapshot.data);
          else if (snapshot.hasError)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MaterialCommunityIcons.access_point_network_off,
                    size: 75.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Problemas no acesso aos dados.',
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            );
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(context, freelas) => GroupedListView<Freela, String>(
      elements: freelas,
      groupBy: (question) => question.category,
      groupSeparatorBuilder: (category) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              category,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
      itemBuilder: (context, question) => _buildTile(context, question));

  Widget _buildTile(context, Freela freela) => ListTile(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsScreen(freela))),
        leading: CircleAvatar(backgroundImage: NetworkImage(freela.image)),
        title: Text(freela.name),
        subtitle: Text(freela.city),
      );
}
