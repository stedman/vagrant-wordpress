# Vagrant setup for WordPress

## Steps

1. Create new project with `Vagrantfile.sample` as a starting point.

    ```sh
    git clone https://github.com/stedman/vagrant-wordpress <project_name>
    cd <project_name>
    ```

2. Copy `Vagrantfile.sample` to a `Vagrantfile` and then edit the new file in the editor of your choice.

    ```sh
    cp Vagrantfile.sample Vagrantfile
    code ./Vagrantfile  ## <-- assumes you're using VSCode to edit file
    ```

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
- [available Vagrant boxes](https://app.vagrantup.com/boxes/search)
