# Nix Configurations

This repository contains Nix configurations for managing development environments on two main systems: Zeus and Hestia. These configurations are designed to be reproducible and portable, leveraging Nix Flakes to ensure consistency across setups.

## Overview

- **Zeus**: A development-focused machine with a Hyperland frontend, configured for a streamlined and efficient development environment.
- **Hestia**: A simpler configuration, currently set up to run basic services and host small databases, intended for lightweight and focused tasks.

## Systems

### 1. **Zeus**
   - **Purpose**: Zeus is configured as a development machine with a focus on providing a powerful and efficient environment.
   - **Features**:
     - **Hyperland Frontend**: A modern and responsive window manager tailored for development.
     - **Development Tools**: Includes essential tools for coding, compiling, and other development activities.
     - **Custom Configurations**: Tweaked settings to optimize the development experience on Zeus.

### 2. **Hestia**
   - **Purpose**: Hestia serves as a utility machine, designed to run simple services and host small databases.
   - **Features**:
     - **Plain Configuration**: A minimal setup, focusing on reliability and simplicity.
     - **Service Management**: Configured to run essential services with minimal overhead.
     - **Database Hosting**: Set up to handle small, lightweight databases efficiently.

## Structure

- **flake.nix**: The core file that defines configurations for both Zeus and Hestia. It includes references to system-specific settings and packages.

## TODO

- **Hosts Directory**: Create a `hosts` directory to contain system-specific configurations for Zeus and Hestia.
- **Modules Directory**: Add a `modules` directory for shared modules across different machines.
- **Overlays Directory**: Implement an `overlays` directory to manage custom Nix overlays for package modifications or extensions.
- **Move Other Server Over**: Migrate the remaining server to use the configurations in this repository.
- **Mac Development Machine**: Set up Home Manager to manage the development environment on your Mac.
- **Raspberry Pi Cluster**: Configure four Raspberry Pis to run k3s (lightweight Kubernetes).

## Getting Started

### Prerequisites

Ensure Nix and Flakes support are enabled on your system. Follow the [Nix installation guide](https://nixos.org/download.html) to setup nix or nixos.

### Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/gavdaly/nix-config.git
   cd nix-config
   ```

2. **Apply the Generic Configuration**:
   - Use the configuration for your machine once the hostname is set:
     ```bash
     sudo nixos-rebuild switch --flake .
     ```

3. **Rebuild the System**:
   - Rebuild your system with the applied configurations:
     ```bash
     sudo nixos-rebuild switch --flake .
     ```

4. **Customization**:
   - Modify the relevant `flake.nix` to customize each system's setup.
   - Rebuild the system using the commands above to apply your changes.

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request. Contributions are welcome!
