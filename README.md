
# How to play
- Install ansiable
    > apt install ansible
- Deploy Ubuntu on a fresh-installed machine.
- Ensure if the machine is avaialbile on the zeroconf.
    > avahi-resolve -n -4 -v xps-13-7390.local
- Copy the ssh key to the target machine with ssh-copy-id
    > ssh-copy-id u@xps-13-7390.local:
- Add the hostnaem in the "hosts" file, Eg.

        [desktop]
        g7-7790.local ansible_ssh_user=chihchun
        xps-13-7390.local ansible_ssh_user=u ansible_sudo_pass=u

- Deploy the playbook to the machine
    > ansible-playbook -v --ask-become-pass --extra-vars=hosts=xps-13-7390.local desktop.yml


# Known issue on focal (Ubuntu 20.04)
- ansible 2.5.1+dfsg-1ubuntu0.1 in bionic does not work well with python3, it requires a patch.

        --- /usr/lib/python2.7/dist-packages/ansible/modules/packaging/os/apt_repository.py	2018-04-19 08:01:49.000000000 +0800
        +++ /tmp/apt_repository.py	2020-03-18 00:05:12.980457762 +0800
        @@ -188,7 +188,7 @@
                    for n, valid, enabled, source, comment in sources:
                        if valid:
                            yield file, n, enabled, source, comment
        -        raise StopIteration
        +        # raise StopIteration
        
            def _expand_path(self, filename):
                if '/' in filename: