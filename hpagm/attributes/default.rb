#
# Cookbook Name:: hpagm
# Attributes::default
default[:agm][:install][:share_uri]  = "10.10.0.2:/srv/software/Hewlett-Packard/AGM"
default[:agm][:install][:install_file]   = "Software_HP_Agile_Manager_2.20_MLU_H7P70-15002.tar.gz"
default[:agm][:install][:setup_exe]  = "Agile-Manager-2.20-177-OP.rpm"
default[:agm][:install][:setup_keyfile]  = "hpPublicKey2048.pub"


default[:agm][:install][:home_dir]   = "/opt/hp/agm"
default[:agm][:install][:type]       = "default"

default[:agm][:install][:dba_user] ="system"
default[:agm][:install][:dba_pass] = "1Q2w3e4r5t"

default[:agm][:db][:type]            = "oracle"
default[:agm][:db][:host]            = "localhost"
default[:agm][:db][:port]            = "1521"
default[:agm][:db][:pass]            = "1Q2w3e4r5t"

default[:agm][:server][:host]            = "localhost"
default[:agm][:server][:port]            = "8080"
