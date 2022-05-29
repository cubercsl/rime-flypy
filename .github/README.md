# 小鹤音形 Rime 挂接 For Linux

![](https://img.shields.io/aur/version/rime-flypy)

小鹤音形官方提供的 MacOS 版本的挂接文件的搬运，加上一些补丁，可以直接在 Linux 系统上挂接使用。

## 安装方式
### 从 AUR 获取

对于 ArchLinux 用户，可以直接在 AUR 获取：

```bash
yay -S rime-flypy
```

### 手动安装
其他 Linux 发行版可以下载仓库中的内容放置在 Rime 的系统资料夹 `/usr/share/rime-data` 或用户资料夹下。不同的发行版和输入法可能不一样。

## 使用方式
在 Rime 的用户资料夹中开启输入方案即可使用。

例如 `fcitx5-rime` 用户，在 `~/.local/share/fcitx5/rime` 中编辑 `default.custom.yaml`

```yaml
patch:
  schema_list:
    - schema: flypy
```

如果想要为当前用户修改用户词库 `flypy_{sys,top,user}.txt`，只需要复制一份到用户目录下编辑即可。获取更新时不会更新用户资料夹下的文件，更新后请注意检查。

### 简字补全
相当于 windows 版 oqm，码表位于 `/usr/share/rime-data/flypy_full`，如需使用可以将其链接到用户目录下：

```
ln -s /usr/share/rime-data/flypy_full/flypy_full.txt ~/.local/share/fcitx5/rime/
```

## Issue
If you have any questions, please open an issue.
