import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';

import glob from 'glob';

import { minify } from 'terser';

(async function() {
const baseDir = 'clone/modules';
const outDir = '../out/modules';

const modules = glob.sync(`${baseDir}/***/*.js`);

let jsons = [];

for (let path of modules) {
  console.log(path);

  const content = readFileSync(path, 'utf-8');

  const {name, author, description, version} = eval(content);

  const split = path.split('/');

  const filename = split.slice(-1)[0].split('.')[0];
  const category = split.slice(-2)[0];

  const codeURL = `https://raw.githubusercontent.com/GooseMod/Modules/master/modules/${category}/${filename}.js`;

  const json = {
    filename,
    category,
    codeURL,

    name,
    author,
    description,
    version
  };

  jsons.push(json);

  let outPath = path.replace(baseDir, outDir);
  let dir = outPath.split('/').slice(0, -1).join('/');

  if (!existsSync(dir)) {
    mkdirSync(dir, {recursive: true});
  }

  writeFileSync(outPath, (await minify(content)).code + content.split(';').pop().trim());
}

writeFileSync('../out/modules.json', JSON.stringify(jsons));
})();