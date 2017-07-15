ucmdb_win Cookbook
==================
This Chef cookbook installs HP UCMDB 10.10 from an ISO.it includes UCMDB Server , DataFlowProbe and HP Configuation Management


Requirements
------------
This cookbook requires winsoft::7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the winsoft::7-zip default recipe.

It was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:
Windows 2012 Server (R2)

Attributes
----------
ucmdb_win::default:  the recipes for ucmdb server and dataflowprobe installation 
ucmdb_win::dcw:  the recipes for ucmdb database configuation wizard 
ucmdb_win::startservice: the recipes for starting ucmdb service and intergraton service 
ucmdb_win::hpcm : the recipes for hp cm installation .it depend on the ucmdb installation success and service start
ucmdb_win::install : the recipes for ucmdb and dataflowprobe installation and database configuation 

* `node['ucmdb']['install']['home_dir']` -  install path for ucmdb ,default c:\\hp\\UCMDB
* `node['ucmdb']['install']['port']` -   the port for ucmdb ,default 8080

Usage
-----
#### ucmdb_win::default

Add 'ucmdb::install' to your runlist. By default this cookbook assumes you're installing ucmdb server and dataflowprobe.
Add 'ucmdb::hpcm'   to your runlist. By default this cookbook assumes you're installing hp CM.
Set the node ['ucmdb']['install']['share_uri']  attribute to the download location of the ucmdb ISO
default it download iso image file from \\\\10.10.0.2\\software\\Hewlett-Packard\\SiS
e.g.
Just include `ucmdb_win::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ucmdb_win::install]"
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
