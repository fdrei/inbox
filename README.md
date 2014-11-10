inbox
=====

One app to rule messages, contacts and calendars.


TODO
----------------------------------------------------
- [ ] @mupat add Gulpfile and tasks for compiling etc.
- [ ] @maccypher add design documents in a 'specs' folder?
- [ ] @kr1sp1n add ContactService and MessageService




Install
----------------------------------------------------

    git clone git@github.com:fdrei/inbox.git
    cd inbox
    npm install


Run
----------------------------------------------------

    npm start


Structure
----------------------------------------------------

                        ┌─────────────┐
                        │ Angular App	│
                        └──────┬──────┘
                               │
                        ┌──────┴──────┐
                        │ inbox core  │
                        └──────┬──────┘
                               │
            ┌──────────────────┼───────────────────┐
            │                  │                   │
    ┌───────┴───────┐  ┌───────┴────────┐  ┌───────┴────────┐
    │ PersonService │  │ ContactService │  │ MessageService │
    └───────┬───────┘  └───────┬────────┘  └───────┬────────┘
            │                  │                   │
            └──────────────────┼───────────────────┘
                               │
                           ┌───┴──┐
                           │ nedb │
                           └──────┘
