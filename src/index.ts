import type { EventSubscription } from 'react-native';
import NativeEmarsys, { type Event } from './wrapper/NativeEmarsys';
import InlineInAppView, { Commands as InlineInAppViewCommands } from './wrapper/InlineInAppViewNativeComponent';
import NativeEmarsysConfig from './wrapper/NativeEmarsysConfig';

export default {
  setEventHandler: async (handler: (arg: Event) => void | Promise<void>): Promise<EventSubscription> =>  {
    const eventSubscription = NativeEmarsys.onEvent(handler);
    await NativeEmarsys.setEventHandler();
    return eventSubscription;
  },
  config: NativeEmarsysConfig,

  InlineInAppView,
  InlineInApp: InlineInAppViewCommands
};
