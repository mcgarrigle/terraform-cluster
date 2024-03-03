
Instructions:
```
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
rm terraform_1.6.6_linux_amd64.zip

cd modules
git clone https://github.com/mcgarrigle/terraform-module-libvirt-domain.git
cd -

# create base image volume

wget http://node1.mac.wales:8081/repository/cloud-images/rocky/Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2
virsh vol-create-as --pool filesystems --name rocky-base --capacity 1g
virsh vol-upload --vol rocky-base --pool filesystems --file Rocky-9-GenericCloud-Base-9.2-20230513.0.x86_64.qcow2

export TF_VAR_libvirt_uri="qemu+ssh://pete@swole.mac.wales/system"

terraform init
terraform apply -auto-approve

virsh console foo
virsh net-dhcp-leases --network default

terraform destroy -auto-approve
```
