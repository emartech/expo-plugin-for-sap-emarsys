import { TurboModuleRegistry, type TurboModule } from 'react-native';
import type { EventEmitter, UnsafeObject } from 'react-native/Libraries/Types/CodegenTypes';

export interface Spec extends TurboModule {
  readonly onEvent: EventEmitter<Event>;
  setEventHandler(): Promise<boolean>;

  getClientId(): Promise<string>;
  getSdkVersion(): Promise<string>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativeEmarsys'
);

export type Event = {
  name: string;
  payload?: UnsafeObject | null;
};
