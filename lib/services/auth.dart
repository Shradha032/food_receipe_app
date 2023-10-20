import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_receipe_app/localdb.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_google_signin/constant.dart';

//GOOGLE AUTHENTICATION WITH FIREBASE INTEGRATION

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//sign in ka function
Future<User?> signInWithGoogle() async
{
  //signin with google
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
      .authentication;
//creating credential for firebase
  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,

  );
//signin with credential and making a user in firebase and getting user class
  final userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;
//checking is on
  assert(!user!.isAnonymous);
  assert(await user!.getIdToken() != null);

  final User? currentUser = await _auth.currentUser;
  assert(currentUser!.uid == user!.uid);
  print(user);
  LocalDataSaver.saveName(user!.displayName.toString());
  LocalDataSaver.saveMail(user!.email.toString());
  LocalDataSaver.saveImg(user!.photoURL.toString());

  return user;


}

Future<String> signOut() async
{
  await googleSignIn.signOut();
  await _auth.signOut();
  return "SUCCESS";
}