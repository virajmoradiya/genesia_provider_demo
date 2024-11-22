import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:genesia_demo/core/base/base_provider.dart';

base mixin SubscriptionHelper on BaseProvider {
  @visibleForTesting
  @protected
  final List<StreamSubscription> subscriptions = [];

  @override
  void dispose() {

    debugPrint("DISPOSE STREAM :: :::");

    cancelAllSubscriptions();
    super.dispose();
  }

  @protected
  void cancelAllSubscriptions() {
    if (subscriptions.isNotEmpty) {
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    }
  }
}
