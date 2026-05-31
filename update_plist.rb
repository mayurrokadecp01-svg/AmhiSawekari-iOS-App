require 'plist'
plist_path = 'AmhiSevikari/Info.plist'
plist = Plist.parse_xml(plist_path) || {}
fonts = Dir.glob('AmhiSevikari/Fonts/*.ttf').map { |f| File.basename(f) }
plist['UIAppFonts'] = fonts
File.write(plist_path, plist.to_plist)
