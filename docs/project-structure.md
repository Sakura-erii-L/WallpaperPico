# 项目结构详解 | Project Structure Details

## 目录说明 | Directory Description

### wallpapers/ - 壁纸存储目录
这是存储所有壁纸图片的主目录。按照类别组织子目录。

This is the main directory for storing all wallpaper images, organized by category in subdirectories.

**子目录 | Subdirectories:**
- `nature/` - 自然风光类壁纸（风景、植物、动物等）
- `abstract/` - 抽象艺术类壁纸（抽象图案、艺术作品等）
- `minimalist/` - 简约风格类壁纸（极简主义设计）

**注意 | Notes:**
- 可以根据需要添加更多分类目录
- 建议图片文件使用有意义的命名，例如：`sunset-beach-2025.jpg`
- You can add more category directories as needed
- It's recommended to use meaningful file names, e.g., `sunset-beach-2025.jpg`

### data/ - 数据文件目录
存储壁纸的元数据和配置信息。

Stores wallpaper metadata and configuration information.

**文件 | Files:**
- `metadata.json` - 壁纸元数据数据库
- `tags.json` - 标签和分类定义

### thumbnails/ - 缩略图目录
存储壁纸的缩略图，用于快速预览。

Stores wallpaper thumbnails for quick preview.

**建议 | Recommendations:**
- 缩略图尺寸：320x180 或 640x360
- 文件名应与原图对应
- Thumbnail size: 320x180 or 640x360
- Filenames should correspond to original images

### docs/ - 文档目录
存储项目相关的文档和说明。

Stores project-related documentation and instructions.

## 数据结构 | Data Structure

### metadata.json 结构说明

```json
{
  "wallpapers": [
    {
      "id": "唯一标识符 | unique identifier",
      "filename": "文件名 | filename",
      "title": "标题 | title",
      "category": "分类 | category",
      "tags": ["标签数组 | tag array"],
      "resolution": "分辨率 | resolution",
      "author": "作者 | author",
      "date": "日期 | date (YYYY-MM-DD)",
      "description": "描述 | description"
    }
  ]
}
```

### tags.json 结构说明

```json
{
  "tags": [
    {
      "name": "标签名称 | tag name",
      "display_name": "显示名称 | display name",
      "description": "描述 | description"
    }
  ]
}
```

## 扩展建议 | Extension Suggestions

### 未来可以添加的目录 | Future Directories

- `src/` - 源代码目录（如果开发 Web 应用）
- `scripts/` - 辅助脚本目录
- `config/` - 配置文件目录
- `.github/` - GitHub Actions 和工作流

### 未来可以添加的功能 | Future Features

1. **Web 界面** - 浏览和管理壁纸的网页应用
2. **自动化脚本** - 自动下载、处理和组织壁纸
3. **API 接口** - 提供程序化访问壁纸数据的接口
4. **搜索功能** - 根据标签、分类、颜色等搜索壁纸
5. **随机壁纸** - 定时更换桌面壁纸的工具

## 最佳实践 | Best Practices

### 文件命名 | File Naming
- 使用小写字母和连字符：`beach-sunset-2025.jpg`
- 避免使用空格和特殊字符
- 包含描述性信息
- Use lowercase and hyphens: `beach-sunset-2025.jpg`
- Avoid spaces and special characters
- Include descriptive information

### 元数据维护 | Metadata Maintenance
- 添加新壁纸时及时更新 metadata.json
- 保持标签的一致性
- 定期检查和清理无效条目
- Update metadata.json when adding new wallpapers
- Maintain tag consistency
- Regularly check and clean invalid entries

### 版本控制 | Version Control
- 使用 .gitignore 排除大文件（如果使用 Git LFS 可以包含）
- 定期提交更改
- 为重要更新创建标签
- Use .gitignore to exclude large files (can include if using Git LFS)
- Commit changes regularly
- Create tags for important updates

## 常见问题解答 | FAQ

### Q: 如何添加新的分类？
1. 在 `wallpapers/` 下创建新的子目录
2. 在 `data/tags.json` 中添加新分类的标签定义
3. 更新文档说明新分类

### Q: How to add a new category?
1. Create a new subdirectory under `wallpapers/`
2. Add tag definition for the new category in `data/tags.json`
3. Update documentation to explain the new category

### Q: 壁纸文件太大怎么办？
- 使用图片压缩工具（如 TinyPNG, ImageOptim）
- 考虑使用 WebP 格式（更好的压缩比）
- 使用 Git LFS 管理大文件

### Q: What if wallpaper files are too large?
- Use image compression tools (e.g., TinyPNG, ImageOptim)
- Consider using WebP format (better compression ratio)
- Use Git LFS to manage large files

### Q: 如何批量生成缩略图？
可以使用 ImageMagick 等工具批量处理：
```bash
for img in wallpapers/*/*.jpg; do
    convert "$img" -resize 320x180 "thumbnails/$(basename "$img")"
done
```

### Q: How to batch generate thumbnails?
Use tools like ImageMagick for batch processing:
```bash
for img in wallpapers/*/*.jpg; do
    convert "$img" -resize 320x180 "thumbnails/$(basename "$img")"
done
```
