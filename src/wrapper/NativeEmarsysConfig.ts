import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  changeApplicationCode(applicationCode: string): Promise<void>;
  changeMerchantId(merchantId: string): Promise<void>;
  getApplicationCode(): Promise<string>;
  getMerchantId(): Promise<string>;
  getContactFieldId(): Promise<string>;
  getClientId(): Promise<string>;
  getLanguageCode(): Promise<string>;
  getSdkVersion(): Promise<string>;
  // TODO: how can we get the Expo plugin version?
  // getExpoPluginVersion(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsysConfig'
);
