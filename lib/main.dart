import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:spreadapp/config/loginPage.dart' as login;
import 'package:spreadapp/config/theme.dart' as Temas;
import 'package:spreadapp/services/auth.service.dart';
import './config/firebasePost.dart';
import './config/firebaseFollows.dart';
import './config/firebaseSaves.dart';
import './config/search.dart';
import 'dart:async';
import 'dart:math';

const api_key = "AIzaSyDQIQ6TK-F0NCvvVvx-eaeqPVUL1K0ClPE";

AuthService appAuth = AuthService();
void main() async {
  Widget _defaultHome = login.LoginPage();
  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = HomePage();
  }
  MapView.setApiKey(api_key);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => login.LoginPage(),
      }));
}

class HomePage extends StatefulWidget {
  //final FacebookLogin facebookSignIn;
  @override
  _HomePageState createState() => _HomePageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser mCurrentUser;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  _getCurrentUser() async {
    mCurrentUser = await _auth.currentUser();
    print('Hello'.toString());
    setState(() {
      mCurrentUser != null ? mCurrentUser = mCurrentUser : print('não logado');
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    random = Random();
    refreshList();
    _getCurrentUser();
  }

  TabController _tabController;
  //ScrollController _scrollViewController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Random random;
  List<String> list;

  // new Future.delayed(const Duration(seconds: 2));
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });
    return null;
  }

  bool lightThemeEnabled = true;
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeEnabled ? Temas.SpreadLight : Temas.SpreadDark,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget HomePage() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: TabBar(
          indicatorWeight: 1.5,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(
              fontSize: 9.0,
              fontFamily: 'MontSerrat',
              fontWeight: FontWeight.bold),
          indicatorColor: Colors.blue,
          unselectedLabelColor:
              lightThemeEnabled ? Colors.black.withOpacity(0.7) : Colors.grey,
          labelColor: Colors.blue[400],
          controller: _tabController,
          tabs: <Widget>[
            SizedBox(
              height: 58.0,
              child: Tab(
                icon: Icon(Icons.people, size: 23.0),
                text: 'PROMOTERS',
              ),
            ),
            SizedBox(
              height: 58.0,
              child: Tab(
                icon: Icon(Icons.home, size: 23.0),
                text: 'INÍCIO',
              ),
            ),
            SizedBox(
              height: 58.0,
              child: Tab(
                icon: Icon(Icons.favorite_border, size: 23.0),
                text: 'SALVOS',
              ),
            ),
          ],
        ),
        appBar: AppBar(
          leading: Image.asset('android/assets/logo-completa.png'),
          elevation: 0.0,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 6.0),
              child: Switch(
                value: lightThemeEnabled,
                onChanged: (changed) {
                  setState(() {
                    lightThemeEnabled = changed;
                  });
                },
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.tune), //color: Theme.of(context).iconTheme.color),
              onPressed: () {},
              tooltip: 'Filtrar',
            ),
            IconButton(
              icon: Icon(
                  Icons.search), // color: Theme.of(context).iconTheme.color),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              tooltip: 'Buscar',
            ),
            IconButton(
                icon: Icon(Icons
                    .account_circle), // color: Theme.of(context).iconTheme.color),
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                }),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(''),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 3.0,
                              color: Theme.of(context).secondaryHeaderColor,
                              offset: Offset(0.0, 0.3),
                            ),
                          ],
                        ),
                      ),
                      Text('displayName'),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Histórico'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.note),
                title: Text('Termos de Uso e Privacidade'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () {
                  appAuth.logout().then((_) =>
                      Navigator.of(context).pushReplacementNamed('/login'));
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            FollowList(),
            RefreshIndicator(
              key: refreshKey,
              child: PostList(),
              onRefresh: refreshList,
            ),
            SavesList(),
          ],
        ),
      ),
    );
  }
}
