const fs = require('fs').promises;

(async () => {
  // copy podspec for react native
  let podspec = await fs.readFile('ios/ExpoPluginForSAPEmarsys.podspec', { encoding: 'utf8' });
  podspec = podspec.replace("'..', 'package.json'", "'package.json'");
  podspec = podspec.replace("s.dependency 'ExpoModulesCore'", "");
  podspec = podspec.replace("s.source_files = '", "s.source_files = 'ios/");
  await fs.writeFile('ExpoPluginForSAPEmarsys.podspec', podspec);

  try {
    // check if expo exist
    require("expo/package.json");
    require("expo-modules-core/package.json");

  // eslint-disable-next-line no-unused-vars
  } catch (error) {
    // expo not exist

    // remove expo plugin from build.gradle
    let buildGradle = await fs.readFile('android/build.gradle', { encoding: 'utf8' });
    buildGradle = buildGradle.replace(/\/\/ expo plugin - START[\s\S]*\/\/ expo plugin - END/m, '');
    await fs.writeFile('android/build.gradle', buildGradle);

    // remove expo plugin files
    await fs.writeFile('android/src/main/java/com/emarsys/reactnative/expo/EmarsysPackage.kt', '');
    await fs.writeFile('android/src/main/java/com/emarsys/reactnative/expo/EmarsysApplicationLifecycleListener.kt', '');
    await fs.writeFile('ios/expo/EmarsysAppDelegateSubscriber.swift', '');

  }
})();
