
import 'package:flutter/material.dart';
import 'package:my_clients_by_anduril/helpers/utils.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ClientCardInfo extends StatelessWidget {

  final ClientModel client;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ClientCardInfo({Key key, this.client, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String visit = formattedDate(client.nextVisit != null ? client.nextVisit : client.createdTime);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        height: 168,
        width:  220,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [background, background]),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            client.name,
                            style:actionButton,
                          ),
                        ),
                        Text(
                          client.company,
                          style:actionButton,
                        ),
                        Text(
                          visit,
                          style:actionButton,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
