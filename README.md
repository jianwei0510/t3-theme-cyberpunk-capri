<p align="center">
  <img src="https://github.com/jianwei0510/t3-theme-cyberpunk-capri/releases/download/assets-v1/cyberpunk-capri-banner.webp" alt="Cyberpunk Capri, an animated dark theme for T3 Code" width="100%">
</p>

# Cyberpunk Capri

把《Cyberpunk: Edgerunners 2》的 Capri（Project Capricorn）帶進 [T3 Code](https://github.com/pingdotgg/t3code)。粉紅、暗紅與螢光綠的介面，加上一位偶爾訊號失真的角色。

- **角色在右，文字在左：** 對話欄保持乾淨，長時間閱讀不受背景干擾。
- **克制的動態：** 背景約每 11 秒閃爍兩次，其餘時間完全靜止。
- **完整配色：** 側欄、對話框、程式碼、終端機和搜尋結果都有對應顏色。

## 選擇版本

| 版本 | 內容 | 適合 |
| --- | --- | --- |
| **Cyberpunk Capri Animated** | 深色配色與角色動態背景 | 想要完整視覺效果 |
| **Cyberpunk Capri** | 深色與淺色配色，不含圖片 | 想要簡潔介面，或需要淺色模式 |

## 安裝

需要 T3 Code 網頁版或桌面版，行動版不支援主題。

### 方法一：安裝腳本（macOS、Linux）

```bash
git clone https://github.com/jianwei0510/t3-theme-cyberpunk-capri.git
cd t3-theme-cyberpunk-capri
./install.sh
```

安裝完成後，到 **Settings → Themes** 選擇 **Cyberpunk Capri Animated**。如果清單裡沒有，請重新載入或重新啟動 T3 Code。

其他選項：

```bash
./install.sh --no-image                             # 只安裝配色，含深色與淺色
./install.sh --image ~/Pictures/my-background.webp  # 使用自己的背景圖
./install.sh --force                                # 覆蓋已安裝的版本
T3_THEMES_DIR=/path/to/themes ./install.sh          # 指定主題資料夾
```

### 方法二：手動安裝（含 Windows）

1. 下載 [`theme/cyberpunk-capri-animated.json`](theme/cyberpunk-capri-animated.json)。
2. 到 [Releases](https://github.com/jianwei0510/t3-theme-cyberpunk-capri/releases/tag/assets-v1) 下載 `cyberpunk-capri-animated.webp`。
3. 把兩個檔案放進 T3 Code 的主題資料夾，主檔名必須相同：

   | 系統 | 預設路徑 |
   | --- | --- |
   | macOS、Linux | `~/.t3/userdata/themes/` |
   | Windows | `%USERPROFILE%\.t3\userdata\themes\` |

4. 重新載入 T3 Code，到 **Settings → Themes** 選擇主題。

### 方法三：只要配色

複製 [`theme/cyberpunk-capri.json`](theme/cyberpunk-capri.json) 的內容，到 **Settings → Themes → Import theme** 貼上。

## 更新

```bash
git pull
./install.sh --force
```

## 解除安裝

先在 **Settings → Themes** 切換到其他主題，再刪除檔案：

```bash
rm -f ~/.t3/userdata/themes/cyberpunk-capri-animated.{json,webp,png,jpg}
rm -f ~/.t3/userdata/themes/cyberpunk-capri.json
```

## 疑難排解

| 狀況 | 處理方式 |
| --- | --- |
| 清單裡沒有主題 | 確認檔案在主題資料夾內，然後重新啟動 T3 Code。 |
| 有配色但沒有背景圖 | 確認圖片與 JSON 主檔名相同，副檔名為 `.webp`、`.png` 或 `.jpg`，大小不超過 16 MB。 |
| 腳本無法下載背景 | 檢查網路，或從 Releases 手動下載後使用 `--image`。 |
| 顯示 `Already installed` | 確認要覆蓋後，加上 `--force`。 |
| 角色被對話欄遮住 | 主題以約 1512px 寬的視窗調整，請把視窗拉寬或收合側邊欄。 |
| 想恢復原狀 | 在 **Settings → Themes** 選擇內建的 T3 Code 主題。 |

## 素材與授權

這是非官方同人主題，與 CD PROJEKT RED、Studio Trigger、《Cyberpunk: Edgerunners》及 T3 Code 官方無關。

- Capri 與作品的角色、名稱和影像權利屬於原權利人。
- 背景圖與橫幅含有衍生自影集畫面的內容，僅供個人、非商業使用，不包含在任何開源授權內。
- 權利人如需移除素材，請開 Issue，我會儘速處理。
