import Core from './wrapper';
import Push from './wrapper/push';
import InApp from './wrapper/inApp';
import Inbox from './wrapper/inbox';
import Predict from './wrapper/predict';
import Config from './wrapper/config';

export default {
  ...Core,
  push: Push,
  inApp: InApp,
  inbox: Inbox,
  predict: Predict,
  config: Config,
};

export type { Event } from './wrapper';
export { 
  default as InlineInAppView,
  type Event as InlineInAppEvent,
  type Completion as InlineInAppCompletion,
  type Close as InlineInAppClose
} from './wrapper/native/InlineInAppViewNativeComponent';
export { type Message, Tag, type ActionModel } from './wrapper/inbox';
export { type CartItem, Logic, Filter, type Product } from './wrapper/predict';
