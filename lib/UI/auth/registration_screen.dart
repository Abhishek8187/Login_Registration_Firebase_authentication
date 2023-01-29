import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intern_task/UI/auth/login_screen.dart';
import 'package:intern_task/UI/upload_image.dart';
import 'package:intern_task/Utils/text_fields.dart';
import 'package:intern_task/Utils/utils.dart';
import 'package:intern_task/widgets/round_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<
      FormState>(); // this is used to check email empty and to use Form
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final fireStore = FirebaseFirestore.instance
      .collection('user');  //user is the name of collection

  bool loading = false;

  void register() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            //firebase commands
            email: emailController.text.toString(),
            password: passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('SignUp successful');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    nameController.dispose();
    collegeController.dispose();
    yearController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool flag = true;
    String dropdownValue = 'Student';

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Signup',
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: Form(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.file_download_outlined),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            if (newValue == 'Teacher') {

                              setState(() {
                                flag = false;
                              });
                            }
                            print(newValue);
                            print(flag);


                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Student', 'Teacher']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icon(Icons.alternate_email),
                            returnText: 'Enter email'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icon(Icons.lock_open_sharp),
                            returnText: 'Enter password'),

                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: mobileController,
                            hintText: 'Mobile',
                            icon: Icon(Icons.phone_android_sharp),
                            returnText: 'Enter mobile'),

                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: nameController,
                            hintText: 'Name',
                            icon: Icon(Icons.account_box_sharp),
                            returnText: 'Enter name'),

                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: collegeController,
                            hintText: 'College',
                            icon: Icon(Icons.school_outlined),
                            returnText: 'Enter college'),

                        const SizedBox(
                          height: 20,
                        ),
                        TextFields(
                            controller: yearController,
                            hintText: 'Year',
                            icon: Icon(Icons.date_range_outlined),
                            returnText: 'Enter Year'),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UploadImage(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.pink)),
                                child:
                                    const Center(child: Text('Upload picture')),
                              ),
                            ),
                            InkWell(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => (),
                              //     ),
                              //   );
                              // },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.pink)),
                                child: const Center(child: Text('Upload resume')),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              loading: loading,
              title: 'Signup',
              onTap: () {
                setState(() {
                  loading = true;
                });
                if (formKey.currentState!.validate()) {
                  register(); //made a separate function to register user


                  String id = DateTime.now()
                      .millisecondsSinceEpoch
                      .toString(); //giving id..if we dont give then it will create automaticallyy
                  fireStore.doc(id).set({
                    //creating document in collection
                    'id' : id,
                    'Email': emailController.text.toString(),
                    'Mobile': mobileController.text.toString(),
                    'Name' : nameController.text.toString(),
                    'College' : collegeController.text.toString(),
                    'Year' : yearController.text.toString()

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
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
