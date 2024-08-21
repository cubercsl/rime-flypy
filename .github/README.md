# 小鹤音形 Rime 挂接 For Linux

![](https://img.shields.io/aur/version/rime-flypy)

小鹤音形官方提供的 MacOS 版本的挂接文件的搬运，加上~~一些~~针对 Linux 系统的补丁，使其更符合 Linux 规范。

[fcitx5 码表](../fcitx5/README.md)

## 安装方式

### 从 AUR 获取

对于 Arch Linux 用户，可以直接在 AUR 获取：

假设你使用的 AUR Helper 是 `yay`

```bash
yay -S rime-flypy
```

### 从 [/plum/](https://github.com/rime/plum) 获取

在 /plum/ 文件夹下执行

```bash
bash rime-install cubercsl/rime-flypy
```

### 手动安装

其他 Linux 发行版可以下载仓库中的内容放置在 Rime 的系统资料夹 `/usr/share/rime-data` 或用户资料夹下。不同的发行版和输入法可能不一样。

以下给出可能的安装方式：

> [!IMPORTANT]  
> 本仓库对模式切换的方式进行了改进，故不再使用和上游相同的配置方式， `flypy_{sys,top,user}.txt` 文件已经被移除。转而使用 `flypy.dict.yaml` 文件进行配置。
> 因此不再支持直接使用上游预编译的 `bin`。

#### 提取词典文件

> [!NOTE]  
> 本仓库已经提供了提取的词典文件，如果你想要自己提取，可以参考以下步骤。

- 从网盘下载小鹤音形挂接文件；
- 运行 `rime_table_decompiler` 提取词典文件，参考[此脚本](scripts/rime-flypy-dict)；
- 手动将 `flypy_{sys,top,user}.txt` 等 txt 的内容整理成 `flypy.*.dict.yaml` 文件，放置在 `flypy` 文件夹下；
- 在 `flypy.dict.yaml` 中导入所需的词库。

#### 从提取的词典文件编译后安装

##### Debian / Ubuntu

```bash
apt install librime-bin librime-data
debian-rime-processor default
make install
```

##### Arch

```bash
pacman -S librime
# Link essentials
for _f in $(pacman -Qql rime-prelude | grep -v "/$"); do ln -sf $_f; done
make && make install
```

## 使用方式

在 Rime 的用户资料夹中开启输入方案并重新部署即可使用。

例如 `fcitx5-rime` 用户，在 `~/.local/share/fcitx5/rime` 中编辑 `default.custom.yaml`

```yaml
patch:
  schema_list:
    - schema: flypy
```

或者在用户资料夹下使用以下命令：

```bash
rime_deployer --add-schema flypy
rime_deployer --build $(pwd) /usr/share/rime-data
```

### 用户词库

用户词库位于 `flypy/flypy.user.dict.yaml` 和 `flypy/flypy.user.top.dict.yaml`，默认为空。

如果想要为当前用户修改用户词库，只需要复制一份到用户目录下编辑即可。获取更新时不会更新用户资料夹下的文件，更新后请注意检查。

### 补充简码方案选择 & 模式切换

- 新建文件 `flypy.custom.dict.yaml`，根据 `flypy.dict.yaml` 的内容，根据需求修改 `import_tables` 中导入的码表。

  例如使用二重简码（代替一简词）：

  ```diff
  --- flypy.dict.yaml
  +++ flypy.custom.dict.yaml
  @@ -13,8 +13,8 @@
     - 'flypy/flypy.emoji'                   # 表情
     - 'flypy/flypy.symbols'                 # 符号
     - 'flypy/flypy.wechat'                  # 微信表情
  -  # - 'flypy/flypy.secondary.short.code'  # 二重简码
  -  - 'flypy/flypy.primary.short.word'      # 一简词
  +  - 'flypy/flypy.secondary.short.code'    # 二重简码
  +  # - 'flypy/flypy.primary.short.word'    # 一简词
     - 'flypy/flypy.whimsicality'            # 随心所欲
     # - 'flypy/flypy.full.char'             # 全码字
     # - 'flypy/flypy.full'                  # 全码词
  ```

- 在 `flypy.custom.yaml` 中导入这份码表：

  ```yaml
  patch:
    translator/dictionary: flypy.custom
  ```

## Issue

If you have any questions, please open an issue.
