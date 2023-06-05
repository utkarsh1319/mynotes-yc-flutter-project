
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import '../constants/routes.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}):super(key:key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(
        title:const Text('Login'),
      ),
       body: Column(
                children: [
                  TextField(
                    controller:_email,
                    enableSuggestions:false,
                    autocorrect:false,
                    keyboardType:TextInputType.emailAddress,
                    decoration:const InputDecoration(
                      hintText:'Email Adrress',
                    )
                  ),
                  TextField(
                    controller:_password,
                    obscureText:true,
                    enableSuggestions:false,
                    autocorrect:false,
                    decoration:const InputDecoration(
                      hintText:'Password',
                    )
                  ),
                  TextButton(
                    //registering a user is a async task 
                    onPressed:()async{
                      final email=_email.text;
                      final password=_password.text;
                      try{
                        final userCredential=
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                      );
                      //devtools.log(userCredential.toString());
                      //print(userCredential);
                      Navigator.of(context).pushNamedAndRemoveUntil('/notes/', (route) => false,);
                      } 
                      on FirebaseAuthException catch(e){
                        if(e.code=='user-not-found'){
                          await showErrorDialog(context, 'User not found',);
                          //devtools.log('User not found');
                          //print('User not found');
                        }
                        else if(e.code=='wrong-password'){
                          await showErrorDialog(context,'Wrong credentials',);
                          //devtools.log('Wrong Password');
                          //print('Wrong Password');
                        }
                        else{
                          await showErrorDialog(
                            context,
                            'Error:${e.code}',
                          );
                        }
                      }
                    },
                    child:const Text('Login'),
                    ),
                    TextButton(
                      onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute,
                         (route) => false,
                         );
                    },
                     child: const Text('Not registered? Register here!'),
                     )
                ],
              ),
     );
  }
}
