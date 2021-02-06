# Static Analysis Info

- [Static Analysis Info](#static-analysis-info)
  - [How to use](#how-to-use)
  - [Tools](#tools)
    - [SonarQube](#sonarqube)
      - [SonarQube meta](#sonarqube-meta)
      - [SonarQube Provision](#sonarqube-provision)
      - [SonarQube Usage/Aliases](#sonarqube-usagealiases)
    - [Bandit](#bandit)
      - [Bandit meta](#bandit-meta)
      - [Bandit Provision](#bandit-provision)
      - [Bandit Usage/Aliases](#bandit-usagealiases)
    - [MobSF](#mobsf)
      - [MobSF meta](#mobsf-meta)
      - [MobSF Provision](#mobsf-provision)
      - [MobSF Usage/Aliases](#mobsf-usagealiases)
    - [shellcheck](#shellcheck)
      - [shellcheck meta](#shellcheck-meta)
      - [shellcheck Provision](#shellcheck-provision)
      - [shellcheck Usage/Aliases](#shellcheck-usagealiases)

## How to use

1) make sure you have vagrant and virtualbox installed: [https://github.com/SamuraiWTF/samuraiwtf#initial-install](https://github.com/SamuraiWTF/samuraiwtf#initial-install)
2) make sure you have this repo cloned
3) If you have a specific folder that you have client data in, then change the line that says: `config.vm.synced_folder` to specify the full path to that folder in the first set of quotes. For Windows hosts, remember to double escape the `\`in your paths
   ```
   config.vm.synced_folder "E:\\client_name\\someDir", "/client_code"
   ```
   - (use this for more info: [https://www.vagrantup.com/docs/synced-folders/basic_usage.html](https://www.vagrantup.com/docs/synced-folders/basic_usage.html))

4) Inside this directory type the command `vagrant up`
5) you will (most likely) get a pop up that asks for virtualbox to create an adapter, you have to select yes for this to work. (It is creating a host only adapter so you can access applications directly on the vm instead of port forwarding all the necssary ports.)
6) specify which tool(s)/client(s) you want to use with `vagrant provision --provision-with <tool_name|client_name>`, and you can specify multiple provisioniners (i.e. `vagrant provision --provision-with <client_name>,<tool_name>,<other_tool_name>`). (More info here: [https://www.vagrantup.com/docs/cli/provision.html#provision-with-x-y-z](https://www.vagrantup.com/docs/cli/provision.html#provision-with-x-y-z))
7) After you run the provisions you want, then you can do `vagrant ssh` to access everything. All the ip addresses you will probably access are 192.168.33.xx (probably .10). Then the port number for the service

**NOTE:** If you want to run multiple commands for multiple tools that grab your console (i.e. multiple web servers that tail logs), you should consider a terminal multiplexing client. Examples are tmux or screen.

## Tools

### SonarQube

#### SonarQube meta

[Documentation](https://docs.sonarqube.org/latest/)

#### SonarQube Provision

```shell
vagrant provision --provision-with sonarqube
```

#### SonarQube Usage/Aliases

```shell
# all these are wrappers for docker commands
si-sonarqube_create # this creates and starts the container
si-sonarqube_mon # this monitors the container's logs
si-sonarqube_start # this starts a previously stopped container
si-sonarqube_stop # this stops the container
si-sonarqube_rm # this removes the container
```

- You can access this tool on port 9000.

### Bandit

#### Bandit meta

[Documentation](https://github.com/PyCQA/bandit)

#### Bandit Provision

```shell
vagrant provision --provision-with bandit
```

#### Bandit Usage/Aliases

```shell
si-bandit_stop # this deactivates the vitualenv
si-bandit2_start # this activates the python2 version of bandit
si-bandit3_start # this activates the python3 version of bandit
```

- this is a cli tool

### MobSF

#### MobSF meta

[Documentation](https://mobsf.github.io/docs/#/)

#### MobSF Provision

```shell
vagrant provision --provision-with mobsf
```

#### MobSF Usage/Aliases

```shell
si-mobsf_start # this starts mobsf
Ctrl+c # this stops mobsf (i.e. kill process)
```

- You can access this tool on port 8000.

### shellcheck

#### shellcheck meta

[Documentation](https://www.shellcheck.net/)

#### shellcheck Provision

```shell
vagrant provision --provision-with shellcheck
```

#### shellcheck Usage/Aliases

```shell
si-shellcheck # this uses shellcheck
shellcheck # this is the real command and can also be used
```

- This is a cli tool.

<!--
### <Tool_name>

#### <Tool_name> meta

[Documentation](https://<tool_docs_url>)

#### <Tool_name> Provision

```shell
vagrant provision --provision-with <tool_name>
```

#### <Tool_name> Usage/Aliases

```shell
<tool_name>_stop # this stops <tool_name>
<tool_name>_start # this starts <tool_name>
```

- You can access this tool on port XXXX|this is a cli tool.
-->
