import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_task/UI/Firestore/add_firestore_data.dart';
import 'package:intern_task/UI/auth/login_screen.dart';
import 'package:intern_task/Utils/utils.dart';
import 'package:intern_task/widgets/round_button.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({Key? key}) : super(key: key);

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('user').snapshots();  //fetching data from firestore(we dont need docs
  // as used in add_firestore_data, we need snapshot

  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'FireStore Screen',
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(  //fetching data from firestore (maybe stream is for realtime changes
              stream: fireStore,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if(snapshot.hasError) {
                  return const Text('Some Error');
                }
                return   Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                    return ListTile(
                      onTap: (){   //updating and deleting data

                        ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                          'title' : 'updated'   //we can also take input from user as taught in firebase update videos(CRUD)
                        }).then((value) {
                          Utils().toastMessage('updated');
                        }).onError((error, stackTrace) {
                          Utils().toastMessage('Something went wrong');
                        });
                        //ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();  //to delete

                      },
                        title: Text(snapshot.data!.docs[index]['title']),
                      subtitle: Text(snapshot.data!.docs[index]['id']),
                    );
                  }),
                );
                }),

            const SizedBox(
              height: 50,
            ),
            RoundButton(
              loading: loading,
              title: 'Signup',
              onTap: () {
                 // signup(); //made a separate function to register user

              },
            ),
           SizedBox(height: 50,),
            FloatingActionButton(
                child: Icon(Icons.arrow_circle_down),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFirestoreDataScreen(),
                    ),
                  );
                })
          ],
        ),

      ),
    );
  }
}
