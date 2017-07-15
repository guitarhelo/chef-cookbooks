if kernel['machine'] =~ /x86_64/
  default['mswdt']['url']          = "http://download.microsoft.com/download/1/B/3/1B3F8377-CFE1-4B40-8402-AE1FC6A0A8C3/WebDeploy_amd64_en-US.msi"
  default['mswdt']['checksum']     = "1E5E99A1DC8C197D299B37B9B4699AA36F41FC75"
  default['mswdt']['package_name'] = "MS Web Deployment Tool 1.1 (x64 edition)"
else
  default['mswdt']['url']          = "http://download.microsoft.com/download/7/B/D/7BD1DFE0-BE97-467A-B08E-72E97FC8C9F6/WebDeploy_x86_en-US.msi"
  default['mswdt']['checksum']     = "70A7374483F6938854B572654DA65F76D3AF5CF8"
  default['mswdt']['package_name'] = "MS Web Deployment Tool 1.1 (X86)"
end

default['mswdt']['home']    = "#{ENV['SYSTEMDRIVE']}\\wdt"


