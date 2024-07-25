## OSINT Tools Installer for Kubuntu

This guide will help you set up the OSINT tools on a fresh Kubuntu installation.

### 1. Create the Script File

1. Open a terminal.
2. Use a text editor to create the script file. For example, you can use `nano`:

   ```bash
   nano ~/Desktop/Kubuntu-OSINT-installer.sh
   ```

3. Copy and paste the OSINT installer script into the editor. [**View the script**]([path/to/your/script](https://github.com/1337codes/Kubuntu-OSINT-Tools-Package/blob/main/Kubuntu-OSINT-installer.sh)) and then save and exit the editor.

### 2. Make the Script Executable

Run the following command in the terminal to make the script executable:

```bash
chmod +x ~/Desktop/Kubuntu-OSINT-installer.sh
```

### 3. Run the Script

Execute the script with `sudo` to ensure it has the necessary permissions to install software and modify system settings:

```bash
sudo ~/Desktop/Kubuntu-OSINT-installer.sh
```

### Example Terminal Session

```bash
# Open terminal and navigate to the directory containing the script
cd ~/Desktop

# Make the script executable
chmod +x Kubuntu-OSINT-installer.sh

# Run the script with sudo
sudo ./Kubuntu-OSINT-installer.sh
```

### Notes

- **Sudo Password**: When you run the script with `sudo`, you will be prompted to enter your password.
- **Log Files**: After the script finishes, check the `logs` folder on your desktop for the `osint_install_error.log` file to review any errors that occurred during the installation.
- **Keep-alive Process**: The script includes a keep-alive process that runs in the background to maintain sudo privileges. The `trap` and `cleanup` functions ensure that this process is terminated when the script exits.

By following these instructions, you will set up the necessary OSINT tools on your Kubuntu system.

---
