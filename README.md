# Moving People Safely

[![Code Climate](https://codeclimate.com/github/ministryofjustice/moving-people-safely/badges/gpa.svg)](https://codeclimate.com/github/ministryofjustice/moving-people-safely)

| Dependency         | Version |
|--------------------|---------|
| Ruby               | 2.3.0   |
| Rails              | 4.2.5.1 |
| Postgres           | 9.4.5   |
| Webkit HTML to PDF | 0.12.3  |
| Font: Liberation Sans | 12 Jan 2009 version|

## Configuration

### `Local Setup`

#### `FONTS`

The PDF output relies on the `Liberation Sans` font being present on the host
machine. You can find the relevant fonts in the `fonts/` directory. You should
be able to add them to OS X by double clicking the font.

The `Dockerfile` is responsible for setting up the fonts from the repo on the
container.

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
