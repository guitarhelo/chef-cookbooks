home_dir   = node['ucmdb']['install']['home_dir']
configurelwsso_path = node['ucmdb']['install']['ucmdb_slick_path']
configurelwsso_script=configurelwsso_path+"\\configurelwsso.bat" 

configurelwsso_cmd = "#{configurelwsso_script}"
execute "configure lwsso" do 
 command configurelwsso_cmd
end
