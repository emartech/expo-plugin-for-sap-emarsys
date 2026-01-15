import NativeEmarsysInApp from './NativeEmarsysInApp';
import { Commands as InlineInAppCommands } from './InlineInAppViewNativeComponent';

export default {
  pause: NativeEmarsysInApp.pause,
  resume: NativeEmarsysInApp.resume,
  isPaused: NativeEmarsysInApp.isPaused,
  loadInlineInApp: InlineInAppCommands.loadInApp
};
