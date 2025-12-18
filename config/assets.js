import * as assets from "hanami-assets";
import {sassPlugin} from 'esbuild-sass-plugin'
import {dirname, join} from 'path'
import {fileURLToPath} from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))
const projectRoot = join(__dirname, '..')

await assets.run({
  projectRoot: projectRoot,
  esbuildOptionsFn: (args, esbuildOptions) => {
    esbuildOptions.plugins.push(sassPlugin({
      filter: /\.scss$/
    }));

    return esbuildOptions;
  }
});
