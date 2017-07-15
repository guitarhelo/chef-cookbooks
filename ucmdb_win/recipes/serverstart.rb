home_dir   = node['ucmdb']['install']['home_dir']
start_server_script  = home_dir + "\\UCMDBServer\\bini\\server.bat"

windows_batch 'Start Ucmdb Server' do
  code <<-EOH
  #{start_server_script} start

end 
