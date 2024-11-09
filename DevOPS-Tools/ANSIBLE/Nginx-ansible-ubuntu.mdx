### Setting Up Ansible on Ubuntu Server

To set up Ansible on an Ubuntu server, follow these steps:

1. **Update the package list**:

    ```sh
    sudo apt update
    ```

2. **Install Ansible**:

    ```sh
    sudo apt install ansible -y
    ```

3. **Verify the installation**:

    ```sh
    ansible --version
    ```

### Example 1: Installing and Configuring Nginx

This example will show you how to install and configure Nginx on an Ubuntu server using an Ansible playbook.

1. **Create an inventory file** named `hosts`:

    ```ini
    [webservers]
    web1.example.com
    web2.example.com
    ```

2. **Create a playbook file** named `nginx_setup.yml`:

    ```yaml
    ---
    - name: Install and configure Nginx
      hosts: webservers
      become: yes

      tasks:
        - name: Install Nginx
          apt:
            name: nginx
            state: present

        - name: Start and enable Nginx service
          systemd:
            name: nginx
            state: started
            enabled: yes

        - name: Create a custom Nginx configuration file
          copy:
            dest: /etc/nginx/sites-available/custom.conf
            content: |
              server {
                listen 80;
                server_name example.com;
                location / {
                  proxy_pass http://localhost:8080;
                }
              }

        - name: Enable the custom Nginx configuration
          file:
            src: /etc/nginx/sites-available/custom.conf
            dest: /etc/nginx/sites-enabled/custom.conf
            state: link

        - name: Remove the default Nginx configuration
          file:
            path: /etc/nginx/sites-enabled/default
            state: absent

        - name: Reload Nginx
          systemd:
            name: nginx
            state: reloaded
    ```

3. **Run the playbook**:

    ```sh
    ansible-playbook -i hosts nginx_setup.yml
    ```

### Example 2: Setting Up a User and Deploying a Web Application

This example demonstrates how to set up a new user and deploy a simple web application on an Ubuntu server.

1. **Create an inventory file** named `hosts`:

    ```ini
    [webservers]
    web1.example.com
    ```

2. **Create a playbook file** named `deploy_app.yml`:

    ```yaml
    ---
    - name: Set up a user and deploy a web application
      hosts: webservers
      become: yes

      vars:
        app_user: deployuser
        app_name: myapp

      tasks:
        - name: Ensure the user exists
          user:
            name: "{{ app_user }}"
            shell: /bin/bash

        - name: Create application directory
          file:
            path: "/var/www/{{ app_name }}"
            state: directory
            owner: "{{ app_user }}"
            group: "{{ app_user }}"

        - name: Copy application files
          copy:
            src: ./app/
            dest: "/var/www/{{ app_name }}/"
            owner: "{{ app_user }}"
            group: "{{ app_user }}"
            mode: '0755'

        - name: Install necessary packages
          apt:
            name:
              - python3
              - python3-pip
            state: present

        - name: Install application dependencies
          pip:
            requirements: "/var/www/{{ app_name }}/requirements.txt"
    ```

3. **Run the playbook**:

    ```sh
    ansible-playbook -i hosts deploy_app.yml
    ```

### Example 3: Configuring a Firewall with UFW

This example shows how to configure the Uncomplicated Firewall (UFW) on an Ubuntu server to allow specific ports.

1. **Create an inventory file** named `hosts`:

    ```ini
    [webservers]
    web1.example.com
    ```

2. **Create a playbook file** named `ufw_setup.yml`:

    ```yaml
    ---
    - name: Configure UFW firewall
      hosts: webservers
      become: yes

      tasks:
        - name: Ensure UFW is installed
          apt:
            name: ufw
            state: present

        - name: Allow SSH connections
          ufw:
            rule: allow
            port: 22

        - name: Allow HTTP connections
          ufw:
            rule: allow
            port: 80

        - name: Allow HTTPS connections
          ufw:
            rule: allow
            port: 443

        - name: Enable UFW
          ufw:
            state: enabled
            policy: deny
    ```

3. **Run the playbook**:

    ```sh
    ansible-playbook -i hosts ufw_setup.yml
    ```

### Example 4: Managing System Updates

This example demonstrates how to manage system updates on an Ubuntu server.

1. **Create an inventory file** named `hosts`:

    ```ini
    [servers]
    server1.example.com
    server2.example.com
    ```

2. **Create a playbook file** named `system_update.yml`:

    ```yaml
    ---
    - name: Update and upgrade the system
      hosts: servers
      become: yes

      tasks:
        - name: Update apt cache
          apt:
            update_cache: yes

        - name: Upgrade all packages
          apt:
            upgrade: dist
    ```

3. **Run the playbook**:

    ```sh
    ansible-playbook -i hosts system_update.yml
    ```

> These examples provide a practical introduction to using Ansible for common administrative tasks on Ubuntu servers. By extending these playbooks, you can automate a wide range of tasks to manage your infrastructure efficiently.