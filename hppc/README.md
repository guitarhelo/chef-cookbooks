hppc Cookbook
=============
This Chef cookbook installs HP Performance Center 12.00 from an ISO
Requirements
------------
This cookbook requires winsoft::7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the winsoft::7-zip default recipe.

It was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:

Windows 7
Windows 2012 Server (R2)
Windows 8 (8.1)
Attributes
----------

hppc::default    :   install the Performance Center server 
hppc::host       :   install the Performance Center host

Usage
-----
#### hppc::default

Add 'hppc::default' to your runlist. By default this cookbook assumes you're installing HP Performance Center Server 12.00.
Set the node ['hppc']['install']['share_uri']  attribute to the download location of the Performance Center ISO
default it download iso image file from \\\\10.10.0.2\\software\\Hewlett-Packard\\PCTODO: Write usage instructions for each cookbook.
e.g.
Just include `hppc` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hppc]"
  ]
```
### hppc::host
Add 'hppc::host' to your runlist. you're installing HP Performance Center Host 12.00. 
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hppc::host]"
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
