# 小鹤音形 fcitx5 码表

供 fcitx5 / fcitx5-android 使用的小鹤音形码表。

## 安装方式

### 从 AUR 获取

对于 Arch Linux 用户，可以直接在 AUR 获取：

假设你使用的 AUR Helper 是 `yay`

```bash
yay -S fcitx5-flypy
```

### 从 Github Release 获取

1. 从 [Github Release](https://github.com/cubercsl/rime-flypy/releases) 获取`fcitx5-table-flypy.zip` 中的 `flypy.conf` 与 `flypy.dict` 两个文件。
2. 将 `flypy.dict` 添加至 `~/.local/share/fcitx5/table/` 目录
3. 将 `flypy.conf` 添加至 `~/.local/share/fcitx5/inputmethod/` 目录

对于 Android 系统，可以直接在 “插件” —— “码表” 中选择 zip 包直接导入。

### 从文本码表编译安装

以下给出不同发行版可能的安装方式：

#### Debian / Ubuntu

```bash
apt install libime-bin
make && make install
```

#### Arch

```bash
pacman -S libime
make && make install
```
