import NativeEmarsysConfig from './NativeEmarsysConfig';

NativeEmarsysConfig.getRNPluginVersion = () => {
  return require('../../package.json').version;
};

export default NativeEmarsysConfig;
