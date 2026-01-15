import NativeEmarsysConfig from './native/NativeEmarsysConfig';

NativeEmarsysConfig.getRNPluginVersion = () => {
  return require('../../package.json').version;
};

export default NativeEmarsysConfig;
