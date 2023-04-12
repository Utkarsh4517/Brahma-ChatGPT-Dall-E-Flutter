import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  signInWithGoogle() async {
    // begin interactive sign in progress
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request 
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken
  );
    // finally lets sign in 
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}