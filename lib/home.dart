import 'package:flutter/material.dart';
import 'package:tugas_api_123210141/detail.dart';
import 'package:tugas_api_123210141/login.dart';
import 'package:tugas_api_123210141/model/HeroDB.dart';
import 'package:tugas_api_123210141/profile.dart';
import 'package:tugas_api_123210141/utils/api_data_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                icon: Icon(Icons.person, color: Colors.white)),
          ],
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: _buildListHeroML(),
        ));
  }

  Widget _buildListHeroML() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadUsers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // Jika data ada error maka akan ditampilkan hasil error
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          HeroDB hero = HeroDB.fromJson(snapshot.data);

          return _buildSuccessSection(hero);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(HeroDB hero) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: hero.hero?.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(hero, index);
      },
    );
  }

  Widget _buildItem(HeroDB hero, int index) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DetailScreen(hero: hero.hero![index]);
            }),
          );
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: Icon(Icons.person, size: 150),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hero.hero![index].heroName ?? 'Unknown'),
                ],
              )
            ],
          ),
        ));
  }

  Widget grid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      // itemCount: topAlbumList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
            );
          },
          child: Card(
            color: Colors.green[100],
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              // child: Image.network(
              // // topAlbumList[index].imageUrls,
              // // fit: BoxFit.cover,
              // ),
            ),
          ),
          // ),
        );
      },
    );
  }
}
