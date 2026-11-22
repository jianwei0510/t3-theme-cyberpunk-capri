# Capri Night Sky

以《Cyberpunk: Edgerunners 2》角色 Capri（Project Capricorn）為靈感的 [T3 Code](https://github.com/pingdotgg/t3code) 深色主題。

- 粉紅與暗紅為主色，柔和綠色用於 AI 回覆的重點文字、連結與行內程式碼。
- 角色位於畫面右側，左側與對話欄保持乾淨。
- 背景約每 11 秒出現兩次短暫的橫向閃爍，其餘時間靜止，適合長時間使用。

> 這個 repo 目前是私人專案。背景圖衍生自影集畫面，僅供非商業使用，詳見[素材與授權](#素材與授權)。

## 系統需求

- T3 Code 網頁版或桌面版。行動版不支援主題。
- 使用安裝腳本時需要 `bash`（macOS、Linux）。Windows 請用[手動安裝](#方法二手動安裝)。
- 自動下載背景時需要 [GitHub CLI](https://cli.github.com/)，且帳號要有這個 repo 的存取權。

## 安裝

### 方法一：安裝腳本（建議）

```bash
gh auth login
gh repo clone jianwei0510/t3-theme-capri
cd t3-theme-capri
./install.sh
```

安裝完成後，開啟 T3 Code，到 **Settings → Themes** 選擇 **Capri Night Sky**。如果清單裡沒有，請重新載入或重新啟動 T3 Code。

其他選項：

```bash
./install.sh --image ~/Pictures/my-background.webp  # 使用自己的背景圖
./install.sh --no-image                             # 只安裝配色與漸層
./install.sh --force                                # 覆蓋已安裝的版本
T3_THEMES_DIR=/path/to/themes ./install.sh          # 指定主題資料夾
```

### 方法二：手動安裝

1. 下載 [`theme/capri-night-sky.json`](theme/capri-night-sky.json)。
2. 到 [Releases](https://github.com/jianwei0510/t3-theme-capri/releases/tag/assets-v1) 下載 `capri-night-sky.webp`。
3. 把兩個檔案放進 T3 Code 的主題資料夾，主檔名必須都是 `capri-night-sky`：

   | 系統 | 預設路徑 |
   | --- | --- |
   | macOS、Linux | `~/.t3/userdata/themes/` |
   | Windows | `%USERPROFILE%\.t3\userdata\themes\` |

4. 重新載入 T3 Code，到 **Settings → Themes** 選擇 **Capri Night Sky**。

## 更新

```bash
git pull
./install.sh --force
```

## 解除安裝

先在 **Settings → Themes** 切換到其他主題，再刪除檔案：

```bash
rm -f ~/.t3/userdata/themes/capri-night-sky.{json,webp,png,jpg}
```

## 疑難排解

| 狀況 | 處理方式 |
| --- | --- |
| 清單裡沒有主題 | 確認檔案在主題資料夾內，然後重新啟動 T3 Code。 |
| 有配色但沒有背景圖 | 確認圖片與 JSON 主檔名相同，副檔名為 `.webp`、`.png` 或 `.jpg`，大小不超過 16 MB。 |
| 腳本無法下載背景 | 執行 `gh auth status` 確認登入帳號有 repo 權限，或改用 `--image`。 |
| 顯示 `Already installed` | 確認要覆蓋後，加上 `--force`。 |
| 角色被對話欄遮住 | 主題以約 1512px 寬的視窗調整，請把視窗拉寬或收合側邊欄。 |
| 想恢復原狀 | 在 **Settings → Themes** 選擇內建的 T3 Code 主題。 |

## 素材與授權

- Capri 與《Cyberpunk: Edgerunners 2》的角色、影像權利屬於原權利人。這是非官方同人主題，與原作及 T3 Code 官方無關。
- 背景圖衍生自影集畫面，**免費分享不等於取得授權**，因此它只放在 Release，不進 git 歷史。
- 這個 repo 尚未指定開源授權。公開前請先移除 Release 中的背景圖，並重新確認素材的散布方式。
