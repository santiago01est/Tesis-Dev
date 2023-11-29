import 'package:flutter/material.dart';

class PopupUtils {
  static void showAvatarSelectionPopup(BuildContext context,
      List<String> avatarPaths, Function(String) onSelectAvatar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SizedBox(
            width: 300, // Ajusta el ancho según tus necesidades
            height: 300, // Ajusta la altura según tus necesidades
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: avatarPaths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          onSelectAvatar(avatarPaths[index]);
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(avatarPaths[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showPortadaSelectionPopup(BuildContext context,
      List<String> portadasPaths, Function(String) onSelectPortada) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SizedBox(
            width: 400, // Ajusta el ancho según tus necesidades
            height: 400, // Ajusta la altura según tus necesidades
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: portadasPaths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            onSelectPortada(portadasPaths[index]);
                            Navigator.of(context).pop();
                          },
                          //card rectangular con border redondo

                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(
                                  portadasPaths[index],
                                  width: 90,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              )));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
