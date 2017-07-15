default['sql_server']['accept_eula'] = true
default['sql_server']['product_key'] = nil
default['sql_server']['version'] = '2008R2'

case node['sql_server']['version']
when '2008R2'
  default['sql_server']['reg_version'] = 'MSSQL10_50.'
when '2012'
  default['sql_server']['reg_version'] = 'MSSQL11.'
end
