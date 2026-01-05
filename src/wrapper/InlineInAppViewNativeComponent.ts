import React from 'react';
import type { HostComponent, ViewProps } from 'react-native';
import type { UnsafeMixed, BubblingEventHandler } from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import codegenNativeCommands from 'react-native/Libraries/Utilities/codegenNativeCommands';

export interface NativeProps extends ViewProps {
  onAppEvent?: BubblingEventHandler<AppEvent> | null;
  onCompletion?: BubblingEventHandler<Completion> | null;
  onClose?: BubblingEventHandler<Close> | null;
}

export default codegenNativeComponent<NativeProps>(
  'InlineInAppView'
) as HostComponent<NativeProps>;

export interface NativeCommands {
  loadInApp: (viewRef: React.ElementRef<HostComponent<NativeProps>>, viewId: string) => void;
}

export const Commands: NativeCommands = codegenNativeCommands<NativeCommands>({
  supportedCommands: ['loadInApp']
});

type AppEvent = {
  eventName: string;
  payload?: UnsafeMixed | null;
};

type Completion = {
  error?: string | null;
};

type Close = {
};
