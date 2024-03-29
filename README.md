# Vagrant setup for WordPress

## Steps

1. Download and install:

    - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
    - [Vagrant](https://www.vagrantup.com/downloads.html)

2. Download `vagrant-wordpress`.

    ```sh
    git clone https://github.com/stedman/vagrant-wordpress <project_name>
    cd <project_name>
    ```

3. Open `vagrant.config.yaml` and update options as needed.

    **Note:** The box `ubuntu/trusty64` requires max WordPress version `wordpress-5.1.3`. If you update the box to a later version, you may be able to comment-out the wordpress release line (which will install the latest WP version).

4. [Initialize and] start up Vagrant.

    ```sh
    vagrant up
    ```

5. Stop Vagrant

    ```sh
    vagrant suspend  ## to quickly pause the VM
    vagrant halt     ## to power-down the VM
    vagrant destroy  ## to power-down and remove the VM
    ```

### More

If you modify the `Vagrantfile` later, you will need to reload the configuration.

```sh
vagrant reload
```

---

## Reference

- [Getting Started - Vagrant](https://www.vagrantup.com/intro/getting-started/)
- [Provisioning - Vagrant](https://www.vagrantup.com/docs/provisioning/)
- [Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search)
- [Unattended installation of WordPress on Ubuntu Server](https://peteris.rocks/blog/unattended-installation-of-wordpress-on-ubuntu-server/)
- https://gist.githubusercontent.com/JonTheNiceGuy/73dea1fa23209b1b7d48f7ded2d34274/raw/d6f767618bd0b91a05b26d9fd8182c787e9f2714/Vagrantfile
