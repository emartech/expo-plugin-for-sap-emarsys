import type { EventSubscription } from 'react-native';
import './wrapper';
import NativeEmarsys, { type Event } from './wrapper/NativeEmarsys';
import NativeEmarsysPush from './wrapper/NativeEmarsysPush';
import NativeEmarsysInApp from './wrapper/NativeEmarsysInApp';
import InlineInAppView, { Commands as InlineInAppCommands } from './wrapper/InlineInAppViewNativeComponent';
import type { Event as InlineInAppEvent, Completion as InlineInAppCompletion, Close as InlineInAppClose } from './wrapper/InlineInAppViewNativeComponent';
import NativeEmarsysConfig from './wrapper/NativeEmarsysConfig';

NativeEmarsysConfig.getRNPluginVersion = () => {
  return require('../package.json').version;
};

export default {
  setEventHandler: (handler: (arg: Event) => void | Promise<void>): EventSubscription =>  {
    const eventSubscription = NativeEmarsys.onEvent(handler);
    NativeEmarsys.setEventHandler();
    return eventSubscription;
  },
  setContact: NativeEmarsys.setContact,
  clearContact: NativeEmarsys.clearContact,
  trackCustomEvent: NativeEmarsys.trackCustomEvent,
  trackDeepLink: NativeEmarsys.trackDeepLink,

  push: NativeEmarsysPush,
  inApp: NativeEmarsysInApp,
  InlineInAppView,
  InlineInApp: InlineInAppCommands,
  config: NativeEmarsysConfig,
};

export type { Event };
export type { InlineInAppEvent, InlineInAppCompletion, InlineInAppClose };
