nunit Cookbook
==============

This Chef cookbook installs NUnit 2.6.3 from http://nunit.org/
Requirements
------------
this cookbook  successfully tested on:

Windows 2008 Server (R2)
Also it should work on:
Windows 2012 Server (R2)
Attributes
----------
#### nunit::default
nunit::default   install the NUnit on your node
Usage
-----
nunit::default  
Add 'nunit::default' to your runlist. By default this cookbook assumes you're installing NUnit 2.6.3.
Set the node ['nunit']['url']  attribute to the download location of NUnit 2.6.3 msi file
default it download from http://launchpad.net/nunitv2/trunk/2.6.3/+download/NUnit-2.6.3.msi

e.g.
Just include `nunit` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nunit]"
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
