import Emarsys from 'expo-plugin-for-sap-emarsys';
import { ScrollView, Button } from '../components';

export default function PredictScreen() {
  return (
    <ScrollView>
      <Button title="Track" action={async () => {
        console.log('Tracking');
      }} />

    </ScrollView>
  );
}
