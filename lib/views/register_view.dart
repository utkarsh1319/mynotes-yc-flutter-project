import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
//import 'dart:developer'as devtools show log;

import '../constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
        ),
       body:  Column(
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
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password);
                        //print(userCredential);
                        //devtools.log(userCredential.toString());
                        final user=FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                        }
                        on FirebaseAuthException catch(e){
                          if(e.code=='weak-password'){
                               await showErrorDialog(
                               context, 'Weak password',
                              );
                            //print('Weak password');
                            //devtools.log('Weak password');
                          }
                          else if(e.code=='email-already-in-use'){
                            await showErrorDialog(
                              context,'Email is already in use',
                            );
                            //devtools.log('Email is already in use');
                            //print('Email is already in use');
                          }
                          else if(e.code=='invalid-email'){
                            await showErrorDialog(
                              context,
                              'This is an invalid email address',
                            );
                            //devtools.log('Invalid email entered');
                            //print('Invalid email entered');
                          }
                          else{
                            await showErrorDialog(
                              context,
                              'Error ${e.code},'
                            );
                          } 
                        }catch (e){
                            await showErrorDialog(context,
                            e.toString(),);
                          }
                      },
                      child:const Text('Register'),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                         );
                        },
                        child: const Text('Already registered? Login here!'),
                      )
                  ],
          
     ),
     );
  }
}
