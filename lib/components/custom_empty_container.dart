import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomEmptyContainer extends StatelessWidget {

  final VoidCallback onTap;

  const CustomEmptyContainer({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20,right: 20),
          child: Column(
            children: [
              FaIcon(
                FontAwesomeIcons.ghost,
                size: 50,

              ),
              SizedBox(
                height: 20,
              ),
              Text('Não tem nada aqui :(', style: titleForms,),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: onTap,
                widget: Text('Atualizar Pagina', style: buttonColors,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
