Thank you for providing the Bash files for your project. Based on the provided files, I will now create a README file for your Bash project.

---

# Process Monitor System

![Version](https://img.shields.io/badge/Version-1-brightgreen)
![Author](https://img.shields.io/badge/Authors-Baraa%20Adel-blue)
![Date](https://img.shields.io/badge/Date-5%20March%202024-orange)

## Table of Contents

- [Introduction](#introduction)
- [Module Overview](#module-overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Code Structure](#code-structure)
- [Usage](#usage)
- [Authors](#authors)
- [Configuration](#configuration)
- [Support](#support)

---

## Introduction

Welcome to the Process Monitor System Documentation! This documentation serves as a comprehensive guide to understanding, configuring, and utilizing the Process Monitor in your application. Whether you're a developer integrating it or a team member seeking insights into its functionality, this document is your go-to resource.

## Module Overview

The Process Monitor offers precise configuration capabilities essential for various applications. From initialization to advanced features like Querying control, this documentation covers it all. The code structure, configuration options, this project is based on specific requirements.

## Features

- Provides an interface for reading or setting individual or group of process IDs.
- Error handling for invalid input.
- Configuration options for setting limits on CPU and memory usage.
- Alert mechanism for exceeding CPU and memory usage thresholds.

## Prerequisites

To use the Process Monitor System, make sure you have the following in place:
- Bash environment.
- Properly configured system with necessary permissions.
- Basic understanding of system resources and monitoring.

## Code Structure

The Process Monitor System code is structured as follows:
- `main.sh`: Main script file for executing the process monitoring system.
- `MonitorProcess.sh`: Script containing functions for process monitoring.
- `Search_services.sh`: Script for searching and filtering processes.
- `mem_cpu_usage.sh`: Script for calculating CPU and memory usage.
- `log_service.sh`: Script for logging activities and configurations.
- `Config_sets.txt`: Configuration file containing thresholds and refresh rates.
- `Config_Edit.sh`: Script for editing configuration settings.

## Usage

To use the Process Monitor System in your project, follow these steps:
1. Make sure all Bash script files are present in your project directory.
2. Configure `Config_sets.txt` according to your project requirements.
3. Execute `main.sh` to start the process monitoring system.
4. Follow the on-screen instructions to monitor and manage processes.


## Testing

- Below are the sample links for testing the Process Monitor System:

### Startup main

![Startup main](https://drive.google.com/uc?export=view&id=1uP5vAgP8nzEirU9ds9dKwTlFdplQzmVd)

### Display Configurations

![Display Configurations](https://drive.google.com/uc?export=view&id=1BFw_x59DHa0Uta_12MFJ8GCTe-d85hxg)

### Monitor Process

![Monitor Process](https://drive.google.com/uc?export=view&id=1hxGZ2_9zrIoPN4fqHPIaNMOGLzn1caPd)

### Filter Process by user

![Filter Process by user](https://drive.google.com/uc?export=view&id=1zs0aVjDggNNyn2SpwWzAmeIqT2iQV2yA)

### Changing Configuration

![Changing Configuration](https://drive.google.com/uc?export=view&id=1UkmZn1UvFUBpFhS8ZuscVbAgC4CgyBeg)


### Rewrite Config file in Runtime

![Rewrite Config file in Runtime](https://drive.google.com/uc?export=view&id=1wf0cB1nsbTFAiwl4bKARKt-zJPObP9qD)


## Authors

- [Baraa Adel](https://www.github.com/kayedhom)

## Configuration

You can configure the Process Monitor System using the `Config_sets.txt` file. This file contains various configuration variables such as refresh rate, CPU and memory usage limits, and alert thresholds.

For more information on configuring the Process Monitor System, refer to the documentation provided within the scripts.

## Support

For any questions or support, please contact [Baraa Adel](mailto:braaadel78@gmail.com).

---

This README provides an overview of the Process Monitor System, its features, usage instructions, and configuration details. Feel free to customize it further based on your specific project requirements. Let me know if you need any further assistance!
