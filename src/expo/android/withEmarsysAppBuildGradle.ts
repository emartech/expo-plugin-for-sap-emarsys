import { ConfigPlugin, withAppBuildGradle } from 'expo/config-plugins'

const DESUGARING_COMPILE_OPTIONS = "coreLibraryDesugaringEnabled true";
const DESUGARING_DEP = "coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs_nio:";
const DESUGARING_DEP_VER = "2.1.5'";

const GOOGLE_SERVICES_PLUGIN = "apply plugin: 'com.google.gms.google-services'";

export const withEmarsysAppBuildGradle: ConfigPlugin = config =>
  withAppBuildGradle(config, config => {
    let contents = config.modResults.contents;

    // Ensure coreLibraryDesugaringEnabled
    if (!contents.includes(DESUGARING_COMPILE_OPTIONS)) {
      if (contents.includes('compileOptions')) {
        contents = contents.replace(
          /(compileOptions\s*{)/m,
          `$1\n        ${DESUGARING_COMPILE_OPTIONS}\n`
        );
      } else {
        contents = contents.replace(
          /(android\s*{)/m,
          `$1
    compileOptions {
        ${DESUGARING_COMPILE_OPTIONS}
    }
`
        );
      }
    }

    // Add desugaring dependency
    if (!contents.includes(DESUGARING_DEP)) {
      contents = contents.replace(
        /(dependencies\s*{)/m,
        `$1\n    ${DESUGARING_DEP}${DESUGARING_DEP_VER}\n`
      );
    }

    // Add google-services plugin
    if (!contents.includes(GOOGLE_SERVICES_PLUGIN)) {
      contents = `${contents.trim()}\n\n${GOOGLE_SERVICES_PLUGIN}\n`;
    }

    config.modResults.contents = contents;
    return config;
  });
