# Terraform Cluster

Target deployment:

From the VM ``dev`` use terrfrom to deploy 4 ``server`` VMs over 2 servers,
``smol`` and ``swole``.

```
 ┌─────────────────────────────────┐     ┌─────────────────────────────────┐
 │              smol               │     │              swole              │
 │                                 │     │                                 │
 │  ┌─────────┐     ┌─────────┐    │     │  ┌─────────┐     ┌─────────┐    │
 │  │ server1 │     │ server2 │    │     │  │ server3 │     │ server4 │    │
 │  └─────────┘     └─────────┘    │     │  └─────────┘     └─────────┘    │
 └────────────────┬────────────────┘     └────────────────┬────────────────┘
                  │                                       │                 
                  │                                       │                 
──────────────────┴─────────────────┬─────────────────────┴─────────────────
                                    │                                       
                                    │                                       
                   ┌────────────────┴────────────────┐                      
                   │               dev               │                      
                   │                                 │                      
                   │                                 │                      
                   │                                 │                      
                   │                                 │                      
                   └─────────────────────────────────┘
```
## Install terraform
```
$ wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
$ unzip terraform_1.6.6_linux_amd64.zip
$ rm terraform_1.6.6_linux_amd64.zip
```
## Install module dependency
```
$ cd modules
$ git clone https://github.com/mcgarrigle/terraform-module-libvirt-domain.git
```
## Download and verify base image
```
$ curl -O https://dl.rockylinux.org/pub/rocky/9.3/images/x86_64/Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2
$ curl -O https://dl.rockylinux.org/pub/rocky/9.3/images/x86_64/Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2.CHECKSUM
$ sha256sum --check Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2.CHECKSUM
Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2: OK
```
## Create base image volume
```
$ export LIBVIRT_DEFAULT_URI="qemu+ssh://pete@smol.mac.wales/system"
$ virsh vol-create-as --pool filesystems --name rocky-base-9.3 --capacity 1g
$ virsh vol-upload --vol rocky-base-9.3 --pool filesystems --file Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2

$ export LIBVIRT_DEFAULT_URI="qemu+ssh://pete@swole.mac.wales/system"
$ virsh vol-create-as --pool filesystems --name rocky-base-9.3 --capacity 1g
$ virsh vol-upload --vol rocky-base-9.3 --pool filesystems --file Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2
```
## Deploy virtual machines
```
$ terraform init
$ terraform plan
$ terraform apply -auto-approve

... later

$ terraform destroy -auto-approve
```
