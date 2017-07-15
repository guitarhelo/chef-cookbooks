mswdt Cookbook
==============
this Chef cookbook installs  MS Web Deployment Tool 1.1

Requirements
------------
It was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:

Windows 7
Windows 2012 Server (R2)
Windows 8 (8.1)
Attributes
----------
mswdt::default:  the recipes for Microsoft Deployment Tool 1.0 installation
Usage
-----
#### mswdt::default
Add 'mswdt::default' to your runlist. By default this cookbook assumes you're installing Microsoft Deployment Tool 1.0
Set the node ['nunit']['url']  attribute to the download location of Microsoft Deployment Tool 1.0 msi file
default it download x86_64 from http://download.microsoft.com/download/1/B/3/1B3F8377-CFE1-4B40-8402-AE1FC6A0A8C3/WebDeploy_amd64_en-US.msi 
default it download x86_32 from http://download.microsoft.com/download/7/B/D/7BD1DFE0-BE97-467A-B08E-72E97FC8C9F6/WebDeploy_x86_en-US.msi


e.g.
Just include `mswdt` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mswdt]"
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
