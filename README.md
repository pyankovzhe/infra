# Infrastructure Repository

## Ansible

**Roles**

Use roles to organize related configurations.

Ansible galaxy init command initializes the base structure of a new role:
```
ansible-galaxy init role_name
```

**Playbooks**

Include new playbooks in syte.yml.

Default inventory file is environments/stage/hosts.

Configure stage environment:
```
ansible-playbook site.yml
```
Skip tags 'install' and 'ruby', when using pre-baked packer images:
```
ansible-playbook site.yml --skip-tags "install,ruby"
```
If you want configure prod environmet, you must specify inventory file:
```
ansible-playbook site.yml -i environments/prod/hosts --skip-tags "install,ruby"
```

Check playbooks(dry run):
```
ansible-playbook site.yml --check
```
**group_vars  & host_vars**

Place files with variables inside these directories named after the group name or
hostname defined in your inventory file.

**provisioners**

packer_app and packer_db playbooks are used to create pre-baked images with Packer.

**Testing**
Using virtualenv with virtualenvwrapper
http://docs.python-guide.org/en/latest/dev/virtualenvs/

Create test environment with vagrant
```
vagrant up
```
In directory with roles.
Example of initializing new scenatio for role:
```
molecule init scenario --scenario-name default -r db -d vagrant
```
Create test vm:
```
molecule create
```
List testing vms:
```
molecule list
```
Apply playbooks for test vms:
```
molecule converge
```
Run tests:
```
molecule verify
```
## Terraform

### Use Terraform for building, changing and versioning infrastructure

Configure different environments(stage or production) using reusable modules.

Define user variables in terraform.tfvars file based on sample terraform.tfvars.example in environments folders.

Use commands below to build and change your infrastructure:

```
terraform plan
terraforn apply
terraform destroy
terraform fmt
terraform show
```

## Packer

### Use Packer to create pre-baked images.

Validate packer template ubuntu16.json

```sh
packer validate -var 'project_id=example-project' -var 'source_image=ubuntu-1604-xenial-v20170815a' ubuntu16.json
```

Discover what variables the template accepts.
```sh
packer inspect ubuntu16.json
```

Build image

```sh
packer build -var 'project_id=example-project' -var 'source_image=ubuntu-1604-xenial-v20170815a' -var 'tags=webserver, puma' ubuntu16.json
```

## Scripts

Run deploy.sh script to deploy application.

Run startup_script.sh to make provisioning server and deploy application.

Create VM instance with startup script:

```sh
gcloud compute instances create --boot-disk-size=10GB --image=ubuntu-1604-xenial-v20170815a --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --zone=europe-west1-b --metadata-from-file startup-script=startup_script.sh reddit-app
```
