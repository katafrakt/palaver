import * as assets from "hanami-assets";
import {sassPlugin} from 'esbuild-sass-plugin'

await assets.run({esbuildOptionsFn: (args, esbuildOptions) => {
  esbuildOptions.plugins.push(sassPlugin({
    filter: /\.scss$/
  }));
  
  return esbuildOptions;
 }});
