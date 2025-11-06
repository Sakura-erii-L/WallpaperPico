# WallpaperPico

一个简洁的壁纸管理和展示项目 | A minimalist wallpaper management and showcase project

## 📋 目录 | Table of Contents

- [项目简介](#项目简介--project-introduction)
- [项目结构](#项目结构--project-structure)
- [数据说明](#数据说明--data-description)
- [如何获取数据](#如何获取数据--how-to-obtain-data)
- [快速开始](#快速开始--quick-start)
- [使用方法](#使用方法--usage)
- [贡献指南](#贡献指南--contribution-guide)

## 项目简介 | Project Introduction

WallpaperPico 是一个轻量级的壁纸管理项目，旨在提供简单、高效的壁纸组织和展示方案。

WallpaperPico is a lightweight wallpaper management project designed to provide simple and efficient wallpaper organization and display solutions.

## 项目结构 | Project Structure

推荐的项目结构如下：

```
WallpaperPico/
├── README.md                 # 项目说明文档
├── wallpapers/              # 壁纸存储目录
│   ├── nature/              # 自然风光类
│   ├── abstract/            # 抽象艺术类
│   ├── minimalist/          # 简约风格类
│   └── ...                  # 其他分类
├── thumbnails/              # 缩略图目录（可选）
├── data/                    # 数据文件目录
│   ├── metadata.json        # 壁纸元数据
│   └── tags.json           # 标签分类数据
├── src/                     # 源代码目录（如果有）
└── docs/                    # 文档目录
```

## 数据说明 | Data Description

### 壁纸数据 | Wallpaper Data

本项目中的"数据"主要指：

The "data" in this project mainly refers to:

1. **壁纸图片文件** - 存储在 `wallpapers/` 目录下
   - 支持格式：JPG, PNG, WEBP
   - 推荐分辨率：1920x1080 或更高
   - Supported formats: JPG, PNG, WEBP
   - Recommended resolution: 1920x1080 or higher

2. **元数据文件** - 存储在 `data/` 目录下
   - `metadata.json`: 包含每张壁纸的详细信息（作者、标签、日期等）
   - `tags.json`: 标签分类信息
   - `metadata.json`: Contains detailed information for each wallpaper (author, tags, date, etc.)
   - `tags.json`: Tag classification information

### 元数据格式示例 | Metadata Format Example

```json
{
  "wallpapers": [
    {
      "id": "001",
      "filename": "sunset-beach.jpg",
      "title": "海滩日落 | Beach Sunset",
      "category": "nature",
      "tags": ["sunset", "beach", "ocean"],
      "resolution": "1920x1080",
      "author": "Your Name",
      "date": "2025-11-06",
      "description": "美丽的海滩日落景色 | Beautiful beach sunset scene"
    }
  ]
}
```

## 如何获取数据 | How to Obtain Data

### 方法一：手动添加 | Method 1: Manual Addition

1. 创建必要的目录结构：
   ```bash
   mkdir -p wallpapers/nature wallpapers/abstract wallpapers/minimalist
   mkdir -p data thumbnails
   ```

2. 将您的壁纸图片放入对应的分类目录中

3. 创建 `data/metadata.json` 文件并添加壁纸信息

### 方法二：从外部源获取 | Method 2: From External Sources

您可以从以下来源获取免费壁纸：

You can obtain free wallpapers from:

- **Unsplash** (https://unsplash.com) - 高质量免费图片
- **Pexels** (https://www.pexels.com) - 免费商用图片
- **Pixabay** (https://pixabay.com) - 免费图片和视频
- **Wallhaven** (https://wallhaven.cc) - 壁纸专用网站

### 方法三：使用脚本批量导入 | Method 3: Batch Import with Scripts

创建一个简单的导入脚本 `import.sh`:

```bash
#!/bin/bash
# 批量导入壁纸脚本

SOURCE_DIR="$1"
CATEGORY="$2"
TARGET_DIR="wallpapers/$CATEGORY"

mkdir -p "$TARGET_DIR"

for file in "$SOURCE_DIR"/*; do
    if [[ -f "$file" ]]; then
        cp "$file" "$TARGET_DIR/"
        echo "已导入: $(basename "$file")"
    fi
done

echo "导入完成！"
```

使用方法：
```bash
chmod +x import.sh
./import.sh /path/to/your/images nature
```

## 快速开始 | Quick Start

1. **克隆项目** | Clone the project
   ```bash
   git clone https://github.com/Sakura-erii-L/WallpaperPico.git
   cd WallpaperPico
   ```

2. **创建目录结构** | Create directory structure
   ```bash
   mkdir -p wallpapers/{nature,abstract,minimalist}
   mkdir -p data thumbnails
   ```

3. **添加您的壁纸** | Add your wallpapers
   ```bash
   # 复制您的壁纸到相应目录
   cp /path/to/your/wallpaper.jpg wallpapers/nature/
   ```

4. **创建元数据文件** | Create metadata file
   ```bash
   cat > data/metadata.json << 'EOF'
   {
     "wallpapers": []
   }
   EOF
   ```

## 使用方法 | Usage

### 基本使用 | Basic Usage

1. **浏览壁纸** - 直接在 `wallpapers/` 目录下查看
2. **设置壁纸** - 使用您的操作系统的壁纸设置功能
3. **管理分类** - 在相应的子目录中添加或删除壁纸

### 高级功能（待开发）| Advanced Features (To be developed)

- [ ] Web 界面浏览壁纸
- [ ] 自动生成缩略图
- [ ] 随机壁纸更换
- [ ] 壁纸下载管理器
- [ ] 标签搜索和筛选

## 贡献指南 | Contribution Guide

欢迎贡献您的壁纸或代码！

Welcome to contribute your wallpapers or code!

### 贡献壁纸 | Contributing Wallpapers

1. Fork 本项目
2. 添加您的壁纸到适当的分类目录
3. 更新 `data/metadata.json` 文件
4. 提交 Pull Request

### 贡献代码 | Contributing Code

1. Fork 本项目
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 许可证 | License

本项目采用 MIT 许可证 - 查看 LICENSE 文件了解详情

This project is licensed under the MIT License - see the LICENSE file for details

## 常见问题 | FAQ

### Q: 目前项目里有数据吗？
**A:** 目前项目刚刚建立，还没有壁纸数据。您需要按照上述方法自行添加壁纸。

### Q: Does the project currently have data?
**A:** The project is newly established and does not yet have wallpaper data. You need to add wallpapers yourself following the methods above.

### Q: 推荐的图片格式是什么？
**A:** 推荐使用 JPG（适合照片）或 PNG（适合图形），分辨率建议 1920x1080 或更高。

### Q: What image format is recommended?
**A:** JPG (for photos) or PNG (for graphics) is recommended, with a resolution of 1920x1080 or higher.

### Q: 可以商用这些壁纸吗？
**A:** 这取决于您从哪里获取壁纸。请确保您拥有使用权限或使用免费商用的图片源。

### Q: Can these wallpapers be used commercially?
**A:** It depends on where you obtain the wallpapers. Please ensure you have usage rights or use free commercial image sources.

---

**Made with ❤️ by Sakura-erii-L**
