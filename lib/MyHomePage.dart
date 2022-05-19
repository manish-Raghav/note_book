import'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import'package:intl/intl.dart';

classMyHomePageextendsStatefulWidget {
constMyHomePage({Key? key}) : super(key: key);

@override
State<MyHomePage>createState() =>_MyHomePageState();
}

class_MyHomePageStateextendsState<MyHomePage> {
varfirestoredb =
FirebaseFirestore.instance.collection("MyData").snapshots(); // STEP 1
lateTextEditingControllernameinput = newTextEditingController();
lateTextEditingControllertitleinput = newTextEditingController();
lateTextEditingControllerdescinput = newTextEditingController();

@override
voidinitState() {
  super.initState();
  nameinput = newTextEditingController();
  titleinput = newTextEditingController();
  descinput = newTextEditingController();
}

@override
Widgetbuild(BuildContextcontext) {
  returnScaffold(
      appBar: AppBar(
        title: Text("BORAD DATA"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogox(context);
        },
        child: Icon(Icons.edit),
      ),
      body: StreamBuilder(
        stream: firestoredb,
        builder: (context, AsyncSnapshotsnapshot) {
          if(!(snapshot.hasData)) {
            returnCircularProgressIndicator();
          } else {
            returnListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, intindex) {
                  returnCustomCard(snapshot: snapshot.data, index: index);
                });
          }
        },
      ));
}
showDialogox(BuildContextcontext) async {
  awaitshowDialog(
    context: context,
    builder: (context) =>AlertDialog(
      contentPadding: EdgeInsets.all(12),
      content: Column(
        children: [
          Text("ENTER THE REQUIRED FEILDS"),
          Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: true,
                decoration: InputDecoration(labelText: "Your Name"),
                controller: nameinput, // variable
              )),
          Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: true,
                decoration: InputDecoration(labelText: "Title"),
                controller: titleinput,
              )),
          Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: true,
                decoration: InputDecoration(labelText: "Description: "),
                controller: descinput,
              ))
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              nameinput.clear();
              titleinput.clear();
              descinput.clear();
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              if (nameinput.text.isNotEmpty&&
                  titleinput.text.isNotEmpty&&
                  descinput.text.isNotEmpty) {
                FirebaseFirestore.instance.collection("MyData").add({
                  "name": nameinput.text,
                  "Description": descinput.text,
                  "Title": titleinput.text,
                  "timestamp": newDateTime.now()
                }).then((response) {
                  print(response.id);
                  vardocid = response.id;
                  Navigator.pop(context);
                  nameinput.clear();
                  titleinput.clear();
                  descinput.clear();
                }).catchError((error) =>print(error));
              }
            },
            child: Text("Save"))
      ],
    ),
  );
}
}

classCustomCardextendsStatelessWidget {
finalintindex;
finalQuerySnapshotsnapshot;
constCustomCard({Key? key, requiredthis.snapshot, requiredthis.index})
    : super(key: key);

@override
Widgetbuild(BuildContextcontext) {
  vardocId = snapshot.docs[index].id;
  vartd = DateTime.fromMillisecondsSinceEpoch(
      snapshot.docs[index]["timestamp"].seconds * 1000);
  vardateformat = newDateFormat("EEEE,MMM,d,y").format(td);

  lateTextEditingControllernameinput =
      newTextEditingController(text: snapshot.docs[index]["name"]);
  lateTextEditingControllertitleinput =
      newTextEditingController(text: snapshot.docs[index]["Title"]);
  lateTextEditingControllerdescinput =
      newTextEditingController(text: snapshot.docs[index]["Description"]);

  returnContainer(
    height: 170,
    child: Card(
      elevation: 10,
      child: Column(
        children: [
          ListTile(
            title: Text(snapshot.docs[index]["Title"]),
            subtitle: Text(snapshot.docs[index]["Description"]),
            leading: CircleAvatar(
              radius: 35,
              child: Text(
                  snapshot.docs[index]["Title"].toString()[0].toUpperCase()),
            ),
          ),
          Padding(
            padding: constEdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("BY: ${snapshot.docs[index]["name"]}  "),
                Text(dateformat),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () async {
                    awaitshowDialog(
                      context: context,
                      builder: (context) =>AlertDialog(
                        contentPadding: EdgeInsets.all(10),
                        content: Column(
                          children: [
                            Text("UPADTE THE CURRENT RECORD"),
                            Expanded(
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  decoration:
                                  InputDecoration(labelText: "Your Name"),
                                  controller: nameinput, // variable
                                )),
                            Expanded(
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: "Title"),
                                  controller: titleinput,
                                )),
                            Expanded(
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  decoration:
                                  InputDecoration(labelText: "Description: "),
                                  controller: descinput,
                                ))
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                nameinput.clear();
                                titleinput.clear();
                                descinput.clear();
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          ElevatedButton(
                              onPressed: () {
                                if (nameinput.text.isNotEmpty&&
                                    titleinput.text.isNotEmpty&&
                                    descinput.text.isNotEmpty) {
                                  FirebaseFirestore.instance
                                      .collection("MyData")
                                      .doc(docId)
                                      .update({
                                    "name": nameinput.text,
                                    "Description": descinput.text,
                                    "Title": titleinput.text,
                                    "timestamp": newDateTime.now()
                                  }).then((response) {
                                    Navigator.pop(context);
                                    nameinput.clear();
                                    titleinput.clear();
                                    descinput.clear();
                                  }).catchError((error) =>print(error));
                                }
                              },
                              child: Text("UPDATE"))
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit_location_outlined,
                    size: 20,
                  )),
              IconButton(
                  onPressed: () async {
                    varfbOb =
                        FirebaseFirestore.instance.collection("MyData");
                    awaitfbOb.doc(docId).delete();
                    print("ID : $docId");
                  },
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    size: 20,
                  ))
            ],
          )
        ],
      ),
    ),
  );
}
}
