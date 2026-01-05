import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  getClientId(): Promise<string>;
  getSdkVersion(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsys'
);
