import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resep_makanan/model/resep.dart';
import 'package:resep_makanan/views/widget/resep_card.dart';

class DetailResep extends StatelessWidget {
  final String name;
  final String images;
  final String rating;
  final String totalTime;
  final String description;
  final String videoUrl;
  final List<Instructions> instructions;
  final List<Section> sections;

  DetailResep({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.description,
    required this.videoUrl,
    required this.instructions,
    required this.sections,
  });

  TextEditingController nama = TextEditingController();
  TextEditingController coment = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  create() async {
    try {
      await firebase
          .collection("User")
          .doc(nama.text)
          .set({"nama": nama.text, "coment": coment.text});
    } catch (e) {
      print(e);
    }
  }

  update() async {
    try {
      firebase
          .collection("User")
          .doc(nama.text)
          .update({'coment': coment.text});
    } catch (e) {
      print(e);
    }
  }

  delete() async {
    try {
      firebase.collection("User").doc(nama.text).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Komentar Saya')
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ResepCard(
                  title: name,
                  cookTime: totalTime,
                  rating: rating,
                  thumbnailUrl: images,
                  videoUrl: videoUrl,
                  /* instructions: [],
                  sections: [], */
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(description,
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.justify),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Instruction",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: instructions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(instructions[index].displayText),
                              );
                            },
                          )),
                      TextField(
                          controller: nama,
                          decoration: InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: coment,
                        decoration: InputDecoration(
                            labelText: "Komentar",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                create();
                                nama.clear();
                                coment.clear();
                              },
                              child: Text("Create")),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.amber),
                              onPressed: () {
                                update();
                                nama.clear();
                                coment.clear();
                              },
                              child: Text("Update")),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                delete();
                                nama.clear();
                                coment.clear();
                              },
                              child: Text("Delete")),
                        ],
                      ),
                    ],
                  ),
                ),
                /*     Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  height: 300,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firebase.collection("User").snapshots(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return Text(x['nama']);
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                )
 */
                /*  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: instructions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(instructions[index].displayText),
                              );
                            },
                          )), 
                    ], */
                /*    ],
                  ),
                ) */
              ],
            ),
          ),
        ));
  }
}
