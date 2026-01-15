import Emarsys, { type CartItem, Logic, Filter } from 'expo-plugin-for-sap-emarsys';
import { ScrollView, Button } from '../components';

export default function PredictScreen() {
  return (
    <ScrollView>
      <Button title="Track Cart" action={async () => {
        const items: CartItem[] = [
          { itemId: 'item1', price: 1.1, quantity: 1 },
          { itemId: 'item2', price: 2.2, quantity: 2 }
        ];
        await Emarsys.predict.trackCart(items);
      }} />
      <Button title="Track" action={async () => {
        console.log('Tracking');
      }} />

    </ScrollView>
  );
}
