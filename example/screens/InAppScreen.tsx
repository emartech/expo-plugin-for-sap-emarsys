import { useRef, useState } from 'react';
import Emarsys from 'expo-plugin-for-sap-emarsys';
import { ScrollView, Button, Separator } from '../components';

export default function PushScreen() {
  const inlineInAppView = useRef<any>(null);
  const [inlineInAppViewHeight, setInlineInAppViewHeight] = useState(0);

  return (
    <ScrollView>
      <Button title="Load Inline InApp" action={async () => {
        Emarsys.InlineInApp.loadInApp(inlineInAppView.current, 'view-id');
      }} />
      <Emarsys.InlineInAppView
        ref={inlineInAppView}
        style={{ width: '100%', height: inlineInAppViewHeight }}
        onEvent={(event) => {
          console.log(`InlineInAppView onEvent: ${event.nativeEvent.name}:`, event.nativeEvent.payload);
        }}
        onCompletion={(event) => {
          if (!event.nativeEvent.error) {
            setInlineInAppViewHeight(125);
          } else {
            console.log(`InlineInAppView onCompletion error: ${event.nativeEvent.error}`);
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
