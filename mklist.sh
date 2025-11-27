#!/bin/bash

# 1. 切換到此腳本所在的資料夾
cd "$(dirname "$0")"

# 2. 開始寫入 list.js 頭部
echo "const songList = [" > list.js

echo "🔍 開始掃描樂譜..."
echo "--------------------------------"

# 設定變數來判斷是否為第一筆資料 (為了 JSON 的逗號格式)
first=true
count=0

# 3. 掃描所有 .txt 檔案
for f in *.txt; do
    # 確保檔案存在 (處理空資料夾的情況)
    [ -e "$f" ] || continue

    # A. 排除 index.txt
    if [[ "$f" == "index.txt" ]]; then
        continue
    fi
    
    # B. 排除這個腳本產生的 list.txt 或其他系統檔 (如果有)
    if [[ "$f" == "list.txt" ]]; then
        continue
    fi

    # C. 【關鍵檢查】檔名必須包含底線 "_"
    # 格式：[[ 字串 == *底線* ]]
    if [[ "$f" == *"_"* ]]; then
        # --- 符合格式，寫入 list.js ---
        
        if [ "$first" = true ]; then
            # 第一筆前面不加逗號
            echo "  \"$f\"" >> list.js
            first=false
        else
            # 第二筆以後，前面加逗號
            echo "  ,\"$f\"" >> list.js
        fi
        
        echo "✅ 加入：$f"
        ((count++))
    else
        # --- 不符合格式，略過 ---
        echo "⚠️ 跳過 (格式不符)：$f"
    fi
done

# 4. 寫入 list.js 尾部
echo "];" >> list.js

echo "--------------------------------"
echo "🎉 處理完成！共收錄 $count 首樂譜。"
echo "📄 list.js 已更新。"
echo "視窗將在 5 秒後關閉..."
sleep 5