default['Deploy-iBank']['7zip']['http_url'] = 'http://downloads.sourceforge.net/sevenzip/7z920-x64.msi'
default['Deploy-iBank']['ms_deploy']['http_url'] = 'http://download.microsoft.com/download/1/B/3/1B3F8377-CFE1-4B40-8402-AE1FC6A0A8C3/WebDeploy_amd64_en-US.msi'
default['Deploy-iBank']['ms_dotnet45']['reg64_cmd'] = '%WINDIR%/Microsoft.NET/Framework64/v4.0.30319/aspnet_regiis.exe -i'
default['Deploy-iBank']['ms_dotnet45']['reg_cmd'] = '%WINDIR%/Microsoft.NET/Framework/v4.0.30319/aspnet_regiis.exe -i'
default['Deploy-iBank']['ms_deploy']['home_path'] = 'C:/Program Files/IIS/Microsoft Web Deploy V3'
default['Deploy-iBank']['7zip']['home_path'] = 'c:/Program files/7-Zip/7z.exe'
default['Deploy-iBank']['artifact']['http_url'] = 'http://10.10.2.69:8080/nexus/service/local/repositories/DevOps-DEV/content/hp/ibank-tfs/RC-curl-47/RC-curl-47.zip'
default['Deploy-iBank']['iBank-java']['ws_conf_file'] = 'C:/inetpub/wwwroot/iBank_Investor_deploy/DatabaseXML/Webservice.xml'
default['Deploy-iBank']['iBank-dotnet']['iis_folder'] = 'C:/inetpub/wwwroot/iBank_Investor_deploy'
default['Deploy-iBank']['iBank-dotnet']['permissions'] = 'Users'
default['Deploy-iBank']['iBank-java']['host'] = 'localhost'
default['Deploy-iBank']['iBank-java']['port'] = '8080'
default['Deploy-iBank']['iBank-java']['app'] = 'iBank'
default['Deploy-iBank']['timeout'] = 600
default['Deploy-iBank']['ie_proxy_host'] = '10.10.2.245:6071'
default['Deploy-iBank']['ie_proxy_exceptions'] = 'localhost'