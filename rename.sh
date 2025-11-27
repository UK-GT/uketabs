for f in *.txt; do
    # 利用 sed 來重組檔名
    newname=$(echo "$f" | sed -E 's/^(.*) — (.*) \(.*\)(\.txt)/\2_\1\3/')
    mv "$f" "$newname"
done