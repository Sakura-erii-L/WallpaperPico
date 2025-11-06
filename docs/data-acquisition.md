# 数据获取指南 | Data Acquisition Guide

本文档详细说明如何获取和管理 WallpaperPico 项目中的壁纸数据。

This document details how to obtain and manage wallpaper data in the WallpaperPico project.

## 目录 | Table of Contents
- [当前数据状态](#当前数据状态--current-data-status)
- [获取壁纸的方法](#获取壁纸的方法--methods-to-obtain-wallpapers)
- [数据组织建议](#数据组织建议--data-organization-recommendations)
- [自动化工具](#自动化工具--automation-tools)

## 当前数据状态 | Current Data Status

**项目当前状态：** 项目框架已建立，但尚未包含实际的壁纸图片文件。

**Current project status:** The project framework is established, but does not yet contain actual wallpaper image files.

**已包含的内容：**
- ✅ 目录结构
- ✅ 元数据模板 (data/metadata.json)
- ✅ 标签定义 (data/tags.json)
- ✅ 导入脚本 (import.sh)
- ✅ 文档说明

**What's included:**
- ✅ Directory structure
- ✅ Metadata template (data/metadata.json)
- ✅ Tag definitions (data/tags.json)
- ✅ Import script (import.sh)
- ✅ Documentation

**需要您添加的：**
- ⏳ 壁纸图片文件
- ⏳ 完整的元数据信息

**What you need to add:**
- ⏳ Wallpaper image files
- ⏳ Complete metadata information

## 获取壁纸的方法 | Methods to Obtain Wallpapers

### 1. 免费图片网站 | Free Image Websites

#### Unsplash (推荐 | Recommended)
- 网址 | URL: https://unsplash.com
- 特点 | Features: 高质量、免费商用、无需注册
- API: https://unsplash.com/developers

```bash
# 使用 Unsplash API 示例（需要 API key）
# Example using Unsplash API (requires API key)
curl -H "Authorization: Client-ID YOUR_ACCESS_KEY" \
  "https://api.unsplash.com/photos/random?query=nature" > wallpaper.jpg
```

#### Pexels
- 网址 | URL: https://www.pexels.com
- 特点 | Features: 免费高质量图片和视频
- API: https://www.pexels.com/api/

#### Pixabay
- 网址 | URL: https://pixabay.com
- 特点 | Features: 免费图片、插图、矢量图

#### Wallhaven
- 网址 | URL: https://wallhaven.cc
- 特点 | Features: 专业壁纸网站，分类详细

### 2. 手动下载和整理 | Manual Download and Organization

**步骤 | Steps:**

1. **选择并下载壁纸 | Select and download wallpapers**
   ```bash
   # 创建临时下载目录
   mkdir -p ~/Downloads/wallpapers-temp
   ```

2. **使用导入脚本 | Use import script**
   ```bash
   # 导入到自然类别
   ./import.sh ~/Downloads/wallpapers-temp nature
   ```

3. **更新元数据 | Update metadata**
   编辑 `data/metadata.json`，添加新壁纸信息

### 3. 使用爬虫批量下载 | Batch Download with Web Scraper

**Python 示例 | Python Example:**

```python
#!/usr/bin/env python3
import requests
import json
from pathlib import Path

def download_from_unsplash(query, count=10):
    """从 Unsplash 下载壁纸"""
    ACCESS_KEY = "YOUR_ACCESS_KEY"
    url = f"https://api.unsplash.com/photos/random"
    
    headers = {"Authorization": f"Client-ID {ACCESS_KEY}"}
    params = {"query": query, "count": count, "orientation": "landscape"}
    
    response = requests.get(url, headers=headers, params=params)
    photos = response.json()
    
    metadata = []
    
    for idx, photo in enumerate(photos):
        # 下载图片
        img_url = photo["urls"]["full"]
        img_data = requests.get(img_url).content
        
        filename = f"{query}-{idx+1}.jpg"
        filepath = Path("wallpapers") / query / filename
        
        filepath.parent.mkdir(parents=True, exist_ok=True)
        with open(filepath, "wb") as f:
            f.write(img_data)
        
        # 收集元数据
        metadata.append({
            "id": photo["id"],
            "filename": filename,
            "title": photo.get("description") or photo.get("alt_description"),
            "category": query,
            "tags": [query],
            "resolution": f"{photo['width']}x{photo['height']}",
            "author": photo["user"]["name"],
            "date": photo["created_at"][:10],
            "description": photo.get("description", "")
        })
        
        print(f"Downloaded: {filename}")
    
    return metadata

# 使用示例
if __name__ == "__main__":
    categories = ["nature", "abstract", "minimalist"]
    all_metadata = []
    
    for category in categories:
        print(f"\nDownloading {category} wallpapers...")
        metadata = download_from_unsplash(category, count=5)
        all_metadata.extend(metadata)
    
    # 保存元数据
    with open("data/metadata.json", "w", encoding="utf-8") as f:
        json.dump({"wallpapers": all_metadata}, f, indent=2, ensure_ascii=False)
    
    print("\nAll downloads completed!")
```

### 4. 从本地照片库导入 | Import from Local Photo Library

```bash
# macOS 照片库
./import.sh ~/Pictures/Photos nature

# Windows 图片文件夹
./import.sh /c/Users/YourName/Pictures nature

# Linux
./import.sh ~/Pictures nature
```

## 数据组织建议 | Data Organization Recommendations

### 文件命名规范 | File Naming Convention

**推荐格式 | Recommended Format:**
```
[类别]-[描述]-[序号].jpg
[category]-[description]-[number].jpg
```

**示例 | Examples:**
- `nature-mountain-sunset-001.jpg`
- `abstract-geometric-pattern-001.png`
- `minimalist-blue-gradient-001.jpg`

### 分辨率建议 | Resolution Recommendations

| 用途 | 最小分辨率 | 推荐分辨率 |
|------|-----------|-----------|
| 桌面 | 1920x1080 | 2560x1440 或 3840x2160 |
| 移动端 | 1080x1920 | 1440x2960 |
| 双屏 | 3840x1080 | 5120x1440 |

| Use Case | Minimum Resolution | Recommended Resolution |
|----------|-------------------|----------------------|
| Desktop | 1920x1080 | 2560x1440 or 3840x2160 |
| Mobile | 1080x1920 | 1440x2960 |
| Dual Monitor | 3840x1080 | 5120x1440 |

### 元数据最佳实践 | Metadata Best Practices

**必填字段 | Required Fields:**
- `id` - 唯一标识符
- `filename` - 文件名
- `category` - 分类

**推荐字段 | Recommended Fields:**
- `title` - 标题（便于搜索）
- `tags` - 标签（便于分类）
- `resolution` - 分辨率
- `author` - 作者（尊重版权）
- `date` - 日期

## 自动化工具 | Automation Tools

### 批量重命名工具 | Batch Rename Tools

```bash
#!/bin/bash
# rename-wallpapers.sh
# 批量重命名壁纸文件

CATEGORY="$1"
DIR="wallpapers/$CATEGORY"

if [ -z "$CATEGORY" ]; then
    echo "用法: ./rename-wallpapers.sh <category>"
    exit 1
fi

counter=1
for file in "$DIR"/*; do
    if [[ -f "$file" ]]; then
        ext="${file##*.}"
        newname="$DIR/${CATEGORY}-$(printf "%03d" $counter).$ext"
        mv "$file" "$newname"
        echo "Renamed: $(basename "$file") -> $(basename "$newname")"
        ((counter++))
    fi
done
```

### 生成元数据工具 | Generate Metadata Tool

```bash
#!/bin/bash
# generate-metadata.sh
# 自动生成基本元数据

CATEGORY="$1"
OUTPUT="data/metadata-$CATEGORY.json"

echo '{"wallpapers": [' > "$OUTPUT"

first=true
for file in wallpapers/$CATEGORY/*; do
    if [[ -f "$file" ]] && [[ "$file" != *".gitkeep" ]]; then
        filename=$(basename "$file")
        id=$(echo "$filename" | sed 's/\.[^.]*$//')
        
        # 获取图片尺寸（需要 ImageMagick）
        if command -v identify &> /dev/null; then
            dimensions=$(identify -format "%wx%h" "$file")
        else
            dimensions="unknown"
        fi
        
        if [ "$first" = false ]; then
            echo ',' >> "$OUTPUT"
        fi
        first=false
        
        cat >> "$OUTPUT" << EOF
  {
    "id": "$id",
    "filename": "$filename",
    "title": "$filename",
    "category": "$CATEGORY",
    "tags": ["$CATEGORY"],
    "resolution": "$dimensions",
    "author": "Unknown",
    "date": "$(date +%Y-%m-%d)",
    "description": ""
  }
EOF
    fi
done

echo '' >> "$OUTPUT"
echo ']}' >> "$OUTPUT"

echo "元数据已生成: $OUTPUT"
```

## 版权和许可 | Copyright and Licensing

**重要提示 | Important Notes:**

1. **检查许可证 | Check License**
   - 确保您有权使用下载的图片
   - 注意商用限制
   - Ensure you have the right to use downloaded images
   - Be aware of commercial use restrictions

2. **署名 | Attribution**
   - 在元数据中记录作者信息
   - 遵守 CC 许可证要求
   - Record author information in metadata
   - Follow CC license requirements

3. **推荐来源 | Recommended Sources**
   - Unsplash (Unsplash License - 免费商用)
   - Pexels (Pexels License - 免费商用)
   - Pixabay (Pixabay License - 免费商用)

## 数据管理工具推荐 | Recommended Data Management Tools

### 图片处理 | Image Processing
- **ImageMagick** - 命令行图片处理
- **GIMP** - 开源图片编辑器
- **XnConvert** - 批量图片转换

### 元数据管理 | Metadata Management
- **ExifTool** - EXIF 元数据编辑
- **jq** - JSON 处理工具

### 版本控制 | Version Control
- **Git LFS** - 大文件版本控制
- **DVC** - 数据版本控制

## 常见问题 | FAQ

### Q: 现在项目里有壁纸数据吗？
**A:** 目前项目只有框架和示例数据，没有实际的壁纸图片。您需要使用上述方法添加壁纸。

### Q: Does the project currently have wallpaper data?
**A:** Currently the project only has the framework and sample data, no actual wallpaper images. You need to add wallpapers using the methods above.

### Q: 推荐从哪里开始？
**A:** 建议从 Unsplash 开始，使用手动下载 + 导入脚本的方式添加 10-20 张壁纸作为起点。

### Q: Where should I start?
**A:** It's recommended to start with Unsplash, using manual download + import script to add 10-20 wallpapers as a starting point.

### Q: 如何管理大量壁纸？
**A:** 考虑使用 Git LFS 或将图片存储在云服务（如 Cloudinary、Imgur）中，仅在仓库中保存元数据。

### Q: How to manage a large number of wallpapers?
**A:** Consider using Git LFS or storing images on cloud services (like Cloudinary, Imgur), keeping only metadata in the repository.

---

**提示 | Tip:** 开始时建议先添加少量高质量壁纸，然后逐步扩充。质量比数量更重要！

Start with a small collection of high-quality wallpapers, then gradually expand. Quality is more important than quantity!
