import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:free/src/screens/freelas.dart';
import 'package:free/src/screens/login.dart';
import 'package:free/src/utils/constants.dart';
import 'package:free/src/utils/delegate.dart';
import 'package:free/src/utils/net.dart';

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
          _buildPopupMenu(context)
        ],
      ),
      body: FutureBuilder<List>(
        future: getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return _buildGrid(context, snapshot.data);
          else if (snapshot.hasError)
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
              ),
            ));
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildGrid(context, List categories) => OrientationBuilder(
        builder: (context, orientation) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: (orientation == Orientation.landscape) ? 6 : 4,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildTile(context, categories[index]),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
        ),
      );

  Widget _buildTile(context, category) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FreelasScreen(category: category))),
        child: Card(
          elevation: 5.0,
          child: Container(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Center(
                child: Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ),
        ),
      );

  Widget _buildPopupMenu(context) => PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: Choices.MY_PROFILE,
            child: Text('Login'),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case Choices.LOGIN:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              break;
          }
        },
      );
}
