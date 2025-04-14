#!/usr/bin/env node
/**
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, December 2004
 *
 * Copyright (C) 2022 cubercsl <2014cais01 at gmail dot com>
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 *  0. You just DO WHAT THE FUCK YOU WANT TO.
 */

const fs = require('fs');
const path = require('path');

const root = path.dirname(__dirname);

function* txtFile(name) {
  const content = fs.readFileSync(path.join(root, name), 'utf-8');
  const lines = content.split('\n');
  
  for (const line of lines) {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#')) {
      const parts = trimmed.split(/\s+/);
      const token = parts[0];
      const code = parts[1];
      yield [code, token];
    }
  }
}

function* yamlFile(name) {
  const content = fs.readFileSync(path.join(root, name), 'utf-8');
  const lines = content.split('\n');
  
  let data = false;
  for (const line of lines) {
    const trimmed = line.trim();
    if (data && trimmed) {
      const parts = trimmed.split(/\s+/);
      const token = parts[0];
      const code = parts[1];
      yield [code, token];
    }
    if (!data && trimmed === '...') {
      data = true;
    }
  }
}

const header = `;fcitx Version 0x03 Table file
键码=abcdefghijklmnopqrstuvwxyz;'
码长=4
构词=^
[组词规则]
e2=p11+p12+p21+p22
e3=p11+p21+p31+p32
a4=p11+p21+p31+n11
[数据]`;

function main() {
  console.log(header);
  
  for (const [code, word] of yamlFile('flypydz.dict.yaml')) {
    console.log(`^${code.substring(0, 2)} ${word}`);
  }
  
  const files = [
    'flypy.user.top',
    // 'flypy.full.top',
    'flypy.fast.symbols',
    'flypy.primary',
    'flypy.secondary',
    'flypy.three',
    'flypy.web',
    'flypy.emoji',
    'flypy.symbols',
    'flypy.wechat',
    'flypy.secondary.short.code',
    // 'flypy.primary.short.word',
    'flypy.whimsicality',
    // 'flypy.full.char',
    // 'flypy.full',
    'flypy.user'
  ];
  
  for (const f of files) {
    const filePath = path.join('flypy', `${f}.dict.yaml`);
    for (const [code, word] of yamlFile(filePath)) {
      console.log(`${code} ${word}`);
    }
  }
}

if (require.main === module) {
  main();
}
