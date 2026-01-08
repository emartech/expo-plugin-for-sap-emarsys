import type { EventSubscription } from 'react-native';
import NativeEmarsys, { type Event } from './wrapper/NativeEmarsys';
import InlineInAppView, { Commands as InlineInAppViewCommands } from './wrapper/InlineInAppViewNativeComponent';

export default {
  setEventHandler: async (handler: (arg: Event) => void | Promise<void>): Promise<EventSubscription> =>  {
    const eventSubscription = NativeEmarsys.onEvent(handler);
    await NativeEmarsys.setEventHandler();
    return eventSubscription;
  },

  getClientId: NativeEmarsys.getClientId,
  getSdkVersion: NativeEmarsys.getSdkVersion,

  InlineInAppView,
  InlineInApp: InlineInAppViewCommands
};
