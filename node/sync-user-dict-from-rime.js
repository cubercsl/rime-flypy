const fs = require('node:fs');
const path = require('node:path');
const os = require('node:os');

const flypyDirPath = path.join(__dirname, '..', 'flypy');
const rimeDirPath = os.platform() === 'win32'
  ? path.join(process.env.APPDATA || process.env.USERPROFILE, 'Rime')
  : path.join(process.env.HOME || process.env.USERPROFILE, 'Library/Rime');

const inRimeDirPath = (subPath = '') => path.join(rimeDirPath, subPath);
const inFlypyDirPath = (subPath = '') => path.join(flypyDirPath, subPath);

function syncFile(fromFile = '', tempFileName = '') {
  if (!fs.existsSync(fromFile)) {
    console.error(`File not found: ${fromFile}`);
    return;
  }
  const tempFilePath = inFlypyDirPath(`${tempFileName}.dict.yaml`);
  if (!fs.existsSync(tempFilePath)) {
    console.error(`File not found: ${tempFilePath}`);
    return;
  }
  const fromContent = fs.readFileSync(fromFile, 'utf-8');
  const tempContent = fs.readFileSync(tempFilePath, 'utf-8');
  const [header] = tempContent.split('\n...\n') || [];

  const contentWithOutPreserveLines = fromContent.replace(/^[^\s]+\s;$/gm, '');
  const contentWithOutComment = contentWithOutPreserveLines.replace(/#.*$/gm, '');
  const contentWithOutCommentAndEmptyLines = contentWithOutComment.replace(/^\s*[\r\n]/gm, '');
  const newContent = `${header}\n...\n\n${contentWithOutCommentAndEmptyLines}`;
  if (newContent !== tempContent) {
    const toFile = inFlypyDirPath(`${tempFileName}.sync.dict.yaml`);
    console.log(`Updating ${toFile}...`);
    fs.writeFileSync(toFile, newContent, 'utf-8');
  } else {
    console.log(`${toFile} is up to date.`);
  }
}

function main() {
  syncFile(inRimeDirPath('flypy_top.txt'), 'flypy.user.top');
  syncFile(inRimeDirPath('flypy_user.txt'), 'flypy.user');
}

if (require.main === module) {
  main();
}
