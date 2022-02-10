import 'dart:typed_data';

import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:mqtt_explore/mqtt5/mqtt_service/mqtt_state.dart';
import 'package:typed_data/typed_data.dart';

class MqttManager {
  final String identifier;
  final String host;
  final String topic;
  final MqttState mqttAppConnectionState;

  MqttManager({
    required this.identifier,
    required this.host,
    required this.topic,
    required this.mqttAppConnectionState,
  });

  MqttServerClient? client;
  void subTopic() async {
    assert(client != null);
    // try {
    //   mqttAppConnectionState
    //       .setAppConnectionState(MqttAppConnectionState.connecting);
    //   await client!.connect('client.v1',
    //       'eyJhbGciOiJFZERTQSIsImNydiI6IkVkMjU1MTkiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE2NDQyMDA0NzEsImV4cCI6MTY0NDIwMDQ4MTI1MiwiYWNjb3VudF9pZCI6ImFjY291bnQtMTIzIiwiYXVkIjoiQ29pbmJpdC5UcmFkaW5nIiwic3ViIjoiY2xpZW50LWF1dGgiLCJpc3MiOiIxMTg0Njk5YTNhNTBlNWYzNmEyMDI2ZjYyZWIzMTMxMCJ9.eKuzM0KKFg0ILgnDweWgJJngbtJgTUCDPg8S1QYNZ-P6U-6AQRe8WhJeXFtrxprapuV-1EydlqswzfUD8AvTAg');
    // } on Exception catch (e) {
    //   disconnect();
    // }
    if (client != null) {
      client!.subscribe(
          'coinbit/client/inbox/account-123/errors/json', MqttQos.atMostOnce);
    }
  }

  void initMqttClient() {
    client = MqttServerClient(host, identifier)
      ..logging(on: true)
      ..port = 1883
      ..keepAlivePeriod = 60
      ..onConnected = onConnected
      ..onSubscribed = onSubscribed
      ..onDisconnected = onDisconnected
      ..onUnsubscribed = onUnsubscribed
      ..onSubscribeFail = onSubscribeFail
      ..pongCallback = pong;

    // final connMessage = MqttConnectMessage()
    //   // ..withClientIdentifier(identifier)
    //   // ..withWillTopic(
    //   //     'coinbit/trading/responses/Accepted/message-clent-token/protobuf')
    //   // ..withWillMessage('will Message')
    //   ..withWillQos(MqttQos.atLeastOnce)
    //   ..startClean();

    final connMessage = MqttConnectMessage()
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce);
    print('EXAMPLE::Mosquitto client connecting....');

    print('mosquitto client connecting...');

    client!.connectionMessage = connMessage;
  }

  void connect() async {
    assert(client != null);
    try {
      mqttAppConnectionState
          .setAppConnectionState(MqttAppConnectionState.connecting);
      await client!.connect('client.v1',
          'eyJhbGciOiJFZERTQSIsImNydiI6IkVkMjU1MTkiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE2NDQwNjE5NDgsImV4cCI6MTY0NDA2MTk1ODM2NCwiYWNjb3VudF9pZCI6ImFjY291bnQtMTIzIiwiYXVkIjoiQ29pbmJpdC5UcmFkaW5nIiwic3ViIjoiY2xpZW50LWF1dGgiLCJpc3MiOiIxMTg0Njk5YTNhNTBlNWYzNmEyMDI2ZjYyZWIzMTMxMCJ9.Q_TbvpAnBtuudF45M9TeBj4MH_k2t07W9RJQFdHnmuEd8Y4HVeQJE5o_HXCB7H4e6tQvOyf-87GuAi8ymBeJBg');
    } on Exception catch (e) {
      disconnect();
    }
  }

  void disconnect() {
    print('disconnect');
    client!.disconnect();
    mqttAppConnectionState
        .setAppConnectionState(MqttAppConnectionState.disconnected);
  }

  void publish(Uint8Buffer message) {
    final MqttPayloadBuilder builder = MqttPayloadBuilder();
    builder.addBuffer(message);
    try {
      // client!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      client!.publishMessage(
          'coinbit/trading/BTCIDR/EnterOrder/json/account-123',
          MqttQos.atMostOnce,
          builder.payload!);
    } catch (e) {
      print(e);
    }
  }

  void onSubscribed(MqttSubscription topic) {
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>you subscribe this topic $topic');
  }

  void onDisconnected() {
    print('you disconnect');

    mqttAppConnectionState
        .setAppConnectionState(MqttAppConnectionState.disconnected);
  }

  void onConnected() {
    mqttAppConnectionState
        .setAppConnectionState(MqttAppConnectionState.connected);
    print('mosquitto client connected...');

    client!.subscribe(topic, MqttQos.atMostOnce);
    client!.updates.listen((event) {
      final MqttPublishMessage recMessage =
          event.first.payload as MqttPublishMessage;

      final String pt =
          MqttUtilities.bytesToStringAsString(recMessage.payload.message!);

      print(
          'Change notification:: topic is <${event.first.topic}>, payload is <-- $pt -->');
    });
  }

  // subscribe to topic failed
  void onSubscribeFail(MqttSubscription topic) {
    print('Failed to subscribe $topic');
  }

  // unsubscribe succeeded
  void onUnsubscribed(MqttSubscription? topic) {
    print('Unsubscribed topic: $topic');
  }

  // PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
