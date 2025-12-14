// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'dart:async';

import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final StreamController<RemoteMessage> notificationStream = StreamController.broadcast();
final StreamController<WalletResponseObject> walletIsChanged = StreamController.broadcast();
final StreamController<bool> balanceIsChanged = StreamController.broadcast();
final StreamController<bool> hiddenBalanceIsChanged = StreamController.broadcast();
