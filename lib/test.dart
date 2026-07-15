import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wise_tardigrade/funcitions.dart';
import 'package:wise_tardigrade/widgets.dart';

Map<String,dynamic> answers = {};

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

  //Make this function determine if this is the last item
  bool isLastItem(){
    return ((widget.fullTest["items"] as List).length - 1) == itemIndex;
  }

  Map<String,dynamic> fetchCorrectItem(){
    return widget.fullTest["items"][itemIndex];
  }

  @override
  void initState(){
    super.initState();
    for(int i = 0; i < widget.fullTest["items"].length; i++){
      answers.addAll({
        i.toString(): [],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Expanded(
          child: ItemDisplayer(
            itemIndex: itemIndex,
            item: fetchCorrectItem(),
          ),
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
//Displays item, options, allows selection of options and updates the answers
class ItemDisplayer extends StatefulWidget {
  const ItemDisplayer({
    super.key,
    required this.itemIndex,
    required this.item,
  });
  final int itemIndex;
  final Map<String,dynamic> item;

  @override
  State<ItemDisplayer> createState() => _ItemDisplayerState();
}

class _ItemDisplayerState extends State<ItemDisplayer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          widget.item["question"],
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.item["type"] == "text" ? 1 : 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: widget.item["type"] == "text" ? (5/1) : 1,
            ), 
            itemCount: (widget.item["options"] as List).length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              if(widget.item["type"] == "text"){
                return TextOption(
                  itemIndex: widget.itemIndex,
                  optionIndex: index,
                  option: widget.item["options"][index],
                );
              }else{
                return ImageOption(
                  index: index,
                  option: widget.item["options"][index],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
class TextOption extends StatefulWidget {
  const TextOption({
    super.key,
    required this.itemIndex,
    required this.optionIndex,
    required this.option,
  });
  final int itemIndex;
  final int optionIndex;
  final String option;

  @override
  State<TextOption> createState() => _TextOptionState();
}

class _TextOptionState extends State<TextOption> {

  bool isSelected(){
    return (answers[widget.itemIndex.toString()] as List).contains(widget.optionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Invert selection value
        if(isSelected()){
          int indexOfOption = (answers[widget.itemIndex.toString()] as List).indexOf(widget.optionIndex);
          (answers[widget.itemIndex.toString()] as List).removeAt(indexOfOption);
        }else{
          (answers[widget.itemIndex.toString()] as List).add(widget.optionIndex);
        }
        setState(() {
          
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected() ? Colors.green : Colors.white,
          border: Border.all(),
        ),
        child: Row(
          spacing: 10,
          children: [
            isSelected() ? Icon(
              Icons.check_circle,
              color: isSelected() ? Colors.white : Colors.black,
            ) : SizedBox(),
            Text(
              widget.option,
              style: TextStyle(
                color: isSelected() ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//TODO: Make behaviour similar to TextOption
class ImageOption extends StatelessWidget {
  const ImageOption({
    super.key,
    required this.index,
    required this.option,
  });
  final int index;
  final Uint8List option;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      option,
    );
  }
}