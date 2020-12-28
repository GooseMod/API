import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';

import glob from 'glob';

import { minify } from 'terser';

import { createHash } from 'crypto';

(async function() {
const baseDir = 'clone/modules';
const outDir = '../out/modules';

const modules = glob.sync(`${baseDir}/***/*.js`);

let jsons = [];

for (let path of modules) {
  console.log(path);

  const content = readFileSync(path, 'utf-8');

  const { name, author, description, version } = eval(`
let goosemodScope = { // Placeholder for modules which try and access goosemodScope top-level
  patcher: {
    inject: () => {},
    uninject: () => {}
  },
  webpackModules: {
    findByProps: () => {}
  }
};

${content}`);

  const split = path.split('/');

  const filename = split.slice(-1)[0].split('.')[0];
  const category = split.slice(-2)[0];

  const codeURL = `https://goosemod-api.netlify.app/modules/${category}/${filename}.js`;

  const outPath = path.replace(baseDir, outDir);
  const dir = outPath.split('/').slice(0, -1).join('/');

  if (!existsSync(dir)) {
    mkdirSync(dir, {recursive: true});
  }

  const minified = (await minify(content)).code + content.split(';').pop().trim();

  writeFileSync(outPath, minified);

  const json = {
    filename,
    category,
    codeURL,

    hash: createHash('sha512').update(minified).digest('hex'),

    name,
    author,
    description,
    version
  };

  jsons.push(json);
}

writeFileSync('../out/modules.json', JSON.stringify(jsons));
})();
