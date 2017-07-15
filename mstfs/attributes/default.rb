#for web install
default['mstfs']['url']          = "http://www.microsoft.com/en-us/download/confirmation.aspx?id=38185&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1"
default['mstfs']['checksum']     = "F8BE0471FA306E5A9E5C117F63B5D3A621FB571D"
default['mstfs']['package_name'] = "Microsoft Team Foundation Server 11.0"
default['mstfs']['home']         = "C:\\Program Files\\Microsoft Team Foundation Server 11.0"
#for install from iso
default['mstfs']['install']['iso']  = "\\\\10.10.0.2\\software\\Microsoft\\TFS\\VS2012.4TFS-Server-ENU.iso"
default['mstfs']['install']['setup_exe']  = "tfs_server.exe"

default['mstfs']['install']['home_dir']   = "C:\\Program Files\\Microsoft Team Foundation Server 11.0"
default['mstfs']['install']['type']       = "default"

default['mstfs']['install']['dba_user'] ="sa" 
default['mstfs']['install']['dba_pass'] = "1Q2w3e4r5t"

default['mstfs']['db']['type']            = "sqlserver"
default['mstfs']['db']['host']            = "localhost"
default['mstfs']['db']['port']            = "1433"
default['mstfs']['db']['pass']            = "1Q2w3e4r5t"
default['mstfs']['db']['name']            = "Tfs_Configuration"
default['mstfs']['db']['user']            = "sa"

default['mstfs']['server']['host']            = "localhost"

