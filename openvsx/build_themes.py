"""Regenerates the VS Code color themes from theme/cyberpunk-capri.json."""
import json,pathlib
here=pathlib.Path(__file__).resolve().parent
src,out=here.parent/"theme"/"cyberpunk-capri.json",here/"themes"
t=json.loads(src.read_text()); D=t['colors']; L=t['variants']['light']
def wb(c,light):
    return {
 "focusBorder":c['accent'],"foreground":c['text'],"descriptionForeground":c['textMuted'],"errorForeground":c['error'],
 "editor.background":c['canvas'],"editor.foreground":c['text'],"editorCursor.foreground":c['terminalCursor'],
 "editor.selectionBackground":c['terminalSelection'],"editor.lineHighlightBackground":c['muted'],
 "editorLineNumber.foreground":c['mutedForeground']+"80","editorLineNumber.activeForeground":c['accent'],
 "editorWidget.background":c['surfaceRaised'],"dropdown.background":c['surfaceRaised'],"menu.background":c['surfaceOverlay'],"quickInput.background":c['surfaceOverlay'],
 "panel.background":c['terminalBackground'],"panel.border":c['border'],"editorGroup.border":c['border'],
 "input.background":c['surfaceRaised'],"input.border":"#0E8F4E","input.foreground":c['text'],"input.placeholderForeground":c['placeholder'],
 "button.background":c['messageAction'],"button.foreground":c['messageActionForeground'],"button.hoverBackground":c['messageActionHover'],
 "textLink.foreground":c['accent'],"badge.background":c['accent'],"badge.foreground":c['accentForeground'],
 "activityBar.background":c['sidebar'],"activityBar.foreground":c['sidebarForeground'],"activityBarBadge.background":c['accent'],"activityBarBadge.foreground":c['accentForeground'],
 "sideBar.background":c['sidebar'],"sideBar.foreground":c['sidebarForeground'],"sideBar.border":c['sidebarBorder'],
 "list.hoverBackground":c['sidebarRowHover'],"list.inactiveSelectionBackground":c['sidebarRowActive'],"list.activeSelectionBackground":c['sidebarRowSelected'],"list.activeSelectionForeground":c['sidebarForeground'],
 "titleBar.activeBackground":c['chrome'],"titleBar.activeForeground":c['toolbarForeground'],"titleBar.border":c['toolbarBorder'],
 "statusBar.background":c['chrome'],"statusBar.foreground":c['toolbarForeground'],"statusBar.border":c['toolbarBorder'],
 "tab.activeBackground":c['canvas'],"tab.inactiveBackground":c['sidebar'],"tab.activeForeground":c['text'],"tab.inactiveForeground":c['textMuted'],"tab.activeBorderTop":c['accent'],"tab.border":c['border'],"editorGroupHeader.tabsBackground":c['sidebar'],
 "textCodeBlock.background":c['codeBackground'],"progressBar.background":c['accent'],
 "editorError.foreground":c['error'],"editorWarning.foreground":c['warning'],
 "editor.findMatchBackground":c['searchMatchActiveBackground'],"editor.findMatchForeground":c['searchMatchActiveForeground'],"editor.findMatchHighlightBackground":c['searchMatchBackground'],"editor.findMatchHighlightForeground":c['searchMatchForeground'],
 "terminal.background":c['terminalBackground'],"terminal.foreground":c['terminalForeground'],"terminalCursor.foreground":c['terminalCursor'],"terminal.selectionBackground":c['terminalSelection'],
 "scrollbarSlider.background":c['terminalScrollbar'],"scrollbarSlider.hoverBackground":c['terminalScrollbarHover'],
    }
def tokens(c,light):
    pink,green,purple,blue=("#A3154A","#0B7A4B","#6B2FC7","#1D5FD1") if light else ("#FF8FB0","#08F868","#B48CFF","#7FB2FF")
    r=[("Comment",["comment","punctuation.definition.comment"],c['textMuted']+"B3","italic"),
       ("Keyword",["keyword","storage","storage.type"],c['accent'] if light else "#FF4D78",None),
       ("String",["string","markup.inline.raw"],green,None),("Number and constant",["constant","constant.numeric","constant.language"],purple,None),
       ("Function",["entity.name.function","support.function"],pink,None),("Type",["entity.name.type","entity.name.class","support.type","support.class"],blue,None),
       ("Variable",["variable","meta.definition.variable"],c['text'],None),("Tag",["entity.name.tag"],c['accent'] if light else "#FF4D78",None),("Attribute",["entity.other.attribute-name"],pink,None),
       ("Invalid",["invalid"],c['error'],None)]
    return [{"name":n,"scope":s,"settings":({"foreground":f}|({"fontStyle":st} if st else {}))} for n,s,f,st in r]
for name,c,ty in [("Dark",D,"dark"),("Light",L,"light")]:
    (out/f"cyberpunk-capri-{ty}-color-theme.json").write_text(json.dumps({"name":f"Cyberpunk Capri {name}","type":ty,"colors":wb(c,ty=="light"),"tokenColors":tokens(c,ty=="light")},indent=2)+"\n")
