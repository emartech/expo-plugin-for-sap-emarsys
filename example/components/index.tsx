import { ScrollView as RNScrollView, Pressable, Text, View, StyleSheet } from 'react-native';

export function ScrollView({ children }: { children: React.ReactNode }) {
  return (
    <RNScrollView style={styles.scrollView}>
      {children}
    </RNScrollView>
  );
}

export function Button({ title, action, printResult = false }: { title: string; action: () => Promise<any>, printResult?: boolean }) {
  return (
    <Pressable onPress={async () => {
      try {
        const result = await action();
        if (printResult) {
          console.log(`${title} done:`, result);
        } else {
          console.log(`${title} done`);
        }
      } catch (e) {
        console.log(`${title} error:`, JSON.stringify(e));
      }
    }} style={styles.button}>
      <Text style={styles.buttonText}>{title}</Text>
    </Pressable>
  );
}

export function Separator() {
  return (
    <View style={styles.separator} />
  );
}

const styles = StyleSheet.create({
  scrollView: {
    paddingVertical: 20,
    paddingHorizontal: 28,
  },
  button: {
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#0070f2',
    borderRadius: 10,
    paddingVertical: 10,
    paddingHorizontal: 10,
    marginBottom: 10,
  },
  buttonText: {
    color: '#0070f2',
    fontSize: 17,
  },
  separator: {
    backgroundColor: '#999',
    height: 1,
    marginVertical: 20,
  },
});
