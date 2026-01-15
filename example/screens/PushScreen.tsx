import { Platform } from 'react-native';
import * as Notifications from 'expo-notifications';
import Emarsys from 'expo-plugin-for-sap-emarsys';
import { ScrollView, Button, Alert } from '../components';

export default function PushScreen() {
  return (
    <ScrollView>
      <Button title="Request Push Permission" action={async () => {
        await requestPushPermission();
      }} />
      <Button title="Set Push Token" action={async () => {
        const pushToken = '1234567890'; // Should retrive the actual push token here
        await Emarsys.push.setPushToken(pushToken);
      }} />
      <Button title="Clear Push Token" action={async () => {
        await Emarsys.push.clearPushToken();
      }} />
      <Button title="Get Push Token" action={async () => {
        return await Emarsys.push.getPushToken();
      }} printResult />

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
      await Emarsys.push.setPushToken(token.data);
    } else if (Platform.OS === 'ios') {
      // getDevicePushTokenAsync doesn't resolve on iOS, don't await here
      // Call it and trigger didRegisterForRemoteNotificationsWithDeviceToken in AppDelegate
      Notifications.getDevicePushTokenAsync();
    }
  } else {
    Alert('Request Push Permission', 'Push permission denied');
  }
}
