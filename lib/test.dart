import 'package:flutter/material.dart';
import 'package:wise_tardigrade/funcitions.dart';
import 'package:wise_tardigrade/widgets.dart';

class Test extends StatefulWidget {
  const Test({
    super.key,
    required this.serverIPV4,
  });
  final String serverIPV4;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: fetchAndParseTest(widget.serverIPV4), 
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Column(
                spacing: 10,
                children: [
                  Text(
                    snapshot.error.toString(),
                  ),
                  BigButton(
                    icon: Icons.refresh, 
                    text: "Reintentar", 
                    onTap: (){
                      setState(() {
                        
                      });
                    },
                  ),
                ],
              );
            }else if(snapshot.connectionState == ConnectionState.done){
              return CoolTestDisplayer(
                fullTest: snapshot.data as Map<String,dynamic>,
              );
            }else{
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.brown),
              );
            }
          },
        ),
      ),
    );
  }
}
class CoolTestDisplayer extends StatefulWidget {
  const CoolTestDisplayer({
    super.key,
    required this.fullTest,
  });
  final Map<String,dynamic> fullTest;

  @override
  State<CoolTestDisplayer> createState() => _CoolTestDisplayerState();
}

class _CoolTestDisplayerState extends State<CoolTestDisplayer> {

  int itemIndex = 0;
  Map<String,dynamic> answers = {};

  //TODO: Make this function determine if this is the last item
  bool isLastItem(){
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        isLastItem() ? Column(
          children: [
            Text(
              "¿Terminaste?",
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 40,
            ),
          ],
        ) : ItemDisplayer(

        ),
        itemIndex == 0 ? SizedBox() : Row(
          children: [
            Expanded(
              child: BigButton(
                icon: Icons.chevron_left, 
                text: "Anterior", 
                onTap: (){
                  //TODO: Previous item

                },
              ),
            ),
            isLastItem() ? SizedBox() : Expanded(
              child: BigButton(
                icon: Icons.chevron_right, 
                text: "Próximo",
                onTap: (){
                  //TODO: Next item
                  
                },
              ),
            ),
          ],
        ),
        !isLastItem() ? SizedBox() : Expanded(
          child: BigButton(
            icon: Icons.chevron_right, 
            text: "Someter",
            onTap: (){
              //TODO: Submit test
              
            },
          ),
        ),
      ],
    );
  }
}
//TODO: Displays item, options, allows selection of options and updates the answers
class ItemDisplayer extends StatelessWidget {
  const ItemDisplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}