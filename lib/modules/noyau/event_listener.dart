
import 'models/event_model.dart';

/// Simple interface for classes interested in events.
mixin EventListener {
  void onEvent(EventModel event);
}
