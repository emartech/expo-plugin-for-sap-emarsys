import { useRef, useState } from 'react';
import Emarsys from 'expo-plugin-for-sap-emarsys';
import { ScrollView, Button, Alert, Separator } from '../components';

export default function PushScreen() {
  const inlineInAppView = useRef<any>(null);
  const [inlineInAppViewHeight, setInlineInAppViewHeight] = useState(0);

  return (
    <ScrollView>
      <Button title="InApp Pause" action={async () => {
        await Emarsys.inApp.pause();
      }} />
      <Button title="InApp Resume" action={async () => {
        await Emarsys.inApp.resume();
      }} />
      <Button title="InApp Is Paused" action={async () => {
        return await Emarsys.inApp.isPaused();
      }} printResult />
      <Button title="InApp Load Inline InApp" action={async () => {
        Emarsys.InlineInApp.loadInApp(inlineInAppView.current, 'view-id');
      }} />
      <Emarsys.InlineInAppView
        ref={inlineInAppView}
        style={{ width: '100%', height: inlineInAppViewHeight }}
        onEvent={(event) => {
          Alert('InlineInAppView', `onEvent: ${event.nativeEvent.name}: ${JSON.stringify(event.nativeEvent.payload)}`);
        }}
        onCompletion={(event) => {
          if (!event.nativeEvent.error) {
            setInlineInAppViewHeight(125);
          } else {
            Alert('InlineInAppView', `onCompletion: Error: ${event.nativeEvent.error}`);
          }
        }}
        onClose={() => {
          setInlineInAppViewHeight(0);
        }}
      />

      <Separator />

    </ScrollView>
  );
}
