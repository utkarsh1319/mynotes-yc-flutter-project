import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
    );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(
        title:const Text('Home'),
      ),
      body://center is a widget and it has child property
        //center has the entire control on the white bg right now
        //bcz center is the root widget of body which is the only thing
        //scaffold is showing at the moment
        FutureBuilder(
          future: Firebase.initializeApp(
                      options:DefaultFirebaseOptions.currentPlatform, 
                    ),
          builder:(context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.done:
              final user=FirebaseAuth.instance.currentUser;
              if(user?.emailVerified?? false){
                print('Email Verified');
              }
              else{
                print('Email verification needed');
              }
              return const Text('Done'); 
                default :
                return const Text('Loading...');
            }
          }, 
        ),
     );
  }
}

