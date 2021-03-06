import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:spreadapp/Home/ComponentsHome/cardinfo.dart';


class SavesList extends StatefulWidget {
  @override
  _SavesListState createState() => _SavesListState();
}

class _SavesListState extends State<SavesList>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  List<String> _savedPosts = [];

  Future<List<String>> getSavedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('ids');
  }

  Future<Null> removeSavedPrefs(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> aux = _savedPosts;
    aux.remove(id);
    updateState(aux);
    prefs.setStringList('ids', aux);
  }

  void updateState(List<String> list) {
    if (list != null)
      setState(() {
        this._savedPosts = list;
      });
  }

  @override
  void initState() {
    getSavedPrefs().then(updateState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(15.0)),
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            elevation: .0,
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                controller: controller,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Buscar em Salvos',
                    hintStyle: TextStyle(
                        textBaseline: TextBaseline.alphabetic, fontSize: 14.0)),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.1),
            height: 50.0,
            padding: EdgeInsets.only(left: 15.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Eventos Salvos',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                  textScaleFactor: .6,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('posts').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text('Loading...'));
                else {
                  //Lista de salvos
                  return new ListView(
                      padding: EdgeInsets.only(top: 11.0),
                      children: snapshot.data.documents
                          .where((DocumentSnapshot document) =>
                              _savedPosts.contains(document.documentID)) //Busca
                          .map((DocumentSnapshot document) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 3.0),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10.0, top: 0.0),
                          child: Column(
                            verticalDirection: VerticalDirection.down,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Title and Image
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //Imagem do evento salvo
                                    GestureDetector(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width /2.9,
                                        height:MediaQuery.of(context).size.height / 8.8,
                                        child: Hero(
                                          tag: (document['card']),
                                          child: Image.network(document['card'],
                                            fit: BoxFit.fill),
                                          ),  
                                      ),
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                          builder: (BuildContext context) =>
                                              CardPage(document.documentID),
                                        ),
                                      ),
                                    ),
                                    //Titulo
                                    Container(
                                      //margin: EdgeInsets.symmetric(horizontal:50.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            document['title'].toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .title,
                                            textScaleFactor: .45,
                                          ),
                                          //espaço entre o título e a data
                                          Divider(
                                            height: 5.0,
                                          ),
                                          Text(
                                            document['data'].toUpperCase(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color
                                                  .withOpacity(.5),
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'MontSerrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //icones de remoção e de compartilhamento
                                    Material(
                                      elevation: 0.8,
                                      shadowColor: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.9),
                                      color: Theme.of(context).backgroundColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            child: Column(
                                              children: <Widget>[
                                                //remover evento salvo
                                                IconButton(
                                                  icon: Container(
                                                    height: 10.0,
                                                    child: Icon(
                                                        Icons.remove_circle,
                                                        size: 20.0),
                                                    //color: Theme.of(context).iconTheme.color.withOpacity(0.7)),
                                                  ),
                                                  onPressed: () {
                                                    removeSavedPrefs(
                                                        document.documentID);
                                                  },
                                                ),
                                                //Share Button
                                                IconButton(
                                                  onPressed: () {},
                                                  //margin: const EdgeInsets.only(top:15.0,right:6.0),
                                                  icon: Container(
                                                    //height: 10.0,
                                                    child: Icon(Icons.share,
                                                        size: 20.0
                                                        //color: Theme.of(context).iconTheme.color.withOpacity(0.7)
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
