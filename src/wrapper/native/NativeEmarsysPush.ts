import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  setPushToken(pushToken: string): Promise<void>;
  clearPushToken(): Promise<void>;
  getPushToken(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsysPush'
);
