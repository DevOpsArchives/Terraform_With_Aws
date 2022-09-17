If you get erros like this 
`for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.` on the server machine then do these :-

* `sudo apt install nfs-kernel-server`
* `sudo exportfs -a`

Stack Exchange Article - https://unix.stackexchange.com/questions/65376/nfs-does-not-work-mount-wrong-fs-type-bad-option-bad-superblocks