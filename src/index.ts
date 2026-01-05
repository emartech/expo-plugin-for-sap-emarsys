import NativeEmarsys from './wrapper/NativeEmarsys';
import InlineInAppView, { Commands as InlineInAppViewCommands } from './wrapper/InlineInAppViewNativeComponent';

export default {
  // ...NativeEmarsys does not work, map functions one by one
  getClientId: NativeEmarsys.getClientId,
  getSdkVersion: NativeEmarsys.getSdkVersion,

  InlineInAppView,
  InlineInApp: InlineInAppViewCommands
}
