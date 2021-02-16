# 小鹤音形 Rime 挂接 For Linux

小鹤音形官方提供的 MacOS 版本的挂接文件的搬运，可以直接在 Linux 系统上挂接使用。

## 使用方式

对于 ArchLinux 用户，可以直接在 AUR 获取：

```bash
yay -S rime-flypy
```

在 Rime 的用户资料夹中开启输入方案即可使用。

例如 `fcitx5-rime` 用户，在 `~/.local/share/fcitx5/rime` 中编辑 `default.custom.yaml`

```yaml
patch:
  schema_list:
    - schema: flypy
```

如果想要为当前用户修改用户词库 `flypy_{sys,top,user}.txt`，只需要复制一份到用户目录下编辑即可。获取更新时不会更新用户资料夹下的文件，更新后请注意检查。

If you have any questions, please open an issue.
