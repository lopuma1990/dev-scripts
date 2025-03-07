haproxy
=======

The role installs and configures HAProxy on the targeted hosts.

Requirements
------------

None

Role Variables
--------------

The role accepts the following variables:

* `haproxy_log_level` is the HAProxy log level.
  By default, the log level is `info`.
* `haproxy_port` is the TCP port exposed to clients. `80` by default.
* `haproxy_backend_name` is the name of the back end. `app` by default.
* `haproxy_appservers` is a list of the back-end servers. Each item is a
  dictionary that provides the details of a back-end server. Those dictionaries
  must provide the following keys:
    * `name` is the name of the back-end server (do not need to be a valid DNS
      name)
    * `ip` is the IP address of the back-end server.
    * `port` is the TCP port number of the back-end server.

Dependencies
------------

None

Example Playbook
----------------

```yaml
---
- name: Installing and configuring HAProxy
  hosts: loadbalancers
  become: true
  gather_facts: false

  tasks:
    - name: Ensure HAProxy is installed and configured
      ansible.builtin.include_role:
        name: haproxy
      vars:
        haproxy_port: 8080
        haproxy_appservers:
          - name: www1.example.com
            ip: 1.2.3.4
            port: 5000
          - name: www2.example.com
            ip: 1.2.3.5
            port: 5000
...
```

The `tests/` directory provides an additional example.

License
-------

GPL 3.0 or later

Author Information
------------------

Red Hat Training <training@redhat.com>
