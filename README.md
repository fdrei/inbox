inbox
====================================================

one app to rule messages, contacts and calendars

[![Build Status](https://travis-ci.org/fdrei/inbox.svg)](https://travis-ci.org/fdrei/inbox)
[![Coverage Status](https://coveralls.io/repos/fdrei/inbox/badge.png?branch=master)](https://coveralls.io/r/fdrei/inbox?branch=master)
[![Build Status](https://api.shippable.com/projects/54624c5bc6f0803064f424df/badge?branchName=master)](https://app.shippable.com/projects/54624c5bc6f0803064f424df/builds/latest)



TODO
----------------------------------------------------
- [ ] add Gulpfile and tasks for compiling etc. [@mupat][@mupat]
- [ ] add design documents in a 'specs' folder? [@maccypher][@maccypher]
- [ ] add ContactService and MessageService [@kr1sp1n][@kr1sp1n]



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








[@maccypher]: https://github.com/maccypher "maccypher"
[@mupat]: https://github.com/mupat "mupat"
[@kr1sp1n]: https://github.com/kr1sp1n "kr1sp1n"
