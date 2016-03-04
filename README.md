# Moving People Safely

[![Code Climate](https://codeclimate.com/github/ministryofjustice/moving-people-safely/badges/gpa.svg)](https://codeclimate.com/github/ministryofjustice/moving-people-safely)

| Dependency         | Version |
|--------------------|---------|
| Ruby               | 2.3.0   |
| Rails              | 4.2.5.2 |
| Postgres           | 9.4.5   |
| Webkit HTML to PDF | 0.12.3  |
| Font: Liberation Sans | 12 Jan 2009 version|

## Configuration

### `Local Setup`

#### `Testing in old IE`

User research indicates that the overwhelming majority of users will access
this service in Internet Explorer 8 running on Windows XP. Testing the
user experience therefore requires the installation and running of a suitable
virtual machine.

While both products have details instructions the high-level process to
get up and running is downloading:

* The latest version of [Virtual Box](https://www.virtualbox.org).
* Virtual Machines from [Microsoft](https://dev.windows.com/en-us/microsoft-edge/tools/vms/mac/)

Having done this you will be able to add the downloaded VMs to
VirtualBox by:

* Selecting 'New'
* Naming the VM and clicking 'Continue'
* Accepting all defaults until prompted about the Hard Disk, at which
  point you should 'Use an existing..' and point it to the downloaded
.vmdk file

From within a Virtual Machine you will be able to access external URLs by
addressing them normally and localhost on the host machine from http://10.0.2.2

#### `FONTS`

The PDF output relies on the `Liberation Sans` font being present on the host
machine. You can find the relevant fonts in the `fonts/` directory. You should
be able to add them to OS X by double clicking the font.

The `Dockerfile` is responsible for setting up the fonts from the repo on the
container. It also includes a font configuration file required to fix font
hinting and anti-aliasing in the container when generating PDF's.

### `Environment Variables`

#### `SECRET_KEY_BASE`

This key is used to verify the integrity of signed cookies. If it is changed,
all old signed cookies will become invalid.

Make sure the secret is at least 30 characters and all random, no regular words
or you’ll be exposed to dictionary attacks. You can use `rake secret` to
generate a secure secret key.

The framework we use for managing user authentication (Devise) also requires this
to be set in production in order to generate user tokens.

#### `SERVICE_URL`

This is used to build links in emails(invitation, password reset etc). It must
be set in the production environment to `https://mps-prod.dsd.io/`.

#### `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_HOSTNAME`, `SMTP_PORT`, `SMTP_DOMAIN`

These configure email delivery in the production environment.
