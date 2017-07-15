sitescope_win Cookbook
======================
This Chef cookbook installs ISELL  from an zip format file

Requirements
------------

This cookbook requires winsoft::7-zip to be installed so it can extract the ZIP. To ensure this happens this cookbook includes the winsoft::7-zip default recipe.

It was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:

Windows 7
Windows 2012 Server (R2)
Windows 8 (8.1)

Attributes
----------
#### sitescope_win::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node['isell_file_server']['install']['home_dir']</tt></td>
    <td>String</td>
    <td>SiteScope install path</td>
    <td><tt>c:\\IKEA\\file_server</tt></td>
  </tr>

 

  <tr>
    <td><tt>node['isell_file_server']['install']['version']</tt></td>
    <td>String</td>
    <td>isell_file_server install corresponding version</td>
    <td><tt>7.0.15</tt></td>
  </tr>
  

</table>

Usage
-----
#### sitescope_win::default

Add 'isell_file_server::default' to your runlist. By default this cookbook assumes you're installing isell_file_server 7.0.15.
Set the node ['isell_file_server']['install']['share_uri']  attribute to the download location of the ISELL file server ZIP
default it download iso image file from \\\\itsehbg-nt0001\exchange\ARDA\iSELL\7.0.0_INC\Client Deployment\\Release\\FileServer



e.g.
Just include `isell_file_server` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[isell_file_server]"
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

