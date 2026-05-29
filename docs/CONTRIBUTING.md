[中文](CONTRIBUTING.md) | [English](CONTRIBUTING.en.md)

以下是 SCU Beamer Theme 扩展主题插件贡献指南, SCU Beamer Theme 贡献指南请查看 [#13](https://github.com/FvNCCR228/SCU-Beamer-Theme/discussions/13)

## SCU Beamer Theme 扩展主题插件贡献指南
### 插件系统简介
SCU Beamer Theme 支持通过插件机制加载扩展主题
可参考 [#12](https://github.com/FvNCCR228/SCU-Beamer-Theme/discussions/12) 相关指南定义 SCU Beamer Theme 扩展主题插件. 合并插件信息到本项目 GitHub 仓库后, 用户可通过 `docs/install-plugin.sh` (Linux/MacOS) 或 `docs/install-plugin.bat` (Windows) 脚本一键下载安装所需插件

### 前提条件
1. 你需要创建一个公开的 GitHub 仓库, 用于存放扩展主题插件文件
2. 你可以自定义插件相关的文件 (例如 `.sty`、`.tex`、`.pdf` `.png` 等), 并可以上传独立于 SCU Beamer Theme 的最小示例和说明文档. 请注意, 尽量避免与 SCU Beamer Theme 项目的文件命名冲突. 且若想避免与其他插件存在重复文件, 也可创建 2 级文件夹, 如 `resources/mytheme/image.png`
3. 插件名不得与已有插件重复，可通过以下命令查看：

  Linux/MacOS:
  ```bash
  ./docs/install-plugin.sh -l
  ```

  Windows:
  ```cmd
  .\docs\install-plugin.bat -l
  ```
4. 请确保相关文件的版权归属清晰, 或已获得合法授权. 因版权纠纷导致的任何问题, 本项目概不负责

---
### 插件配置格式

在 `docs/dev/plugins.conf` 中，每个插件由一个 INI 风格的配置块组成：

```ini
# 插件: <插件显示名称> - <插件名(英文标识符)>
[插件名]
repo = GitHub用户名/仓库名
branch = 分支名
files = 文件1 文件2 文件3
name = 插件显示名称
```

#### 字段说明

| 字段 | 说明 | 示例 |
|------|------|------|
| `repo` | 仓库地址, 格式为 `user/repo` | `FvNCCR228/SCU-Beamer-Theme` |
| `branch` | 分支名 | `main` |
| `files` | 需要下载的文件列表(文件命名避免存在空格), 条目间空格分隔, 存在子目录时请列出目录中所有文件路径 | `theme.sty slides.tex resources/image.png` |
| `name` | 插件的显示名称 | `新三国天意爷主题` |

#### 完整示例

假设你的 GitHub 用户名是 `ZhangSan`, 仓库是 `my-beamer-theme`, 分支是 `main`, 需要提供的文件是 `mytheme.sty` 和 `demo.tex` 以及 `resources/mytheme.png`:

```ini
# 插件: 张三自定义主题 - zhangsan-theme
[zhangsan-theme]
repo = ZhangSan/my-beamer-theme
branch = main
files = mytheme.sty demo.tex resources/mytheme.png
name = 张三自定义主题
```

#### 文件要求
1. 文件路径必须与仓库中的实际路径一致, 脚本会按对应路径下载, 否则会缺失文件
2. 文件命名避免存在空格, 如有请改为 `_` 或 `-`
3. 下载时子目录会被自动创建, 如 `resources/mytheme.png` 是合法的
4. 建议在仓库中附上 `README.md`, 说明插件的用途和使用方法
5. 自己的插件仓库中不要提交编译产物 (`.aux`、`.log`、`.synctex.gz` 等), 参考项目根目录的 `.gitignore`

---
### 提交方式
1. Fork 本仓库, 在 `docs/dev/plugins.conf` 中添加你的插件条目, 然后提交 Pull Request
2. PR 经审核通过后方可成为正式插件, 你也会成为本仓库的贡献者

#### 测试你的插件

提交 PR 前, 请在本地完成以下测试

Linux/MacOS:
```bash
# 1. 列出所有插件, 确认你的插件已出现在列表中
./docs/install-plugin.sh -l

# 2. 按名称搜索你的插件
./docs/install-plugin.sh -s <你的插件名>

# 3. 安装测试 (建议在临时目录中操作)
./docs/install-plugin.sh -e <你的插件名>

# 4. 确认文件已正确下载到项目根目录，编译不报错
```

Windows:
```cmd
:: 1. 列出所有插件, 确认你的插件已出现在列表中
.\docs\install-plugin.bat -l

:: 2. 按名称搜索你的插件
.\docs\install-plugin.bat -s <你的插件名>

:: 3. 安装测试 (建议在临时目录中操作)
.\docs\install-plugin.bat -e <你的插件名>

:: 4. 确认文件已正确下载到项目根目录，编译不报错
```

#### PR 提交规范

- 标题格式: `plugin: 添加 <插件显示名称> - <插件名>` (如 `plugin: 添加张三自定义主题 - ZhangSanTheme`)
- PR 描述中需包含：
  1. 插件仓库链接
  2. 插件对应的扩展主题宏包名 (如 `extension-ZhangSan.sty`)
  3. 插件的简要说明和预览截图 (如有)
  4. 本地测试结果确认

---
### 常见问题

**Q: 我的仓库是私有的，可以提交插件吗？**
A: 不可以，插件必须托管在公开仓库，否则其他用户无法下载。

**Q: 一个插件可以包含多个文件吗？**
A: 可以，`files` 字段中用空格分隔多个文件路径即可。

**Q: 插件文件更新后需要重新提交 PR 吗？**
A: 不需要。只要文件路径不变且仍在同一分支，脚本会自动下载最新版本。如果需要新增文件或修改分支，则需更新 PR。
