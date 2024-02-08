import 'package:flutter/material.dart';
import 'package:metamask_flutter_app/ViewModel/metamask_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskViewModel(),
      child: MaterialApp(
        home: MetaMaskScreen(),
      ),
    );
  }
}

class MetaMaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MetaMask Flutter App'),
      ),
      body: MetaMaskList(),
    );
  }
}

class MetaMaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MetaMaskViewModel>(context);

    return FutureBuilder(
      future: viewModel.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> data = snapshot.data as List<String>;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]),
              );
            },
          );
        }
      },
    );
  }
}
