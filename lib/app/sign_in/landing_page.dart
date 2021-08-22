import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/home_page.dart';
import 'package:time_tracker/app/home/jobs/jobs_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

//there isn't an mutable state anymore in landing_page
//this can now become a stateless widget
//we can remove all this boilerplate code that we had for the stateful widget
class LandingPage extends StatelessWidget {
  //now stateless widget we access the object directly
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    //<User> -> we can use this type of notation to specify that this streamBuilder works with
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          //ConnectionState = {none, waiting, active, done}
          final User user = snapshot.data; //explicit type

          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child: HomePage(),
          );
        }
        return Scaffold(
          //before receiving first value (loading)
          body: Center(child: CircularProgressIndicator()),
        );
      },
      //snapshot is an object that holds the data from our stream
      //because of this, we no longer need to stroe any state inside our landing page
    );
  }
}
