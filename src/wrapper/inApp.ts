import NativeEmarsysInApp from './native/NativeEmarsysInApp';
import { Commands as InlineInAppCommands } from './native/InlineInAppViewNativeComponent';

export default {
  pause: NativeEmarsysInApp.pause,
  resume: NativeEmarsysInApp.resume,
  isPaused: NativeEmarsysInApp.isPaused,
  loadInlineInApp: InlineInAppCommands.loadInApp
};
