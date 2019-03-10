SQA-Tools
===============================

1. [fill_space.sh](#fill_space.sh)
2. [screenshot.sh](#screenshot.sh)

## fill_space.sh

Fill android devices' storage space with dumpy file

使用方法
---

1. 連接 Android 手機，確認 ADB 有找到裝置
2. 鍵入指令
```
usage: $0 [-r|SIZE]
    Options:
    -r
        remove dummy file which located at /sdcard/.tmp_fill
    SIZE
        remaining available space's size(MB)
```

## screenshot.sh

將 Android 裝置的畫面截圖，並傳送到桌面

使用方法
---

1. 連接 Android 手機，確認 ADB 有找到裝置
2. 鍵入指令 `sh screenshot.sh`
3. 螢幕截圖會存於桌面
