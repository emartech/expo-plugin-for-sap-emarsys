import NativeEmarsys from './NativeEmarsys';

// Track wrapper:init
(async () => {
  const version = require('../../package.json').version;
  let frameworkVersion = require('react-native/package.json').version;
  let type = 'react-native';

  // Check if expo exist
  try {
    frameworkVersion = require('expo/package.json').version;
    type = 'expo';
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  } catch (error) {
    // No expo
  }

  NativeEmarsys.trackCustomEvent('wrapper:init', { type, version, frameworkVersion });
})();
