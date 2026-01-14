import { Platform } from 'react-native';
import * as Notifications from 'expo-notifications';
import Emarsys from 'expo-plugin-for-sap-emarsys';
import E from 'react-native-emarsys-wrapper';
import { ScrollView, Button } from '../components';

export default function PushScreen() {
  return (
    <ScrollView>
      <Button title="Request Push Permission" action={async () => {
        await requestPushPermission();
      }} />

    </ScrollView>
  );
}

async function requestPushPermission() {
  if (Platform.OS === 'android') {
    await Notifications.setNotificationChannelAsync('ems_sample_messages', {
      name: 'Messages',
      importance: Notifications.AndroidImportance.DEFAULT,
    });
  }
  const { granted } = await Notifications.requestPermissionsAsync();
  if (granted) {
    if (Platform.OS === 'android') {
      let token = await Notifications.getDevicePushTokenAsync();
      await E.push.setPushToken(token.data); // TODO: change to Emarsys.push.setPushToken
    } else if (Platform.OS === 'ios') {
      // getDevicePushTokenAsync doesn't resolve on iOS, don't await here
      // Call it and trigger didRegisterForRemoteNotificationsWithDeviceToken in AppDelegate
      Notifications.getDevicePushTokenAsync();
    }
  } else {
    console.log('Push permission denied');
  }
}
