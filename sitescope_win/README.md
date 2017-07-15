sitescope_win Cookbook
======================
This Chef cookbook installs HP Sitescpe 11.20 from an ISO

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
#### sitescope_win::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node['sitescope_win']['install']['home_dir']</tt></td>
    <td>String</td>
    <td>SiteScope install path</td>
    <td><tt>c:\\hp\\sitescope</tt></td>
  </tr>

 <tr>
    <td><tt>node['sitescope_win']['install']['type']</tt></td>
    <td>String</td>
    <td>SiteScope install group as Standalone or Failover,SystemHealth,LoadRunner</td>
    <td><tt>Standalone</tt></td>
  </tr>

  <tr>
    <td><tt>node['sitescope_win']['install']['customFeatureSelected']</tt></td>
    <td>String</td>
    <td>SiteScope install group feature StandaloneFeature or HAFeature,SystemHealthFeature,LoadRunnerFeature</td>
    <td><tt>StandaloneFeature</tt></td>
  </tr>
  <tr>
    <td><tt>node['sitescope_win']['install']['port']</tt></td>
    <td>String</td>
    <td>SiteScope install port</td>
    <td><tt>8080</tt></td>
  </tr>

</table>

Usage
-----
#### sitescope_win::default

Add 'sitescope_win::default' to your runlist. By default this cookbook assumes you're installing SiteScope 11.20.
Set the node ['sitescope']['install']['share_uri']  attribute to the download location of the SiteScope ISO
default it download iso image file from \\\\10.10.0.2\\software\\Hewlett-Packard\\SiS


e.g.
Just include `sitescope_win` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sitescope_win]"
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

