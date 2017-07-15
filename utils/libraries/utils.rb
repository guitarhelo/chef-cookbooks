require 'win32ole'
include Chef::Mixin::ShellOut

module Utils
def get_drive_letter
  drives = []
  file_system = WIN32OLE.new( 'Scripting.FileSystemObject' )
  file_system.Drives.each { |drive| drives << drive.DriveLetter }
  return ([*("A".."Z")]-drives).last
end

end
