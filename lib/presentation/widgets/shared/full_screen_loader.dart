import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages(){
      final messages = <String>[
    'Cargando peliculas',
    'Comprando palomitas de maiz',
    'Cargando populares',
    'Llamando a mi novia',
    'Ya casi',
    'Esto es tardando mas de lo esperado :c'
  ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere Por favor'),
          SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: getLoadingMessages(),builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Cargando...');

            return Text(snapshot.data!);
          },)
        ],
      ),
    );
  }
}