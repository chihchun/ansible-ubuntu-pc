

# Introduction

This Anisble playbook is designed as a toolkit to help a Ubuntu Developer, quickly setup a machine as workstation, help to deploy the developement tools for hardware enablement work.

## Useful task/playbook for a Ubuntu developer

- Quickly setup a machine with utilus for Desktop (including Google Chrome, Dropbox)
    > ./deploy-playbook.sh xps-13-7390.local desktop.yml

- Setup checkbox for PC sanity tests, which is a test suite to verify if the system are well enabled.
    > ./deploy-playbook.sh xps-13-7390.local enablement.yml

- Enable Debug Symbol Packages on Ubutnu, for analyzing stack traces or debugging.
    > ./run-task.sh u-xps-13-7390.local enablement-focal/tasks/enable-ddebs.yaml

- Enable proposed pocket to test the latest availble software for Ubutnu.
    > ./run-task.sh u-xps-13-7390.local enablement-focal/tasks/enable-proposed.yaml

- Disable screen lock/dim.
    > ./run-task.sh u-xps-13-7390.local enablement-focal/tasks/disable-screenlock.yaml

 - Disable background apt update.
    > ./run-task.sh u-xps-13-7390.local enablement-focal/tasks/apt-periodic.yaml

 - Register HINFO/workstation on mDNS.
    > ./run-task.sh u-xps-13-7390.local enablement-focal/tasks/avahi.yaml

 - Instgall Google Chrome
    > ./run-task.sh u-xps-13-7390.local roles/desktop-focal/tasks/google-chrome.yaml 

 - Instgall Dropbox
    > ./run-task.sh u-xps-13-7390.local roles/desktop-focal/tasks/dropbox.yaml 

## How to play
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

- Deploy the playbook on the target machine
    > ansible-playbook -v --ask-become-pass --extra-vars=hosts=xps-13-7390.local desktop.yml

    or using a helper script.
    > ./deploy-playbook.sh xps-13-7390.local desktop.yml

- Run a task on the target machine
    This command will run the "hello" tasks on the machine.
    > ansible-playbook -vv --extra-vars=hosts=u-xps-13-7390.local -e task=enablement-focal/tasks/hello.yaml task-runner.yaml

    or using a helper script.
    > ./run-task.sh xps-13-7390.local enablement-focal/tasks/hello.yaml

## Known issue when playing with focal (Ubuntu 20.04)
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