import 'package:flutter/material.dart';
import 'package:wise_tardigrade/funcitions.dart';
import 'package:wise_tardigrade/widgets.dart';

class SubmissionScreen extends StatefulWidget {
  const SubmissionScreen({
    super.key,
    required this.serverIPV4,
    required this.answers,
  });
  final String serverIPV4;
  final Map<String,dynamic> answers;

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: FutureBuilder(
          future: submitTest(widget.serverIPV4, widget.answers), 
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
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
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Gracias por someter su prueba",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CircleAvatar(
                      radius: 80,
                      foregroundImage: AssetImage(
                        "images/app-logo.png",
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                  ],
                ),
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
    );
  }
}