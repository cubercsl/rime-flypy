# 小鹤音形 Rime 挂接 For Linux

![](https://img.shields.io/aur/version/rime-flypy)

本仓库从小鹤音形官方 macOS 鼠须管挂接包提取码表，并提供适用于 Linux 的 Rime 配置与 fcitx5 码表。

[fcitx5 码表](../fcitx5/README.md)

## 安装

### Arch Linux

可通过 AUR 安装：

```bash
yay -S rime-flypy
```

### Plum

配方：℞ **cubercsl/rime-flypy**

在 [plum](https://github.com/rime/plum) 目录中执行：

```bash
bash rime-install cubercsl/rime-flypy
```

### 手动安装

将仓库中的 schema、dictionary 和 Lua 文件复制到 Rime 系统资料夹或用户资料夹。不同发行版与输入法前端的路径可能不同。

> [!IMPORTANT]
> 本仓库使用拆分后的 YAML 词典实现模式切换，不使用上游 `flypy_sys.txt`、`flypy_top.txt` 和 `flypy_user.txt` 的挂接方式，因此不能直接替换为上游预编译文件。

#### Debian / Ubuntu

```bash
apt install librime-bin librime-data
debian-rime-processor default
make install
```

#### Arch Linux

```bash
pacman -S librime
for file in $(pacman -Qql rime-prelude | grep -v "/$"); do ln -sf "$file"; done
make dict
make install
```

## 使用

在 Rime 用户资料夹中启用输入方案并重新部署。例如，`fcitx5-rime` 用户可编辑 `~/.local/share/fcitx5/rime/default.custom.yaml`：

```yaml
patch:
  schema_list:
    - schema: flypy
```

也可在用户资料夹执行：

```bash
rime_deployer --add-schema flypy
rime_deployer --build "$(pwd)" /usr/share/rime-data
```

### 用户词库

用户词库位于 `flypy/flypy.user.dict.yaml` 和 `flypy/flypy.user.top.dict.yaml`，仓库版本保持为空。如需定制，请将文件复制到 Rime 用户资料夹后编辑。

### 补充简码与模式切换

新建 `flypy.custom.dict.yaml`，按需调整 `import_tables`。例如启用二简次选并关闭一简次选：

```diff
--- flypy.dict.yaml
+++ flypy.custom.dict.yaml
@@
-  # - 'flypy/flypy.secondary.short.code'  # 二简次选
-  - 'flypy/flypy.primary.short.word'      # 一简次选
+  - 'flypy/flypy.secondary.short.code'    # 二简次选
+  # - 'flypy/flypy.primary.short.word'    # 一简次选
```

然后在 `flypy.custom.yaml` 中使用该词典：

```yaml
patch:
  translator/dictionary: flypy.custom
```

### ok 拼字

Rime 中输入以 `ok` 开头的六码或八码拆分编码，可使用根目录 `flypyok.dict.yaml` 中的拼字词典。词典内部仅保存剔除 `ok` 前缀后的四码或六码，`affix_segmentor@ok_mode` 负责识别并移除用户输入的 `ok` 前缀。主码表保持四码上限；fcitx5 不包含 ok 拼字。

## 更新码表

更新需要 `rime_table_decompiler`、`rime_deployer` 和 Python 3。将官方鼠须管包解压后，设定其中的 `rime` 目录与目标版本号：

```bash
source_dir=/path/to/upstream/rime
version=10.26.1
```

同步上游主码表二进制：

```bash
cp "$source_dir"/build/flypy.{prism,reverse,table}.bin assets/
```

生成仓库使用的规范化词典：

```bash
scripts/rime-flypy-dict \
  --assets assets \
  --output . \
  --version "$version"

scripts/flypy-txt2yaml \
  --source-dir "$source_dir" \
  --output-dir . \
  --version "$version"
```

`scripts/flypy-txt2yaml` 直接读取上游 `flypydz.dict.yaml`，去除完全重复的词条，并按编码稳定排序。反查词典不再经过编译与反编译，也不需要在 `assets` 中保存 `flypydz` 二进制文件。

同步 `flypy.dict.yaml`、`flypy.schema.yaml`、`flypyok.schema.yaml` 和 `flypydz.schema.yaml` 的版本后，执行：

```bash
make dict
make -C fcitx5 clean
make -C fcitx5
git diff --check
```

## 问题反馈

请通过 [GitHub Issues](https://github.com/cubercsl/rime-flypy/issues) 反馈问题。
