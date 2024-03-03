# Instructions:

## install terraform
```
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
rm terraform_1.6.6_linux_amd64.zip
```
## install module dependency
```
cd modules
git clone https://github.com/mcgarrigle/terraform-module-libvirt-domain.git
cd -
```
## download and verify base image
```
$ curl -O https://dl.rockylinux.org/pub/rocky/9.3/images/x86_64/Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2
$ curl -O https://dl.rockylinux.org/pub/rocky/9.3/images/x86_64/Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2.CHECKSUM
$ sha256sum --check Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2.CHECKSUM
Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2: OK
```
## create base image volume
```
export LIBVIRT_DEFAULT_URI="qemu+ssh://pete@smol.mac.wales/system"
virsh vol-create-as --pool filesystems --name rocky-base-9.3 --capacity 1g
virsh vol-upload --vol rocky-base-9.3 --pool filesystems --file Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2

export LIBVIRT_DEFAULT_URI="qemu+ssh://pete@swole.mac.wales/system"
virsh vol-create-as --pool filesystems --name rocky-base-9.3 --capacity 1g
virsh vol-upload --vol rocky-base-9.3 --pool filesystems --file Rocky-9-GenericCloud-Base-9.3-20231113.0.x86_64.qcow2
```
## deploy virtual machines
```
terraform init
terraform plan
terraform apply -auto-approve

... later

terraform destroy -auto-approve
```
