# HDRP: Human Disaster Recovery Plan

## tl;dr

HDRP is a simple and extremely secured vault solution to share your passwords with a trustworthy person if something really bad happen to you (yes, I'm speaking about death).


## The problem

I'm an IT consultant and a devops. I host a lot of projects and manage a lot of servers with extremely confidential datas for my clients.

It's why I'm paranoid about security:
- I never use passwords with less than 32 strings
- I have a different password for each account I have
- I use a strong asymmetrical encryption system to connect to my servers
- I never connect to internet without using my encrypted VPN access
- I have a strong password on my laptop and, of course, the hard drive et encrypted

It's really great for the security.

But what will happen if I have a physical accident, or worst, if I die?

Nobody is capable to get my passwords or access to my servers and my clients will just loose their datas :(

This is why I've create HDRP, Human Disaster Recovery Plan.


## The solution

The idea is to keep every important documents, passwords and keys in an extremely secured decentralized system.
Only one trustworthy person could access those files and he will be able to decrypt them only if he get a physical access to the private key, protected by a password.


## How does it works?

A private key, protected by a password, will be generated. This key will be saved on a USB key and will be hide in a secured location.

The password and the location of this USB key should be known only by the trustworthy person. For security reason, the trustworthy person should not be able to access to this key unless you're dead. Ideally, a notary should keep this key.

When you want to add files to share, you have two options:
- in /encrypted: every file in this directory will be encrypted (AES-256-CBC). You can add your main passwords (phone, laptop, 1password etc...), private keys and confidential documents.
- in /notEncrypted: you can share (in PLAIN TEXT) not critical document like procedures. Your trustworthy person will read it and can ask you about details to be sure he understand your procedures.

Then you will push those files to a git server, where the trustworthy person will get an access.

If one day something bad happen to you, the trustworthy person will get the USB key and will be able to decrypt your files.


## Getting started

1. Clone the project:
`git clone git@github.com:Bacto/hdrp.git`

1. Create a private git repository and

1. Create a vault and a private/public key:
`./scripts/init.sh`

1. **Move** the private key `hdrpKeyPrivate.pem` to a USB key and store this USB key in a secured place.

1. Contact the trustworthy person. Give it to him:
    - the location of the USB key (ideally, a notary will keep it or somewhere in your house)
    - the private key password
    - the access to the git repository

1. Add files to your vault (in vault/<user>/) and push them to your git repository. Files in `encrypted` directory will be encrypted on commit.


## How to decrypt the datas

You're the trustworthy and you want to decrypt this repository datas.

You have to get the USB key and copy the private key to the current directory.

Then just run `./scripts/decryptFile.sh <file>`

Enter the private key password and that's it :)


## What about the security?

- the private key is on a USB key physically hidden somewhere
- the private key is protected by a password
- the repository is private and just share with the trustworthy person
- files are encrypted in AES-256-CBC with a very strong password (344 characters)
- the password is different for every file and encrypted by a 4096 bits key
