
# PayByGroup Implementation Notes

These notes and the notes at the top of some source files detail key aspects of PayByGroup's implementation.
These notes are intentionally incomplete.  They details key choices, but not exaustively all choices made in
the Gpay1 implementation.

## Architectural Design Choices

### Common Control Variables

- params[:pu] and @pu -- The current PurchaseUser object
- current_user -- The user currently authenticated
- params[:cgp] and @cgp -- The current GroupPurchase object  (PROPOSED 13/3)
- params[:invite] -- The current invitation object (PROPOSED 13/3)



## Subsystems

### Merchant Initiated APIs


### Backups



- LOGS
  - log/whenever.log   -- when cron runs
  - look at AWS console

- GEMS
  - astrails -- uses sec-config to send postgres DB state to S3

- CONFIG 
  - config/sec_config.yml  -- contains secret key for S3 access.
                              (add key and secret from from AWS)
  - config/safe.rb         -- contains config of gem  (e.g. where DB and S3 are, etc.)
  - config/schedule.rb     -- whenever configuration for the hourly backup cron
  - config/database.yml    -- uses apps data about the DB.

- TO RESTORE

    # Use CyberDuck to copy backup from S3 to Mac ; Use Transit to copy to lets2 (if needed)

    $ psql -h 184.106.167.65 -d lets2 -f lets2dump            # restore
    $ psql -U postgres -h 184.106.167.65 lets2 < lets2dump
    $ cat db/database.yml  # for DB names
      \l   # lists all DBs

- Implementation

  - Whenever sets cron

  - CRON TAB as added by whenever in cap script. runs every hour

  0 * * * * /bin/bash -l -c 'cd .../app  && RAILS_ENV=production bundle exec astrails-safe config/safe.rb >> log/whenever.log 2>&1'


  - xxx

