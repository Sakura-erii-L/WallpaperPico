#!/bin/bash
# 批量导入壁纸脚本 | Batch Wallpaper Import Script
# 使用方法 | Usage: ./import.sh <源目录 | source_dir> <分类 | category>

SOURCE_DIR="$1"
CATEGORY="$2"
TARGET_DIR="wallpapers/$CATEGORY"

# 检查参数 | Check parameters
if [ -z "$SOURCE_DIR" ] || [ -z "$CATEGORY" ]; then
    echo "使用方法 | Usage: ./import.sh <源目录 | source_dir> <分类 | category>"
    echo "示例 | Example: ./import.sh ~/Pictures/Wallpapers nature"
    echo ""
    echo "可用分类 | Available categories: nature, abstract, minimalist"
    exit 1
fi

# 检查源目录是否存在 | Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "错误: 源目录不存在 | Error: Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# 创建目标目录 | Create target directory
mkdir -p "$TARGET_DIR"

# 计数器 | Counter
count=0

# 支持的图片格式 | Supported image formats
extensions="jpg jpeg png webp JPG JPEG PNG WEBP"

echo "开始导入壁纸... | Starting import..."
echo "源目录 | Source: $SOURCE_DIR"
echo "目标目录 | Target: $TARGET_DIR"
echo ""

# 遍历源目录中的文件 | Iterate through files in source directory
for file in "$SOURCE_DIR"/*; do
    if [[ -f "$file" ]]; then
        # 获取文件扩展名 | Get file extension
        ext="${file##*.}"
        
        # 检查是否为支持的格式 | Check if format is supported
        if [[ " $extensions " =~ " $ext " ]]; then
            filename=$(basename "$file")
            
            # 检查文件是否已存在 | Check if file already exists
            if [ -f "$TARGET_DIR/$filename" ]; then
                echo "跳过（已存在） | Skipping (exists): $filename"
            else
                cp "$file" "$TARGET_DIR/"
                echo "✓ 已导入 | Imported: $filename"
                ((count++))
            fi
        fi
    fi
done

echo ""
echo "导入完成！ | Import completed!"
echo "成功导入 $count 个文件 | Successfully imported $count files"
echo ""
echo "提示：请更新 data/metadata.json 文件以添加壁纸元数据"
echo "Tip: Please update data/metadata.json to add wallpaper metadata"
