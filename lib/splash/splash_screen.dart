
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/models/user_model.dart';
import 'package:my_clients_by_anduril/screens/login/login_module.dart';
import 'package:my_clients_by_anduril/screens/main/main_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  void initState() {
    _redirectToHome();
    super.initState();
  }

  Future _redirectToHome() async {
    UserModel userModel = await userBloc.loggedUserAsync();
    if(userModel != null) {
      UserModel tourUser = await userBloc.getUserModel(id: userModel.id);
      if(await userBloc.isLogged() && tourUser.available == true) {
        await Get.offAll(() => MainModule());
      }
      else if (await userBloc.isLogged() && tourUser.available == false) {
        await Get.offAll(() => LoginModule());
      }
    } else {
      await Get.offAll(() => LoginModule());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'logo',
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [background, Color(0xff4F46E5)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              Center(
                child: FaIcon(
                  FontAwesomeIcons.meteor,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('sponsored by Anduril Software', style: typeText,),),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

