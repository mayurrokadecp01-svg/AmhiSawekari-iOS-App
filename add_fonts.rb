require 'xcodeproj'
project_path = 'AmhiSevikari.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

group = project.main_group.find_subpath('AmhiSevikari/Fonts', true)
group.set_source_tree('<group>')
group.set_path('Fonts')

Dir.glob('AmhiSevikari/Fonts/*.ttf').each do |font_path|
  file_name = File.basename(font_path)
  # Check if file already exists in group
  file_ref = group.files.find { |f| f.path == file_name }
  unless file_ref
    file_ref = group.new_file(file_name)
  end
  # Add to copy bundle resources if not already there
  unless target.resources_build_phase.files_references.include?(file_ref)
    target.add_resources([file_ref])
  end
end

project.save
