ucmdb_win Cookbook
==================
This Chef cookbook installs HP Agile Manager 2.20 from an ISO.it 

Requirements
------------

It was successfully tested on:

Redhat ES 6.5
Also it should work on:
Redhat ES 6.4
CentOS-6.5
CentOS-6.4

Attributes
----------
hpagm::default:  the recipes for hp agile manager installation 


node[:agm][:install][:home_dir]   = "/opt/hp/agm"
node[:agm][:install][:type]       = "default"

node[:agm][:install][:dba_user] ="system"
node[:agm][:install][:dba_pass] = "1Q2w3e4r5t"

node[:agm][:db][:type]            = "oracle"
node[:agm][:db][:host]            = "localhost"
node[:agm][:db][:port]            = "1521"
node[:agm][:db][:pass]            = "1Q2w3e4r5t"

node[:agm][:server][:host]            = "localhost"
node[:agm][:server][:port]            = "8080"

node[:agm][:admin][:user]            = "sa"
node[:agm][:admin][:pass]            = "sa"




Usage
-----
#### ucmdb_win::default

Add 'hpagm::install' to your runlist. By default this cookbook assumes you're installing HP Agile Manager.

Set the node[:agm][:install][:share_uri]  attribute to the download location of the HP Agile Manager ISO
default it download iso image file from 10.10.0.2:/srv/software/Hewlett-Packard/AGM
e.g.
Just include `hpagm::default in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hpagm::default]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
