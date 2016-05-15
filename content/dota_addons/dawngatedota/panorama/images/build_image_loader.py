import glob
import os

start = "<root>\n\t<scripts>\n\t\t<include src=\"file://{resources}/scripts/custom_game/spell_icon_loader.js\" />\n\t</scripts>\n\t<Panel>\n\t\t<Panel id=\"spell_icon_loader\">"
content = ""
end = "\n\t\t</Panel>\n\t</Panel>\n</root>"

for root, dirs, files in os.walk('.'):
  for file in files:
    if file.endswith('.png'):
    	content += "\n\t\t\t<Image src=\"file://{images}/" + os.path.join(root, file).replace("\\", "/").replace("./", "") + "\"/>"

print(start + content + end)

f = open('../layout/custom_game/spell_icon_loader.xml', 'w')
f.write(start + content + end)
f.close()
