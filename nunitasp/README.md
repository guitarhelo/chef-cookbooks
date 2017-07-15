nunitasp Cookbook
=================
this Chef cookbook installs NUnitAsp from http://nunitasp.sourceforge.net/

Requirements
------------
this cookbook requires winsoft::7-zip to be installed so it can extract the zip. To ensure this happens this cookbook includes the winsoft::7-zip default recipe.

It was successfully tested on:

Windows 2008 Server (R2)
Also it should work on:
Windows 2012 Server (R2)
Attributes
----------
nunitasp::default:  the recipes for NUnitAsp 2.0 installation 
Usage
-----
#### nunitasp::default
Add 'nunitasp::default' to your runlist. By default this cookbook assumes you're installing NUnitAsp 2.0.
Set the node ['nunitasp']['url']  attribute to the download location of NUnitAsp 2.0 zip file
default it download from http://prdownloads.sourceforge.net/nunitasp/NUnitAsp-2.0.zip?download.

e.g.
Just include `nunitasp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nunitasp]"
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
