#!/bin/bash
# iosauto文件重组脚本 - 供GitHub Actions使用

echo "🔧 开始重组iosauto文件..."

# 检查所有片段是否存在
if [ ! -f "iosauto_part_0" ] || [ ! -f "iosauto_part_1" ] || [ ! -f "iosauto_part_2" ]; then
    echo "❌ 缺少必要的片段文件"
    echo "需要的文件："
    echo "  - iosauto_part_0"
    echo "  - iosauto_part_1" 
    echo "  - iosauto_part_2"
    exit 1
fi

echo "✅ 找到所有片段文件"

# 重组文件
cat iosauto_part_0 iosauto_part_1 iosauto_part_2 > iosauto_reassembled

# 验证文件大小
original_size=14114144  # 原始文件大小
reassembled_size=$(stat -c%s "iosauto_reassembled" 2>/dev/null || stat -f%z "iosauto_reassembled" 2>/dev/null)

echo "📊 文件大小检查："
echo "  原始文件: $original_size 字节"
echo "  重组文件: $reassembled_size 字节"

if [ "$reassembled_size" -eq "$original_size" ]; then
    echo "✅ 文件重组成功！大小匹配"
    
    # 设置执行权限
    chmod +x iosauto_reassembled
    
    echo "📁 创建iosauto.framework目录结构..."
    mkdir -p iosauto.framework
    mv iosauto_reassembled iosauto.framework/iosauto
    
    # 复制其他必要文件
    if [ -f "Info.plist" ]; then
        cp Info.plist iosauto.framework/
        echo "✅ 复制Info.plist"
    fi
    
    if [ -d "Headers" ]; then
        cp -r Headers iosauto.framework/
        echo "✅ 复制Headers目录"
    fi
    
    if [ -d "Modules" ]; then
        cp -r Modules iosauto.framework/
        echo "✅ 复制Modules目录"
    fi
    
    if [ -d "Frameworks" ]; then
        cp -r Frameworks iosauto.framework/
        echo "✅ 复制Frameworks目录"
    fi
    
    if [ -d "_CodeSignature" ]; then
        cp -r _CodeSignature iosauto.framework/
        echo "✅ 复制_CodeSignature目录"
    fi
    
    echo "🎉 iosauto.framework重组完成！"
    ls -la iosauto.framework/
else
    echo "❌ 文件大小不匹配，重组失败"
    exit 1
fi 