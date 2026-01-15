import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  pause(): Promise<void>;
  resume(): Promise<void>;
  isPaused(): Promise<boolean>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsysInApp'
);
