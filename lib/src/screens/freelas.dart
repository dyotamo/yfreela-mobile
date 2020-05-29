import 'package:flutter/material.dart';
import 'package:free/src/models.dart';
import 'package:free/src/screens/details.dart';
import 'package:free/src/utils/net.dart';

class FreelasScreen extends StatelessWidget {
  FreelasScreen({Key key, this.category}) : super(key: key);

  final category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder<List>(
        future: getFreelas(category),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return _buildList(context, snapshot.data);
          else if (snapshot.hasError)
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
              )),
            );
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(context, List freelas) => ListView(
        children: freelas
            .map((freela) => Hero(
                  tag: freela.email,
                  child: _buildTile(context, freela),
                ))
            .toList(),
      );

  Widget _buildTile(context, Freela freela) => ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(freela: freela))),
        leading: CircleAvatar(backgroundImage: NetworkImage(freela.image)),
        title: Text(freela.name),
        subtitle: Text(freela.city),
      );
}
