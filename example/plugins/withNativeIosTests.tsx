const { withDangerousMod, withXcodeProject } = require('expo/config-plugins');
const fs = require('fs');
const path = require('path');

const TEST_TARGET_NAME = 'ExpoPluginForSAPEmarsysTests';

// Copy test files from example/tests into the iOS project during prebuild
const withTestFiles = (config) => {
  return withDangerousMod(config, [
    'ios',
    (config) => {
      const projectRoot = config.modRequest.projectRoot;
      const sourceTestsDir = path.join(projectRoot, 'tests', 'ios', TEST_TARGET_NAME);
      const targetTestsDir = path.join(projectRoot, 'ios', TEST_TARGET_NAME);

      if (!fs.existsSync(sourceTestsDir)) {
        return config;
      }

      if (!fs.existsSync(targetTestsDir)) {
        fs.mkdirSync(targetTestsDir, { recursive: true });
      }
      const files = fs.readdirSync(sourceTestsDir);
      for (const file of files) {
        const sourcePath = path.join(sourceTestsDir, file);
        const targetPath = path.join(targetTestsDir, file);
        if (fs.statSync(sourcePath).isFile()) {
          fs.copyFileSync(sourcePath, targetPath);
        }
      }

      const podfilePath = path.join(projectRoot, 'ios', 'Podfile');
      if (fs.existsSync(podfilePath)) {
        const podfileContent = fs.readFileSync(podfilePath, 'utf8');
        
        if (!podfileContent.includes(`target '${TEST_TARGET_NAME}'`)) {
          const testTarget = `\ntarget '${TEST_TARGET_NAME}' do\n  inherit! :search_paths\nend\n`;
          fs.appendFileSync(podfilePath, testTarget);
        }
      }

      return config;
    },
  ]);
};

const withTestTarget = (config) => {
  return withXcodeProject(config, (config) => {
    if (config.modResults.pbxGroupByName(TEST_TARGET_NAME)) {
      return config;
    }

    const projectRoot = config.modRequest.projectRoot;
    const targetTestsDir = path.join(projectRoot, 'ios', TEST_TARGET_NAME);
    const testFiles = fs.existsSync(targetTestsDir) 
      ? fs.readdirSync(targetTestsDir).filter(file => fs.statSync(path.join(targetTestsDir, file)).isFile())
      : [];

    const objects = config.modResults.hash.project.objects;
    objects['PBXTargetDependency'] = objects['PBXTargetDependency'] || {};
    objects['PBXContainerItemProxy'] = objects['PBXContainerItemProxy'] || {};

    const target = config.modResults.addTarget(
      TEST_TARGET_NAME,
      'unit_test_bundle',
      TEST_TARGET_NAME,
      `${config.ios?.bundleIdentifier}.tests`,
    );

    const pbxGroup = config.modResults.addPbxGroup(
      testFiles,
      TEST_TARGET_NAME,
      TEST_TARGET_NAME,
    );
    const groups = config.modResults.hash.project.objects['PBXGroup'];
    for (const key of Object.keys(groups)) {
      if (typeof groups[key] === 'object' && groups[key].name === undefined && groups[key].path === undefined) {
        config.modResults.addToPbxGroup(pbxGroup.uuid, key);
      }
    }

    const sourceFiles = testFiles.filter(file => file.endsWith('.m'));
    if (sourceFiles.length > 0) {
      config.modResults.addBuildPhase(
        sourceFiles,
        'PBXSourcesBuildPhase',
        'Sources',
        target.uuid
      );
    }

    const configurations = config.modResults.hash.project.objects['XCBuildConfiguration'];
    let existingBuildSettings;
    for (const key of Object.keys(configurations)) {
      const buildSettings = configurations[key].buildSettings;
      if (buildSettings && buildSettings.PRODUCT_NAME && buildSettings.PRODUCT_NAME !== `"${TEST_TARGET_NAME}"`) {
        existingBuildSettings = buildSettings;
        break;
      }
    }
    if (existingBuildSettings) {
      const settingsToCopy = [
        'CURRENT_PROJECT_VERSION', 'MARKETING_VERSION',
        'SWIFT_VERSION', 'TARGETED_DEVICE_FAMILY',
        'DEVELOPMENT_TEAM', 'CODE_SIGN_STYLE',
      ];
      for (const key of Object.keys(configurations)) {
        const buildSettings = configurations[key].buildSettings;
        if (buildSettings && buildSettings.PRODUCT_NAME === `"${TEST_TARGET_NAME}"`) {
          for (const setting of settingsToCopy) {
            if (existingBuildSettings[setting]) {
              buildSettings[setting] = existingBuildSettings[setting];
            }
          }
          buildSettings['INFOPLIST_FILE'] = `${TEST_TARGET_NAME}/Info.plist`;
          buildSettings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.1';
        }
      }
    }

    return config;
  });
}

module.exports = (config) => {
  config = withTestFiles(config);
  config = withTestTarget(config);
  return config;
};
