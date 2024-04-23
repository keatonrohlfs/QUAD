# QUAD Marketplace

## Sprint 3 features
- ~No-reply email <- Cole~
- ~Make admin page inaccessible to non-admins <- Keaton~
- ~Re-add check box for unverified only listings <- Cole~
- ~Fix rent field in create listing form <- Michael~
- ~Fix rendering of listings so that they display in a grid and not a row <- Michael~
- ~Sort listings by name, price, and upload date (user and admin) <- Cole~
- ~Toggle to only show unverified listings (admin only) <- Cole~
- ~Search for users (admin only) <- Deondre~
- Shopify integration 
- S3 image hosting 
- ~Migrate and build existing database on compose <- Michael~
#### If we have time:
- ~Rework listing page <- Keaton~
- Reject listing button (admin only)
- HTTPS support

## Usage
### To start
```
docker compose build
docker compose up
```
### To stop
Normal shutdown
```
docker compose down
```
Shutdown and clear databases
```
docker compose down -v
```
