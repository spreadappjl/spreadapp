import 'package:flutter/material.dart';
class FollowPage extends StatelessWidget {
  final String title;
  final String _promo;
  final String _data;
  //String data;
  FollowPage( this.title, this._promo, this._data);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark.withOpacity(0.54),
      margin: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.7, top: 0.0),
      child: Column(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children:<Widget>[
              //imagem circular do promoter
              Container(
                margin: EdgeInsets.only(top: 12.0, left: 16.0, right: 20.0, bottom: 15.0),
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_promo),
                  ),
                ),
              ),
              //nome do promoter
              Container(
                margin: EdgeInsets.only(left:70.0),
                child:Column(
                  children: <Widget>[
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    //espaço
                    Divider(
                      height: 5.0,
                    ),
                    Text(
                      _data.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color.withOpacity(.5),
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal
                      ),
                    ),   
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Container(
                          child: Icon(Icons.remove_circle, size: 22.0, 
                          color: Theme.of(context).iconTheme.color.withOpacity(0.7)),
                        ),
                        //compartilhar 
                        Container(
                          margin: const EdgeInsets.only(top:15.0,right:6.0),
                          child: Icon(
                            Icons.share, size: 22.0, 
                            color: Theme.of(context).iconTheme.color.withOpacity(0.7)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
