const appConfig = require('./app.json');

module.exports = {
  ...appConfig.expo,
  plugins: [
    ...(appConfig.expo.plugins || []),
    './plugins/withNativeIosTests.tsx',
  ],
};
