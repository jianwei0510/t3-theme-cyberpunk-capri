<p align="center">
  <img src="https://github.com/jianwei0510/t3-theme-cyberpunk-capri/releases/download/assets-v2/cyberpunk-capri-banner.webp" alt="Cyberpunk Capri, an animated dark and light theme for T3 Code" width="100%">
</p>

# Cyberpunk Capri

Bring Capri (Project Capricorn) from *Cyberpunk: Edgerunners 2* into [T3 Code](https://github.com/pingdotgg/t3code), with a pink, crimson, and neon green interface and a character whose signal breaks up now and then.

- **Character on the right, text on the left.** The chat column stays clean, so long sessions stay readable.
- **Restrained motion.** The background glitches twice every 11 seconds and stays still the rest of the time.
- **One theme, both modes.** The colors and animated background follow Light, Dark, or System mode.
- **A complete palette.** The sidebar, chat bubbles, code, terminal, and search results are all themed.

## Choose a version

| Version | Includes | Best for |
| --- | --- | --- |
| **Cyberpunk Capri Animated** | Dark and light colors with an animated background for each mode | The full visual experience |
| **Cyberpunk Capri** | Dark and light colors, no image | A simpler interface |

## Install

You need T3 Code on web or desktop. The mobile app does not support themes.

### Option 1: Install script (macOS and Linux)

```bash
git clone https://github.com/jianwei0510/t3-theme-cyberpunk-capri.git
cd t3-theme-cyberpunk-capri
./install.sh
```

Then finish in T3 Code:

1. Open **Settings → Themes**. If the theme is not listed, reload or restart T3 Code.
2. Choose **Cyberpunk Capri Animated**.
3. Use **Light**, **Dark**, or **System** mode. The colors and background follow your choice.

Other options:

```bash
./install.sh --no-image                             # Colors only, dark and light
./install.sh --image ~/Pictures/my-background.webp  # Use one image for both modes
./install.sh --force                                # Replace an existing install
T3_THEMES_DIR=/path/to/themes ./install.sh          # Use a custom themes folder
```

### Option 2: Manual install (including Windows)

1. Download [`theme/cyberpunk-capri-animated.json`](theme/cyberpunk-capri-animated.json).
2. Download `cyberpunk-capri-animated.webp` from [Releases](https://github.com/jianwei0510/t3-theme-cyberpunk-capri/releases/tag/assets-v2).
3. Put both files in your T3 Code themes folder. Their names must match except for the extension. Do not use **Import theme** for the animated version, because it does not include the background image.

   | System | Default path |
   | --- | --- |
   | macOS and Linux | `~/.t3/userdata/themes/` |
   | Windows | `%USERPROFILE%\.t3\userdata\themes\` |

   If you set `T3CODE_HOME`, use `$T3CODE_HOME/userdata/themes` instead. For a remote T3 Code server, install on the machine running the server.

4. Reload T3 Code, then choose **Cyberpunk Capri Animated** in **Settings → Themes**.

### Option 3: Colors only

Copy the contents of [`theme/cyberpunk-capri.json`](theme/cyberpunk-capri.json), then paste them into **Settings → Themes → Import theme**.

## Update

```bash
git pull
./install.sh --force
```

If you installed the older **Cyberpunk Capri Animated Light**, choose **Cyberpunk Capri Animated** in **Settings → Themes** after updating. You can then delete the old light theme files.

## Uninstall

Switch to another theme in **Settings → Themes**, then delete the files:

```bash
rm -f ~/.t3/userdata/themes/cyberpunk-capri-animated.{json,webp,png,jpg}
rm -f ~/.t3/userdata/themes/cyberpunk-capri-animated-light.{json,webp,png,jpg}
rm -f ~/.t3/userdata/themes/cyberpunk-capri.json
```

## Troubleshooting

| Problem | Fix |
| --- | --- |
| The theme is not listed | Check that the files are in the themes folder, then restart T3 Code. T3 Code loads at most 32 themes from this folder, so remove unused ones if you have more. |
| The background shows two images | The theme file and image are from different versions. Run `git pull`, then `./install.sh --force`. |
| Colors work but the background is missing | The image and JSON must share a name. Use `.webp`, `.png`, or `.jpg`, up to 16 MB. |
| The script cannot download the background | Check your connection, or follow the manual install steps. |
| The script says `Already installed` | Add `--force` to replace the existing files. |
| The chat column covers the character | The theme is tuned for windows about 1512px wide. Widen the window or collapse the sidebar. |
| You want the original look back | Choose the built-in T3 Code theme in **Settings → Themes**. |

## Credits and license

This is an unofficial fan theme. It is not affiliated with or endorsed by CD PROJEKT RED, Studio Trigger, *Cyberpunk: Edgerunners*, or T3 Code.

- Capri and all related characters, names, and images belong to their respective owners.
- The background and banner contain material derived from the series. They are for personal, non-commercial use and are not covered by any open source license.
- Rights holders can open an issue to request removal, and the material will be taken down promptly.
