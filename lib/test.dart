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
      body: SafeArea(
        child: Padding(
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
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.brown),
                  ),
                );
              }
            },
          ),
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
    return ((widget.fullTest["items"] as List).length - 1) == itemIndex;
  }

  Map<String,dynamic> fetchCorrectItem(){
    return widget.fullTest["items"][itemIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        ItemDisplayer(
          item: fetchCorrectItem(),
        ),
        Row(
          spacing: 10,
          children: [
            itemIndex == 0 ? SizedBox() : Expanded(
              child: BigButton(
                icon: Icons.chevron_left, 
                text: "Anterior", 
                onTap: (){
                  //Previous item
                  setState(() {
                    itemIndex--;
                  });
                },
              ),
            ),
            isLastItem() ? SizedBox() : Expanded(
              child: BigButton(
                icon: Icons.chevron_right, 
                text: "Próximo",
                onTap: (){
                  //Next item
                  setState(() {
                    itemIndex++;
                  });
                },
              ),
            ),
          ],
        ),
        !isLastItem() ? SizedBox() : BigButton(
          icon: Icons.done, 
          text: "Someter",
          onTap: (){
            //TODO: Submit test
            
          },
        ),
      ],
    );
  }
}
//TODO: Displays item, options, allows selection of options and updates the answers
class ItemDisplayer extends StatelessWidget {
  const ItemDisplayer({
    super.key,
    required this.item,
  });
  final Map<String,dynamic> item;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}