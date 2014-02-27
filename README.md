tamu-shibboleth Cookbook
=======================
Setup a shibboleth service provide in TAMU federation.

Requirements
------------

Attributes
----------

e.g.
#### tamu-shibboleth::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['shibboleth']['conf']</tt></td>
    <td>String</td>
    <td>Shibboleth configuration file</td>
    <td><tt>'/etc/shibboleth/shibboleth2.xml'</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['admin']</tt></td>
    <td>String</td>
    <td>admin email</td>
    <td><tt>'no-reply@tamu.edu'</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['servername']</tt></td>
    <td>String</td>
    <td>Shibboleth server name</td>
    <td><tt>'server.tamu.edu'</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['proxy']['preserve']</tt></td>
    <td>Boolean</td>
    <td>ProxyPreserveHost proper in httpd.conf</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['proxy']['hosts']</tt></td>
    <td>Hash</td>
    <td>pair values to be fed to ProxyPass directive in httpd.conf</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['auth']</tt></td>
    <td>Array</td>
    <td>List of url paths need to be protected</td>
    <td><tt>Empty</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['wayf']['enabled']</tt></td>
    <td>Boolean</td>
    <td>Whether to use wayf</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['wayf']['address']</tt></td>
    <td>String</td>
    <td>Wayf address</td>
    <td><tt>'wayf.tamu.edu'</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['fedcert']</tt></td>
    <td>String</td>
    <td>URL to Shibboleth federation certification</td>
    <td><tt>'https://idp.tamu.edu/federation.tamu.edu.crt'</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['attributes']</tt></td>
    <td>Hash</td>
    <td>Attributes to be fed to attribute-map.xml</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['attributes'][#oid]['id']</tt></td>
    <td>String</td>
    <td>Shibboleth attribute to be mapped to</td>
    <td><tt>None</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['attributes'][#oid]['decoder']</tt></td>
    <td>String</td>
    <td>Optional decoder to be used</td>
    <td><tt>Optional</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['attributes'][#oid]['formater']</tt></td>
    <td>String</td>
    <td>Optional formater to be used</td>
    <td><tt>Optional</tt></td>
  </tr>
  <tr>
    <td><tt>['shibboleth']['attributes'][#oid]['case']</tt></td>
    <td>String</td>
    <td>Optional case modifier 'true' or 'false'</td>
    <td><tt>Optional</tt></td>
  </tr>
</table>

Usage
-----
#### tamu-shibboleth::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `tamu-shibboleth` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tamu-shibboleth]"
  ]
}
```

An example of attributes:
```ruby
default_attributes(
  'shibboleth' => {
    'servername' => 'testsp.tamu.edu',
    'proxy' => {
      'hosts' => {
        '/' => 'http://another.server/',
      },
    },
    'certrepo' => 'http://private.server/shibcerts/',
    'auths' => [
      '/shibboleth-login',
      '/secure',
    ],
    'attributes' => {
      'urn:oid:1.3.6.1.4.1.4391.0.12' => {
        'id' => 'tamuUIN',
      },
      'urn:oid:1.3.6.1.4.1.5923.1.1.1.6' => {
        'id' => 'eduPersonPrincipalNameUnscoped',
        'decoder' => 'NameIDFromScopedAttributeDecoder',
        'formater' => '$Name',
      },
      'urn:oid:1.3.6.1.4.1.5923.1.1.1.9' => {
        'id' => 'scoped-affiliation',
        'decoder' => 'ScopedAttributeDecoder',
        'case' => 'false',
      },
      'urn:oid:1.3.6.1.4.1.5923.1.1.1.1' => {
        'id' => 'eduPersonAffiliation',
        'decoder' => 'StringAttributeDecoder',
        'case' => 'false',
      },
      'urn:oid:1.3.6.1.4.1.5923.1.1.1.7' => {
        'id' => 'entitlement',
      },
    },
  },
)
```

For list of Mappable Shibboleth Attributes, see http://infrastructure.tamu.edu/auth/TAMUFederation/attributes.html

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
