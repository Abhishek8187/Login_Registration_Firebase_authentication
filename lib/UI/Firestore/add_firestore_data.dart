import 'package:intern_task/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_task/Utils/utils.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance
      .collection('user'); //user is name of collection
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add firestore data'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'Whats on your mind today',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now()
                      .millisecondsSinceEpoch
                      .toString(); //giving id..if we dont give then it will create automaticallyy
                  fireStore.doc(id).set({
                    //creating document in collection
                    'title': postController.text.toString(),
                    'id': id
                  }).then(
                    (value) {
                      setState(
                        () {
                          loading = false;
                        },
                      );
                      Utils().toastMessage('Data added');
                    },
                  ).onError((error, stackTrace) {
                    setState(
                          () {
                        loading = false;
                      },
                    );
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
