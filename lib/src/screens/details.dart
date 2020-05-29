import 'package:flutter/material.dart';
import 'package:free/src/models.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key key, this.freela}) : super(key: key);

  final Freela freela;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(freela.name),
        ),
        body: _buildDetails(context));
  }

  Widget _buildDetails(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipOval(
                child: Image.network(freela.image),
              ),
            ),
            _PaddedText(
              freela.name,
              Theme.of(context).textTheme.headline5,
            ),
            _PaddedText('(${freela.city})'),
            RatingBar.readOnly(
              size: 30.0,
              filledColor: Colors.green,
              initialRating: freela.rating,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(freela.category),
            ),
            ListTile(
              onTap: () => _buildActionSheet(context),
              leading: Icon(Icons.phone),
              title: Text(freela.phone),
            ),
            ListTile(
              onTap: () => launch('mailto:${freela.email}'),
              leading: Icon(Icons.email),
              title: Text(freela.email),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text(freela.bio),
            )
          ],
        ),
      ),
    );
  }

  void _buildActionSheet(context) => showModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () => launch('tel:${freela.phone}'),
                leading: Icon(Icons.call),
                title: Text('Realizar chamada'),
              ),
              ListTile(
                onTap: () => launch('sms:${freela.phone}'),
                leading: Icon(Icons.sms),
                title: Text('Enviar SMS'),
              )
            ],
          ));
}

class _PaddedText extends StatelessWidget {
  final String text;
  final TextStyle style;

  _PaddedText(this.text, [this.style]);

  @override
  Widget build(BuildContext context) => Padding(
      child: Text(
        text,
        style: style,
      ),
      padding: EdgeInsets.all(5.0));
}
