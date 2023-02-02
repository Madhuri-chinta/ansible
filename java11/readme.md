### HOW TO INSTALL JAVA11 :

* Manual steps for Java11 installation:
  ------------------------------------------- 
   * UBUNTU:
     ------- 
```     
sudo apt update
sudo apt install openjdk-11-jdk 
java --version 

```
   * CENTOS:
     -------
```
sudo yum update
sudo yum install java-11-openjdk-devel
java --version

```
* Write single playbook for the this application both ubuntu and centos :
  ---------------------------------------------------------------------

```yaml
---
- name: install java11
  hosts: all
  become: yes
  tasks:
    - name: install java11
      ansible.builtin.package:
        name: "{{ java_package_name }}"
        update_cache: yes
        state: present
```


 

