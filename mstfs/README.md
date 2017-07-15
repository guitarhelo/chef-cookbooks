mstfs Cookbook
==============
This Chef cookbook installs Microsoft Team Foundation Serve 2012 update 4 from an ISO.
Requirements
------------
it was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:
Windows 2012 Server (R2)

Attributes
----------
mstfs::default:  the recipes for Microsoft Team Foundation Serve 2012 server installation
Usage
-----
#### mstfs::default
Add 'mstfs::default' to your runlist. By default this cookbook assumes you're installing Microsoft Team Foundation Serve 2012 server.
Set the node ['mstfs']['install']['iso_file']  attribute to the download location of the Microsoft TFS ISO
default it download iso image file from \\\\10.10.0.2\software\Microsoft\TFS\VS2012.4TFS-Server-ENU.iso
e.g.
Just include `mstfs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mstfs]"
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
