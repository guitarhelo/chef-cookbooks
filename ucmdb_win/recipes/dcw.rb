home_dir   = node['ucmdb']['install']['home_dir']
slick_path = node['ucmdb']['install']['ucmdb_slick_path']
db_host    = node['ucmdb']['db']['host']
db_type    = node['ucmdb']['db']['type']
db_port    = node['ucmdb']['db']['port']
db_name    = node['ucmdb']['db']['name']
dba_user   = node['ucmdb']['install']['dba_user']
dba_pass   = node['ucmdb']['install']['dba_pass']

db_scripts_path =home_dir +"\\db"
ucmdb_db_user  = node['ucmdb']['db']['user']
ucmdb_db_pass  = node['ucmdb']['db']['pass']
dbuser_create_script_template = "createdbusr.sql.erb"
dbuser_create_script = db_scripts_path  + "\\createdbuser.sql"
dbuser_create_output = home_dir  + "\\dbuser_create_output.txt"
db_create_output= home_dir  + "\\db_create_output.txt"
db_init_output= home_dir  + "\\db_init_output.txt"
db_init_script=slick_path+"\\dbconfig.bat"

directory db_scripts_path do
  action :create
  recursive true
end

template dbuser_create_script do
  source dbuser_create_script_template
end


db_create_cmd="#{db_init_script} create -d #{db_type} -o #{db_host} -p #{db_port} -u #{dba_user} -a #{dba_pass} -s #{db_name} >#{db_create_output}"

execute "create db" do 
	command db_create_cmd
end
execute "create db user" do
  command "sqlcmd -H #{db_host} -U #{dba_user} -P #{dba_pass} -i #{dbuser_create_script} -o #{dbuser_create_output}"
end

db_conf_create_cmd = "#{db_init_script} connect -d #{db_type} -o #{db_host} -p #{db_port} -u #{ucmdb_db_user} -a #{ucmdb_db_pass} -s #{db_name} >#{db_init_output}"
execute "db conf generate" do
 command db_conf_create_cmd
end

directory db_scripts_path do
  action :delete
  recursive true
end

