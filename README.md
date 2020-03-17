
# How to play

- Deploy Ubuntu on a fresh-installed machine.
- Ensure if the machine is avaialbile on the zeroconf.
    > avahi-resolve -n -4 -v xps-13-7390.local
- Copy the ssh key to the target machine with ssh-copy-id
    > ssh-copy-id u@xps-13-7390.local:
- Add the hostnaem in the "hosts" file, Eg.

        [desktop]
        g7-7790.local ansible_ssh_user=chihchun
        xps-13-7390.local ansible_ssh_user=u

- Deploy the playbook to the machine
    > ansible-playbook -v --ask-become-pass --extra-vars=hosts=xps-13-7390.local desktop.yml