import 'package:flutter/material.dart';
import 'package:resep_makanan/model/resep.dart';
import 'package:resep_makanan/views/detail_video.dart';
import 'package:resep_makanan/views/komentarya.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    firebase.collection("User").doc(nama.text).update({'coment': coment.text});
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

class komentarya extends StatelessWidget {
  const komentarya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Komentar')
          ],
        )),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            delete();
                            nama.clear();
                            coment.clear();
                          },
                          child: Text("Delete")),
                    ],
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: firebase.collection("User").snapshots(),
                          builder: (context, snapshot) {
                            /* print(snapshot.data); */
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return ListTile(
                                      title: Text(x['nama']),
                                      subtitle: Text(x['coment']),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
    // ignore: dead_code
  }
}
