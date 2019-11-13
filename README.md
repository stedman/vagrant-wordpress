# Vagrant setup for WordPress

## Steps

1. Create new project with `Vagrantfile.sample` as a starting point.

    ```sh
    git clone https://github.com/stedman/vagrant-wordpress <project_name>
    cd <project_name>
    ```

2. Open `vagrant.config.yaml` and update options as needed.

    Note: if you want to target a specific WordPress release, make sure you prefix the `options.wordpress.release` value with `wordpress-`. For example: `wordpress-5.1.3`.

3. Start up Vagrant.

    ```sh
    vagrant up
    ```

4. Stop Vagrant

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

- [getting started with Vagrant](https://www.vagrantup.com/intro/getting-started/)
- [provisioning Vagrant](https://www.vagrantup.com/docs/provisioning/)
- [available Vagrant boxes](https://app.vagrantup.com/boxes/search)
- https://gist.githubusercontent.com/JonTheNiceGuy/73dea1fa23209b1b7d48f7ded2d34274/raw/d6f767618bd0b91a05b26d9fd8182c787e9f2714/Vagrantfile
- https://peteris.rocks/blog/unattended-installation-of-wordpress-on-ubuntu-server/
