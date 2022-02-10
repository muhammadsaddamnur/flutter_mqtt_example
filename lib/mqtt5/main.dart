import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt_explore/model/pesan.pb.dart';
import 'package:mqtt_explore/mqtt5/mqtt_service/mqtt_manager.dart';
import 'package:mqtt_explore/mqtt5/mqtt_service/mqtt_state.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/typed_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MqttState>(
          create: (_) => MqttState(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController chat = TextEditingController();
  List chats = [];
  MqttManager? manager;

  void Function()? connect(MqttState state) {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }

    manager = MqttManager(
      host: '10.0.2.2',
      // topic: 'coinbit/client/inbox/account-123/errors/json',
      topic: '',
      identifier: osPrefix,
      mqttAppConnectionState: state,
    );
    manager!.initMqttClient();
    manager!.connect();
    setState(() {});
  }

  void Function()? topic(MqttState state) {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }

    manager = MqttManager(
      host: '10.0.2.2',
      // topic: 'coinbit/client/inbox/account-123/errors/json',
      topic: '',
      identifier: osPrefix,
      mqttAppConnectionState: state,
    );
    manager!.initMqttClient();
    manager!.subTopic();
    setState(() {});
  }

  void disconnect() {
    manager!.disconnect();
    setState(() {});
  }

  Uint8Buffer? createProto() {
    Chats chats = Chats();
    Pesan pesan = Pesan();

    if (chat.text.isNotEmpty) {
      pesan.pesan = chat.text;

      chats.pesan.add(pesan);
    }

    Uint8List data = chats.writeToBuffer();
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    print(dataBuffer);
    return dataBuffer;
  }

  @override
  Widget build(BuildContext context) {
    final MqttState appState = Provider.of<MqttState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: appState.appConnectionState ==
                      MqttAppConnectionState.connected
                  ? null
                  : () {
                      connect(appState);
                    },
              child: const Text('Connect'),
            ),
            ElevatedButton(
              onPressed: appState.appConnectionState ==
                      MqttAppConnectionState.disconnected
                  ? null
                  : () {
                      // topic(appState);
                      manager!.subTopic();
                    },
              child: const Text('sub topic'),
            ),
            ElevatedButton(
              onPressed: appState.appConnectionState ==
                      MqttAppConnectionState.disconnected
                  ? null
                  : () {
                      disconnect();
                    },
              child: const Text('Disconnect'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(appState.appConnectionState == MqttAppConnectionState.connected
                ? 'connected'
                : appState.appConnectionState ==
                        MqttAppConnectionState.connecting
                    ? 'connecting'
                    : appState.appConnectionState ==
                            MqttAppConnectionState.disconnected
                        ? 'disconnected'
                        : '-'),
            manager == null || manager!.client == null
                ? const Expanded(child: SizedBox())
                : Expanded(
                    child:
                        StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
                      stream: manager!.client!.updates,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final MqttPublishMessage recMessage = snapshot
                              .data!.first.payload as MqttPublishMessage;
                          final String pt = MqttUtilities.bytesToStringAsString(
                              recMessage.payload.message!);

                          chats.add(pt);
                          chats.reversed;

                          return ListView.builder(
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(chats[index].toString()),
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: chat,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (manager != null) {
                        Uint8Buffer? chatMessageProto = createProto();
                        if (chatMessageProto != null) {
                          manager!.publish(chatMessageProto);
                          chat.clear();
                          FocusScope.of(context).unfocus();
                        }
                      }
                    },
                    child: const Text('Publish'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
