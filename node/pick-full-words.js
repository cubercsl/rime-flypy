const fs = require('node:fs');
const path = require('node:path');

const flypyDirPath = path.join(__dirname, '..', 'flypy');

const targetFiles = [
  'primary',
  'secondary',
  'full',
  'full.top',
].map(name => path.join(flypyDirPath, `flypy.${name}.dict.yaml`));

function pickFullWords(filePath = '') {
  const content = fs.readFileSync(filePath, 'utf-8');
  const regFullWord = /^[^\s]{2}\s[a-z]{4}$/g;
  const fullWordLines = [];
  const lines = content.split('\n');
  lines.forEach((line) => {
    const match = line.match(regFullWord);
    if (match) {
      fullWordLines.push(line);
    }
  });
  return fullWordLines;
}

function main() {
  const outputDirPath = path.join(__dirname, 'dist');
  if (!fs.existsSync(outputDirPath)) {
    fs.mkdirSync(outputDirPath);
  }
  const outputFilePath = path.join(outputDirPath, 'full-words.txt');
  const fullWordLines = [];
  targetFiles.forEach((filePath) => {
    const lines = pickFullWords(filePath);
    fullWordLines.push(...lines);
  });
  fs.writeFileSync(outputFilePath, fullWordLines.join('\n'), 'utf-8');
}

if (require.main === module) {
  main();
}
