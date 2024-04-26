## Testing

## Automated testing
The "db/seeds.rb" file generates a default user and admin account at build time. This file also generates 18 listings for the default user account.

## High-risk features
The following features were deemed "high-risk": 
### Login
The login functionality was tested with a variety of valid and invalid credentials. These included, but were not limited to:
- Valid user credentials
- Valid admin credentials
- Invalid email
- Invalid password
- Partly valid email
- Partly valid password
### Access control
The access control functionality was tested thoroughly on every page. This was done by logging in as a user and attempting to access the pages of other users/admins.
