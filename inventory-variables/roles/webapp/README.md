webapp
======

The role deploys a sample initial content to the targeted web servers.

Requirements
------------

None

Role Variables
--------------

The role accepts the following variables:

* `webapp_message_prefix` provides an initial text as content. After that text,
  the role adds the targeted host name and the application version (from the
  `webapp_version` variable)
* `webapp_version` is the version of the content. That value is added at the
  end of the content.


Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- name: Deploying initial web content
  hosts: webservers
  become: true
  gather_facts: false

  tasks:
    - name: Ensure the web content is deployed
      ansible.builtin.include_role:
        name: webapp
      vars:
        webapp_message_prefix: Welcome to
        webapp_version: "1.1.2"
...
```

The `tests/` directory provides an additional example.

License
-------

GPL 3.0 or later

Author Information
------------------

Red Hat Training <training@redhat.com>
