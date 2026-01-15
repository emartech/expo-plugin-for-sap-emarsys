import NativeEmarsys from './wrapper';
import NativeEmarsysPush from './wrapper/NativeEmarsysPush';
import NativeEmarsysInApp from './wrapper/inApp';
import NativeEmarsysPredict from './wrapper/NativeEmarsysPredict';
import NativeEmarsysConfig from './wrapper/config';

export default {
  ...NativeEmarsys,
  push: NativeEmarsysPush,
  inApp: NativeEmarsysInApp,
  predict: NativeEmarsysPredict,
  config: NativeEmarsysConfig,
};

export type { Event } from './wrapper/NativeEmarsys';
export { 
  default as InlineInAppView,
  type Event as InlineInAppEvent,
  type Completion as InlineInAppCompletion,
  type Close as InlineInAppClose
} from './wrapper/InlineInAppViewNativeComponent';
export type { CartItem, Product } from './wrapper/NativeEmarsysPredict';
export { Logic, Filter } from './wrapper/predict';
