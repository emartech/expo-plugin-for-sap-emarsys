import type { EventSubscription } from 'react-native';
import NativeEmarsys, { type Event } from './wrapper/NativeEmarsys';
import NativeEmarsysConfig from './wrapper/NativeEmarsysConfig';
import NativeEmarsysPush from './wrapper/NativeEmarsysPush';
import InlineInAppView, { Commands as InlineInAppViewCommands } from './wrapper/InlineInAppViewNativeComponent';

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

  config: NativeEmarsysConfig,
  push: NativeEmarsysPush,
  InlineInAppView,
  InlineInApp: InlineInAppViewCommands
};

// Track wrapper:init
(async () => {
  let type = "react-native";
  const { version } = require("../package.json");
  let { version: frameworkVersion } = require("react-native/package.json");

  // Check if expo exist
  try {
    const { version: frameworkVer } = require("expo/package.json");
    type = "expo";
    frameworkVersion = frameworkVer;
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  } catch (error) {
    // No expo
  }

  NativeEmarsys.trackCustomEvent("wrapper:init", { type, version, frameworkVersion });
})();
