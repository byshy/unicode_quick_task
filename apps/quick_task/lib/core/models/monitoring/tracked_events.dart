import 'package:monitoring/models/base_event.dart';
import 'events_names.dart';

class CreateNewTODOTracker extends BaseEvent {
  CreateNewTODOTracker()
      : super(
          name: EventsNames.createNewTODO,
        );
}