import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:free/src/models.dart';
import 'package:free/src/screens/freelas.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:free/src/utils/net.dart';

class DetailsScreen extends StatefulWidget {
  final Freela freela;

  DetailsScreen(this.freela);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(freela.id);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final int freelaId;
  Freela freela;

  _DetailsScreenState(this.freelaId);

  @override
  void initState() {
    super.initState();

    // Pega os dados do freela antes de tudo...
    _getFreelaData();
  }

  Future<void> _getFreelaData() async {
    var updatedData = await getFreela(freelaId);
    setState(() => freela = updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(freela.name),
        ),
        body: freela == null
            ? Center(child: CircularProgressIndicator())
            : _buildDetails(context));
  }

  Widget _buildDetails(context) => SingleChildScrollView(
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
              _buildLikeInfo(),
              Divider(),
              ListTile(
                leading: Icon(Icons.category),
                title: Text(freela.category),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FreelasScreen(category: freela.category))),
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

  Widget _buildLikeInfo() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButton(
                  icon: freela.liked
                      ? Icon(
                          AntDesign.like1,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(AntDesign.like2),
                  onPressed: () {
                    likeOrDislike(freela, 'like');
                    _like();
                  },
                ),
                Chip(label: Text('${freela.likes}'))
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: freela.disliked
                      ? Icon(
                          AntDesign.dislike1,
                          color: Colors.red,
                        )
                      : Icon(AntDesign.dislike2),
                  onPressed: () async {
                    _dislike();
                    likeOrDislike(freela, 'dislike');
                  },
                ),
                Chip(label: Text('${freela.dislikes}'))
              ],
            ),
          ],
        ),
      );

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

  void _like() {
    // Não pode ter like e dislike ao mesmo tempo...
    if (freela.disliked) _dislike();
    if (freela.liked) {
      setState(() {
        if (freela.likes != 0) freela.likes--;
        freela.liked = false;
      });
    } else {
      setState(() {
        freela.likes++;
        freela.liked = true;
      });
    }
  }

  void _dislike() {
    // Idem...
    if (freela.liked) _like();
    if (freela.disliked) {
      setState(() {
        if (freela.dislikes != 0) freela.dislikes--;
        freela.disliked = false;
      });
    } else {
      setState(() {
        freela.dislikes++;
        freela.disliked = true;
      });
    }
  }
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
