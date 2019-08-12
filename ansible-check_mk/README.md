# INTRO
These are ansible playbooks used for deploying an OMD instance as well as a simple haproxy and two web servers. These are the playbooks that were used by Marius Pana at the 2nd Check_MK conference in Munich, Germany. The presentation will be made available online shortly for those that are interested.

Alert handlers (as defined by Check_MK) can be used from within Check_MK to signal the execution of specific handlers (as defined by Ansible) from the ansible playbooks so as to provide a simple feedback loop which provides self healing.

*We are still looking for a good mapping of services between check_mk and ansible. One solution that was recommended was the use of service attributes(nagios macros) which could then be mapped one-to-one with ansible tags. As soon as we have something functional we will update this. If anyone else has ideas we are interested in hearing them.*

These examples are fairly simple but can and should be expanded to include more logic for repairing your specific systems/services. We intended these as a starting point.

## About these playbooks
We are assuming you are using a RedHat based distro. These playbooks will deploy for you an OMD instance on a freshly installed system, they will configure an HAProxy for load balancing between two apache web servers.

We do not do the initial provisioning via these playbooks but this could be included in the future (i.e. deploy to joyent, cobbler or others). In other words we expect that you have the systems freshly installed and configured with a root user that is allowed SSH access as defined in the cmkconfinv (inventory) file.

### ansible inventory file
The cmkconvinf file contains our inventory. In it we define three groups of hosts, a variable named folder which is the OMD folder we create via the WATO API for the respective host(s) and the IP address where these hosts can be reached.

You must have these installed and configured before running these playbooks. You will also need to know the root user password.

## Prerequisites
Make sure you change the users and ssh keys via the common role. Upload you ssh keys in roles/common/files and edit roles/common/vars/usersandpsks.yml.

### Ansible
You will need a functional ansible set-up. Setting it up can be as easy as cloning the ansible repo or installing via your operating system package manager. More information about installing ansible can be found here: http://docs.ansible.com/ansible/intro_installation.html .

You will also need to clone this repository to play around with these playbooks.

### Check_MK
We are assuming you are using the CEE (Check_MK Enterprise Edition). While this should work with any recent version of Check_MK we are specifically targeting the use of the current innovation branch (1.2.7i) because of the new Alert Handlers (Werk #8275).  

If you would like to deploy your OMD instance via these playbooks you will need to download Check_MK CEE in RPM format and place it in the following directory:

> roles/omd/files

## Deploying OMD via Ansible
This is a very simple way to deploy an OMD instance and create a site named "prod". The following command will deploy OMD to your preinstalled server. It will prompt for the root users password (-k).

> ansible-playbook -i cmkconfinv site.yml -l omd -u root -k --skip-tags check_mk_agent,check_mk_discovery,check_mk_apply

Notice the use of the --skip-tags switch which is necessary as in this first run we do not have an OMD instance running from which to pull the agent, discovery, etc.

You now need to create an Automation user in our Check_MK site and use that information in the roles/omd/vars/main.yml file.

Now we can deploy the check_mk_agent to our monitoring instance as well. Notice we are running just the check_mk_agent, discovery and pply steps now. Also after bootstrapping your system you can use your own user if you created one and uploaded the ssh keys. In this case you could use ansible with sudo (-u *your_username* -s instead of -u root).

> ansible-playbook -i cmkconfinv site.yml -l omd -u root --tags check_mk_agent,check_mk_discovery,check_mk_apply


## Deploying the webserver and loadbalancer
The following will configure your webservers and loadbalancer. It will prompt for the root users password (-k). Once it is done you should have in your OMD instance 4 hosts (1 omd, 2 web servers and one lb) and their services monitored.

> ansible-playbook -i cmkconfinv site.yml -l loadbalancers,webservers -u root -k

## Check_MK Alert Handlers
We have created two alert handlers to showcase two different scenarios:

1. services.sh - Restarting of apache web services if they are failed
2. instantiate.sh - Deploying a loadbalancer if it fails (state DOWN)

These are specific to the setup we were using for the presentation at the conference however they serve as a good starting point.

Add the following two Alert Handlers to your Check_MK site and place the scripts in ~/local/share/check_mk/alert_handlers (make sure they are executable):

services.sh
![image of services.sh ](http://i67.tinypic.com/jgqqzm.png)
```
#!/bin/bash
ansible-playbook -i /omd/sites/prod/ansible/cmkconfinv /omd/sites/prod/ansible/site.yml -l webservers -u root --tags httpd
```

instantiate.sh
![image of instantiate.sh ](http://i65.tinypic.com/14c9s8w.png)
```
#!/bin/bash
ssh root@10.88.88.145 vmadm create -f /etc/zones/loadbalancer.json

ansible-playbook -i /omd/sites/prod/ansible/cmkconfinv /omd/sites/prod/ansible/site.yml -l loadbalancers -u root
```
The first line is specific to my setup which is using SmartOS available at 10.88.88.145. There I have already created a manifest file (loadbalancer.json) to create a loadbalancer instance. You will want to change this for your particular set-up.

## TODO
You may notice an extra two check_mk checks named up_upscale and  down_scale on your loadbalancer instance. These are not finished yet however they are an example of how you could use check_mk and ansible to do autoscaling. Based on feedback received via your monitoring you can bring up or down more instances effectively doing autoscaling. This is a work in progress and will be updated in the near future. The ansible tags are add_backend and del_backend, these may be useful if you plan on extending these.

There are certainly more things to be done here ...
