import React from 'react';
import type { HostComponent, ViewProps } from 'react-native';
import type { BubblingEventHandler, UnsafeMixed } from 'react-native/Libraries/Types/CodegenTypes';
import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import codegenNativeCommands from 'react-native/Libraries/Utilities/codegenNativeCommands';

export interface NativeProps extends ViewProps {
  onEvent?: BubblingEventHandler<Event> | null;
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

export type Event = {
  name: string;
  payload?: UnsafeMixed | null;
};

export type Completion = {
  error?: string | null;
};

export type Close = {
};
