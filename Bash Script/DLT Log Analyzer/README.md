# Tired of manually sifting through log files?


![Version](https://img.shields.io/badge/Version-1-brightgreen)
![Author](https://img.shields.io/badge/Authors-Baraa%20Adel-blue)
![Date](https://img.shields.io/badge/Date-10%20April%202024-orange)

## Table of Contents

- [Introduction](#introduction)
- [Module Overview](#module-overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Code Structure](#code-structure)
- [Usage](#usage)
- [Testing](#testing)
- [Configuration](#configuration)
- [Disclaimer](#disclaimer)
- [Support](#support)

---

## Introduction

Welcome to the DLT log analyzer Documentation! This documentation serves as a comprehensive guide to understanding, configuring, and utilizing the log analyezer in your application. Whether you're a developer integrating it or a team member seeking insights into its functionality, this document is your go-to resource.

## Module Overview

This Bash script automates log analysis, generating a comprehensive report that summarizes errors, warnings, debug messages, informational messages, and system events.

## Features

- Extracts information from log files based on timestamps, log levels, and message content.
- Categorizes log entries into errors, warnings, debugging, informational, and system events (implementation required).
- Counts the total occurrences within each category.
- Generates a customizable report file containing summaries for each category.

## Prerequisites

To use it, make sure you have the following in place:
- Bash environment.
- Properly configured system with necessary permissions.
- Basic understanding of system log files.

## Code Structure

The DLT log analyzer code is structured as follows:
- `main.sh`: Main script file for executing the log analyzer and extract logs in a specific pattern.
- `global_vars.sh`: Script containing global variables, definitions and arrays of messages based on thier log level (ERROR, WARNING, DEBUG and INFO).
- `report.sh`: Script for generate a summarized report file and print it for users.
- `check.sh`: Script for catigurize logs into log levels.
- `log_report.txt`: report file contains summarized review.
- `extraced_logs.log`: log file contains the modified logs in a specific pattern.


## Usage

To use the DLT log analyzer in your project, follow these steps:
1. Make sure all Bash script files are present in your project directory.
2. Source `main.sh` to start the process monitoring system.


## Testing

- Below are the sample links for testing the DLT log analyzer:

![Startup main](https://drive.google.com/uc?export=view&id=1mxya2DXqMN4bObJXuLQC1h_lO3hxBNqM)

![Display Logs](https://drive.google.com/uc?export=view&id=1I95su4TuTpTvm53YQlT1gMQEZU6BlKno)

![Warning and Error Summary](https://drive.google.com/uc?export=view&id=1lH9m55CvMfEIcyam22oIxBr0ymVB3HMq)

![Filter logs by log level](https://drive.google.com/uc?export=view&id=1-Q0-3Pm2zVhDiz8e8ZDEWUMsF5R1LML3)

![Summarized Report](https://drive.google.com/uc?export=view&id=1tLh-1uMbVDlIlGl1BKIk-6-kllNO4kzF)



## Authors

- [Baraa Adel](https://www.github.com/kayedhom)

## Configuration

- Report File Name: Modify the report_file variable in the main function to change the report file name.
- Report Content: Edit the report_* functions to customize the report format and information included in each section.
- System Event Tracking: Implement logic within the report_System_Events_Tracing function to track specific system events using techniques like grep and modify the report accordingly.


## Disclaimer

This script provides a basic framework for log report generation. You might need to adapt it to your specific log format and desired report content. The system event tracking functionality requires further implementation based on your event types and message patterns.

## Support

For any questions or support, please contact [Baraa Adel](mailto:braaadel78@gmail.com).

---
