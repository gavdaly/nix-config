# Nix Configurations

This repository contains Nix configurations for managing development environments on four main systems: Zeus, Hestia, Athena (MacBook Pro with M2), and a Raspberry Pi k3s cluster. These configurations are designed to be reproducible and portable, leveraging Nix Flakes to ensure consistency across setups.

## Overview

- **Zeus**: A development-focused machine with a Hyperland frontend, configured for a streamlined and efficient development environment.
- **Hestia**: A simpler configuration, currently set up to run basic services and host small databases, intended for lightweight and focused tasks.
- **Athena**: A MacBook Pro configured with Home Manager for a portable and efficient development environment tailored to macOS.
- **Raspberry Pi k3s Cluster**: A lightweight Kubernetes cluster built with Raspberry Pis, configured for distributed computing and containerized workloads.

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

### 3. **Athena**
   - **Purpose**: Athena is a MacBook Pro with M2, configured for development on macOS using Home Manager.
   - **Features**:
     - **Home Manager Integration**: Manages the development environment efficiently with portable configurations.
     - **macOS-Specific Tweaks**: Optimized settings and tools tailored for macOS.
     - **Aarch64 Support**: Configured specifically for the ARM-based architecture of the M2 chip.

### 4. **Raspberry Pi k3s Cluster**
   - **Purpose**: A lightweight Kubernetes cluster built with Raspberry Pis, ideal for learning, experimentation, and running containerized workloads.
   - **Features**:
     - **Master Node**: `rpi-master` acts as the control plane for the cluster.
     - **Worker Nodes**: `rpi-worker01`, `rpi-worker02`, and `rpi-worker03` serve as the compute resources.
     - **Kubernetes**: Running k3s, a lightweight Kubernetes distribution, optimized for ARM-based devices.

## Structure

- **flake.nix**: The core file that defines configurations for Zeus, Hestia, Athena, and the k3s Raspberry Pi cluster. It includes references to system-specific settings and packages.
- **hosts/**: Directory containing system-specific configurations for Zeus, Hestia, Athena, and the Raspberry Pi cluster nodes.

## TODO

- **Modules Directory**: Add a `modules` directory for shared modules across different machines.
- **Overlays Directory**: Implement an `overlays` directory to manage custom Nix overlays for package modifications or extensions.
- **Move Other Server Over**: Migrate the remaining server to use the configurations in this repository.

## Getting Started

### Prerequisites

Ensure Nix and Flakes support are enabled on your system. Follow the [Nix installation guide](https://nixos.org/download.html) to set up Nix or NixOS.

### Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/gavdaly/nix-config.git
   cd nix-config
   ```

2. **Apply the Configuration**:
   - Use the configuration for your machine:
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

5. **Format the Configuration**:
   - Use `nixpkgs-fmt` to automatically format your Nix files:
     ```bash
     nixpkgs-fmt .
     ```

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request. Contributions are welcome!

---

The README now reflects the creation of the `hosts` directory and removes it from the TODO list.
