Essential Linux Commands for System Administrators (500 Commands)
1. File and Directory Management (50 commands)
bash


# 1. ls — List files and directories
ls -la

# 2. cd — Change directory
cd /path/to/directory

# 3. pwd — Print working directory
pwd

# 4. mkdir — Create directories
mkdir -p dir1/dir2/dir3

# 5. rmdir — Remove empty directories
rmdir directory

# 6. rm — Remove files and directories
rm -rf directory

# 7. cp — Copy files and directories
cp -r source destination

# 8. mv — Move/rename files and directories
mv oldname newname

# 9. touch — Create empty files or update timestamps
touch filename

# 10. find — Search for files and directories
find /path -name "*.txt"

# 11. locate — Find files quickly using database
locate filename

# 12. updatedb — Update locate database
sudo updatedb

# 13. which — Locate command
which python

# 14. whereis — Locate binary, source, manual
whereis ls

# 15. tree — Display directory structure as tree
tree /var/log

# 16. basename — Extract filename from path
basename /path/to/file.txt

# 17. dirname — Extract directory from path
dirname /path/to/file.txt

# 18. realpath — Show absolute path
realpath file.txt

# 19. readlink — Show symbolic link target
readlink -f symlink

# 20. ln — Create links
ln -s target linkname

# 21. file — Determine file type
file /bin/ls

# 22. stat — Display file statistics
stat filename

# 23. du — Show directory space usage
du -sh directory

# 24. df — Show filesystem disk space
df -h

# 25. rsync — Synchronize files/directories
rsync -avz source/ dest/

# 26. scp — Secure copy over SSH
scp file user@host:/path

# 27. split — Split files into pieces
split -b 10M largefile

# 28. csplit — Split files based on context
csplit file /pattern/

# 29. shred — Securely delete files
shred -vfz -n 3 file

# 30. rename — Rename multiple files
rename 's/old/new/' *.txt

# 31. mmv — Mass move/rename files
mmv "*.txt" "#1.bak"

# 32. symlinks — Manage symbolic links
symlinks -r /path

# 33. pathchk — Check pathname validity
pathchk /path/to/file

# 34. mktemp — Create temporary files/directories
mktemp -d

# 35. tempfile — Create temporary file
tempfile

# 36. install — Copy files with permissions
install -m 755 source dest

# 37. sync — Flush filesystem buffers
sync

# 38. fsync — Synchronize file data
fsync file

# 39. truncate — Shrink/extend file size
truncate -s 0 file

# 40. fallocate — Preallocate space to file
fallocate -l 1G file

# 41. dd — Convert and copy files
dd if=/dev/zero of=file bs=1M count=100

# 42. cpio — Copy files to/from archives
find . | cpio -ov > archive.cpio

# 43. pax — Portable archive exchange
pax -w -f archive.pax .

# 44. mtree — Map directory hierarchy
mtree -c > spec

# 45. fdupes — Find duplicate files
fdupes -r /path

# 46. rdfind — Find duplicate files
rdfind /path

# 47. duff — Duplicate file finder
duff -r /path

# 48. hardlink — Consolidate duplicate files
hardlink /path

# 49. fslint — Find filesystem lint
fslint /path

# 50. ncdu — NCurses disk usage analyzer
ncdu /path
2. File Content Operations (40 commands)
bash


# 51. cat — Display file contents
cat file.txt

# 52. tac — Display file contents in reverse
tac file.txt

# 53. head — Show first lines of file
head -n 10 file.txt

# 54. tail — Show last lines of file
tail -f /var/log/syslog

# 55. less — View file contents page by page
less file.txt

# 56. more — View file contents page by page
more file.txt

# 57. grep — Search text patterns
grep -r "pattern" /path

# 58. egrep — Extended grep
egrep "pattern1|pattern2" file

# 59. fgrep — Fixed string grep
fgrep "literal string" file

# 60. rgrep — Recursive grep
rgrep "pattern" /path

# 61. zgrep — Grep compressed files
zgrep "pattern" file.gz

# 62. sed — Stream editor
sed 's/old/new/g' file

# 63. awk — Text processing tool
awk '{print $1}' file

# 64. cut — Extract columns from text
cut -d: -f1 /etc/passwd

# 65. sort — Sort lines in text files
sort -n file.txt

# 66. uniq — Report or omit repeated lines
uniq -c file.txt

# 67. comm — Compare sorted files line by line
comm file1 file2

# 68. diff — Compare files line by line
diff file1 file2

# 69. patch — Apply differences to files
patch < patchfile

# 70. wc — Count lines, words, characters
wc -l file.txt

# 71. nl — Number lines in files
nl file.txt

# 72. pr — Format files for printing
pr -n file.txt

# 73. fold — Wrap lines to specified width
fold -w 80 file.txt

# 74. fmt — Format text paragraphs
fmt file.txt

# 75. expand — Convert tabs to spaces
expand file.txt

# 76. unexpand — Convert spaces to tabs
unexpand file.txt

# 77. tr — Translate or delete characters
tr 'a-z' 'A-Z' < file.txt

# 78. rev — Reverse lines character-wise
rev file.txt

# 79. strings — Extract printable strings from binary
strings /bin/ls

# 80. hexdump — Display file in hexadecimal
hexdump -C file

# 81. od — Dump files in octal/other formats
od -x file

# 82. xxd — Make hexdump or reverse
xxd file.bin

# 83. base64 — Base64 encode/decode
base64 file.txt

# 84. uuencode — Encode binary file
uuencode file.bin file.bin > file.uu

# 85. uudecode — Decode uuencoded file
uudecode file.uu

# 86. iconv — Convert text encoding
iconv -f utf8 -t ascii file.txt

# 87. dos2unix — Convert DOS line endings
dos2unix file.txt

# 88. unix2dos — Convert to DOS line endings
unix2dos file.txt

# 89. column — Columnate lists
column -t file.txt

# 90. paste — Merge lines of files
paste file1 file2
3. File Permissions and Ownership (25 commands)
bash


# 91. chmod — Change file permissions
chmod 755 file

# 92. chown — Change file ownership
chown user:group file

# 93. chgrp — Change group ownership
chgrp group file

# 94. umask — Set default permissions
umask 022

# 95. getfacl — Get file ACLs
getfacl file

# 96. setfacl — Set file ACLs
setfacl -m u:user:rwx file

# 97. lsattr — List file attributes
lsattr file

# 98. chattr — Change file attributes
chattr +i file

# 99. namei — Follow pathname resolution
namei -l /path/to/file

# 100. groups — Show user groups
groups username

# 101. id — Show user and group IDs
id username

# 102. whoami — Show current username
whoami

# 103. logname — Show login name
logname

# 104. su — Switch user
su - username

# 105. sudo — Execute as another user
sudo command

# 106. sudoedit — Edit files as root
sudoedit /etc/hosts

# 107. visudo — Edit sudoers file
visudo

# 108. newgrp — Log into new group
newgrp groupname

# 109. sg — Execute command as different group
sg group -c command

# 110. gpasswd — Administer groups
gpasswd -a user group

# 111. passwd — Change password
passwd username

# 112. chage — Change password aging
chage -l username

# 113. usermod — Modify user account
usermod -aG group user

# 114. getent — Get entries from databases
getent passwd

# 115. access — Check file accessibility
access -r file
4. Process Management (35 commands)
bash


# 116. ps — Show running processes
ps aux

# 117. top — Real-time process viewer
top

# 118. htop — Interactive process viewer
htop

# 119. atop — Advanced system monitor
atop

# 120. iotop — I/O usage monitor
iotop

# 121. kill — Terminate processes
kill -9 PID

# 122. killall — Kill processes by name
killall firefox

# 123. pkill — Kill processes by pattern
pkill -f pattern

# 124. pgrep — Find processes by pattern
pgrep nginx

# 125. pidof — Find PID of program
pidof sshd

# 126. pstree — Show process tree
pstree

# 127. jobs — List active jobs
jobs

# 128. fg — Bring job to foreground
fg %1

# 129. bg — Send job to background
bg %1

# 130. nohup — Run command immune to hangups
nohup command &

# 131. disown — Remove job from shell
disown %1

# 132. screen — Terminal multiplexer
screen -S session

# 133. tmux — Terminal multiplexer
tmux new-session

# 134. nice — Run with modified priority
nice -n 10 command

# 135. renice — Change process priority
renice -n 5 -p PID

# 136. ionice — Set I/O scheduling priority
ionice -c 3 command

# 137. taskset — Set CPU affinity
taskset -c 0,1 command

# 138. cpulimit — Limit CPU usage
cpulimit -l 50 command

# 139. timeout — Run command with time limit
timeout 30s command

# 140. strace — Trace system calls
strace -p PID

# 141. ltrace — Trace library calls
ltrace command

# 142. lsof — List open files
lsof -p PID

# 143. fuser — Show processes using files
fuser /path/to/file

# 144. pmap — Show process memory map
pmap PID

# 145. pidstat — Show process statistics
pidstat 1

# 146. time — Measure command execution time
time command

# 147. uptime — Show system uptime and load
uptime

# 148. w — Show logged-in users
w

# 149. who — Show logged-in users
who

# 150. last — Show login history
last
5. System Information and Hardware (30 commands)
bash


# 151. uname — System information
uname -a

# 152. hostname — Show/set hostname
hostname

# 153. hostnamectl — Control hostname
hostnamectl set-hostname name

# 154. lscpu — CPU information
lscpu

# 155. lsusb — USB devices
lsusb

# 156. lspci — PCI devices
lspci

# 157. lsblk — Block devices
lsblk

# 158. lsmod — Loaded kernel modules
lsmod

# 159. modinfo — Module information
modinfo module_name

# 160. modprobe — Load/unload kernel modules
modprobe module_name

# 161. rmmod — Remove kernel module
rmmod module_name

# 162. insmod — Insert kernel module
insmod module.ko

# 163. depmod — Generate module dependencies
depmod -a

# 164. lshw — Hardware information
lshw -short

# 165. dmidecode — DMI table decoder
dmidecode -t system

# 166. hwinfo — Hardware information
hwinfo --short

# 167. inxi — System information script
inxi -Fxz

# 168. neofetch — System information display
neofetch

# 169. screenfetch — System information display
screenfetch

# 170. free — Memory usage
free -h

# 171. vmstat — Virtual memory statistics
vmstat 1

# 172. mpstat — CPU statistics
mpstat 1

# 173. iostat — I/O statistics
iostat 1

# 174. sar — System activity reporter
sar -u 1 3

# 175. dmesg — Kernel ring buffer
dmesg | tail

# 176. journalctl — Systemd journal
journalctl -xe

# 177. systemctl — Control systemd services
systemctl status service

# 178. service — Control system services
service nginx status

# 179. chkconfig — Configure services
chkconfig --list

# 180. update-rc.d — Configure services (Debian)
update-rc.d service enable
6. Network Commands (40 commands)
bash


# 181. ip — Network configuration
ip addr show

# 182. ifconfig — Network interface configuration
ifconfig eth0

# 183. ping — Send ICMP packets
ping google.com

# 184. ping6 — Send ICMPv6 packets
ping6 ipv6.google.com

# 185. traceroute — Trace packet route
traceroute google.com

# 186. tracepath — Trace network path
tracepath google.com

# 187. mtr — Network diagnostic tool
mtr google.com

# 188. netstat — Network statistics
netstat -tulnp

# 189. ss — Socket statistics
ss -tulnp

# 190. nmap — Network scanner
nmap -sS target

# 191. masscan — Fast port scanner
masscan -p80 10.0.0.0/8

# 192. nc — Netcat network utility
nc -l 1234

# 193. socat — Socket relay
socat TCP-LISTEN:8080 TCP:host:80

# 194. telnet — Telnet client
telnet host 80

# 195. ssh — Secure shell
ssh user@host

# 196. scp — Secure copy
scp file user@host:/path

# 197. sftp — Secure FTP
sftp user@host

# 198. rsync — Remote sync
rsync -avz source/ user@host:/dest/

# 199. wget — Web downloader
wget http://example.com/file

# 200. curl — URL transfer tool
curl -O http://example.com/file

# 201. lynx — Text web browser
lynx http://example.com

# 202. w3m — Text web browser
w3m http://example.com

# 203. dig — DNS lookup
dig google.com

# 204. nslookup — DNS lookup
nslookup google.com

# 205. host — DNS lookup
host google.com

# 206. whois — Domain information
whois google.com

# 207. arp — ARP table
arp -a

# 208. route — Routing table
route -n

# 209. iptables — Firewall rules
iptables -L

# 210. ip6tables — IPv6 firewall rules
ip6tables -L

# 211. ufw — Uncomplicated firewall
ufw status

# 212. firewall-cmd — Firewalld management
firewall-cmd --list-all

# 213. tcpdump — Packet capture
tcpdump -i eth0

# 214. wireshark — Network analyzer
wireshark

# 215. tshark — Terminal wireshark
tshark -i eth0

# 216. ettercap — Network sniffer
ettercap -T -M arp

# 217. ngrep — Network grep
ngrep -d eth0 "GET"

# 218. iftop — Network bandwidth monitor
iftop

# 219. nethogs — Network usage by process
nethogs

# 220. vnstat — Network statistics
vnstat -i eth0
7. Package Management (30 commands)
bash


# 221. apt — APT package manager (Debian/Ubuntu)
apt install package

# 222. apt-get — APT package manager
apt-get update

# 223. apt-cache — APT cache management
apt-cache search package

# 224. dpkg — Debian package manager
dpkg -i package.deb

# 225. aptitude — High-level package manager
aptitude search package

# 226. yum — YUM package manager (RHEL/CentOS)
yum install package

# 227. dnf — DNF package manager (Fedora)
dnf install package

# 228. rpm — RPM package manager
rpm -qa

# 229. zypper — openSUSE package manager
zypper install package

# 230. pacman — Arch Linux package manager
pacman -S package

# 231. emerge — Gentoo package manager
emerge package

# 232. portage — Gentoo portage system
portage --sync

# 233. snap — Snap package manager
snap install package

# 234. flatpak — Flatpak package manager
flatpak install package

# 235. appimage — AppImage launcher
./application.appimage

# 236. pip — Python package manager
pip install package

# 237. pip3 — Python 3 package manager
pip3 install package

# 238. gem — Ruby package manager
gem install package

# 239. npm — Node.js package manager
npm install package

# 240. yarn — Alternative Node.js package manager
yarn add package

# 241. composer — PHP package manager
composer install

# 242. cargo — Rust package manager
cargo install package

# 243. go — Go package manager
go get package

# 244. brew — Homebrew package manager
brew install package

# 245. port — MacPorts package manager
port install package

# 246. nix — Nix package manager
nix-env -i package

# 247. guix — GNU Guix package manager
guix install package

# 248. xbps — Void Linux package manager
xbps-install package

# 249. apk — Alpine Linux package manager
apk add package

# 250. pkg — FreeBSD package manager
pkg install package
8. Archive and Compression (25 commands)
bash


# 251. tar — Archive files
tar -czf archive.tar.gz files/

# 252. gzip — Compress files
gzip file.txt

# 253. gunzip — Decompress gzip files
gunzip file.txt.gz

# 254. zcat — View compressed files
zcat file.txt.gz

# 255. bzip2 — Compress files
bzip2 file.txt

# 256. bunzip2 — Decompress bzip2 files
bunzip2 file.txt.bz2

# 257. bzcat — View bzip2 compressed files
bzcat file.txt.bz2

# 258. xz — Compress files
xz file.txt

# 259. unxz — Decompress xz files
unxz file.txt.xz

# 260. xzcat — View xz compressed files
xzcat file.txt.xz

# 261. zip — Create zip archives
zip archive.zip files

# 262. unzip — Extract zip archives
unzip archive.zip

# 263. 7z — 7-Zip archiver
7z a archive.7z files

# 264. rar — RAR archiver
rar a archive.rar files

# 265. unrar — Extract RAR archives
unrar x archive.rar

# 266. ar — Archive utility
ar -t archive.a

# 267. compress — Compress files (LZW)
compress file.txt

# 268. uncompress — Decompress LZW files
uncompress file.txt.Z

# 269. zstd — Zstandard compression
zstd file.txt

# 270. lz4 — LZ4 compression
lz4 file.txt

# 271. lzop — LZO compression
lzop file.txt

# 272. p7zip — 7-Zip for POSIX
7za a archive.7z files

# 273. cabextract — Extract CAB files
cabextract file.cab

# 274. arj — ARJ archiver
arj a archive.arj files

# 275. zoo — Zoo archiver
zoo a archive.zoo files
9. Text Editors (15 commands)
bash


# 276. vi — Vi text editor
vi file.txt

# 277. vim — Vim text editor
vim file.txt

# 278. nvim — Neovim text editor
nvim file.txt

# 279. emacs — Emacs text editor
emacs file.txt

# 280. nano — Nano text editor
nano file.txt

# 281. pico — Pico text editor
pico file.txt

# 282. joe — Joe text editor
joe file.txt

# 283. jed — Jed text editor
jed file.txt

# 284. mcedit — Midnight Commander editor
mcedit file.txt

# 285. gedit — GNOME text editor
gedit file.txt

# 286. kate — KDE text editor
kate file.txt

# 287. sublime — Sublime Text
subl file.txt

# 288. atom — Atom editor
atom file.txt

# 289. code — Visual Studio Code
code file.txt

# 290. ed — Line editor
ed file.txt
10. System Monitoring (30 commands)
bash


# 291. glances — System monitoring tool
glances

# 292. nmon — Performance monitor
nmon

# 293. dstat — System statistics
dstat

# 294. collectl — Performance monitoring
collectl

# 295. sysstat — System statistics package
sysstat

# 296. perf — Performance analysis
perf top

# 297. ftrace — Function tracer
trace-cmd record

# 298. systemtap — System tap
stap script.stp

# 299. dtrace — Dynamic tracing
dtrace -n 'syscall:::entry'

# 300. tcpdump — Network packet analyzer
tcpdump -i any

# 301. netstat — Network connections
netstat -an

# 302. lsof — List open files
lsof -i :80

# 303. fuser — File user identification
fuser -v /path

# 304. watch — Execute commands periodically
watch -n 1 command

# 305. tload — Load average graph
tload

# 306. xload — X11 load monitor
xload

# 307. xclock — X11 clock
xclock

# 308. xeyes — X11 eyes
xeyes

# 309. conky — System monitor
conky

# 310. gkrellm — System monitor
gkrellm

# 311. munin — Network monitoring
munin-node

# 312. nagios — Network monitoring
nagios

# 313. zabbix — Enterprise monitoring
zabbix_agentd

# 314. cacti — Network graphing
cacti

# 315. mrtg — Multi Router Traffic Grapher
mrtg

# 316. rrdtool — Round Robin Database
rrdtool create

# 317. smokeping — Network latency monitor
smokeping

# 318. ntopng — Network traffic monitor
ntopng

# 319. bandwidthd — Bandwidth monitor
bandwidthd

# 320. darkstat — Network statistics
darkstat
11. Disk and Filesystem (35 commands)
bash


# 321. fdisk — Partition tables
fdisk /dev/sda

# 322. parted — Partition editor
parted /dev/sda

# 323. gparted — GUI partition editor
gparted

# 324. cfdisk — Curses-based fdisk
cfdisk /dev/sda

# 325. sfdisk — Script-friendly fdisk
sfdisk /dev/sda

# 326. gdisk — GPT fdisk
gdisk /dev/sda

# 327. sgdisk — Script-friendly gdisk
sgdisk /dev/sda

# 328. mkfs — Make filesystem
mkfs.ext4 /dev/sda1

# 329. mkfs.ext4 — Make ext4 filesystem
mkfs.ext4 /dev/sda1

# 330. mkfs.xfs — Make XFS filesystem
mkfs.xfs /dev/sda1

# 331. mkfs.btrfs — Make Btrfs filesystem
mkfs.btrfs /dev/sda1

# 332. mkfs.ntfs — Make NTFS filesystem
mkfs.ntfs /dev/sda1

# 333. mkfs.vfat — Make FAT filesystem
mkfs.vfat /dev/sda1

# 334. fsck — Filesystem check
fsck /dev/sda1

# 335. e2fsck — ext2/3/4 filesystem check
e2fsck /dev/sda1

# 336. xfs_check — XFS filesystem check
xfs_check /dev/sda1

# 337. btrfs — Btrfs utilities
btrfs filesystem show

# 338. tune2fs — Tune ext2/3/4 filesystems
tune2fs -l /dev/sda1

# 339. resize2fs — Resize ext2/3/4 filesystems
resize2fs /dev/sda1

# 340. xfs_growfs — Grow XFS filesystem
xfs_growfs /mnt

# 341. mount — Mount filesystems
mount /dev/sda1 /mnt

# 342. umount — Unmount filesystems
umount /mnt

# 343. findmnt — Find mounted filesystems
findmnt /

# 344. mountpoint — Check if directory is mountpoint
mountpoint /mnt

# 345. blkid — Block device identification
blkid /dev/sda1

# 346. lsblk — List block devices
lsblk -f

# 347. blockdev — Block device control
blockdev --getsize64 /dev/sda

# 348. hdparm — Hard disk parameters
hdparm -I /dev/sda

# 349. sdparm — SCSI device parameters
sdparm /dev/sda

# 350. smartctl — SMART disk monitoring
smartctl -a /dev/sda

# 351. badblocks — Search for bad blocks
badblocks /dev/sda1

# 352. losetup — Setup loop devices
losetup /dev/loop0 file.img

# 353. cryptsetup — LUKS encryption
cryptsetup luksFormat /dev/sda1

# 354. mdadm — RAID management
mdadm --create /dev/md0

# 355. lvm — Logical Volume Manager
lvm version
12. LVM Commands (15 commands)
bash


# 356. pvcreate — Create physical volume
pvcreate /dev/sda1

# 357. pvdisplay — Display physical volumes
pvdisplay

# 358. pvremove — Remove physical volume
pvremove /dev/sda1

# 359. vgcreate — Create volume group
vgcreate vg0 /dev/sda1

# 360. vgdisplay — Display volume groups
vgdisplay

# 361. vgextend — Extend volume group
vgextend vg0 /dev/sdb1

# 362. vgreduce — Reduce volume group
vgreduce vg0 /dev/sdb1

# 363. vgremove — Remove volume group
vgremove vg0

# 364. lvcreate — Create logical volume
lvcreate -L 10G -n lv0 vg0

# 365. lvdisplay — Display logical volumes
lvdisplay

# 366. lvextend — Extend logical volume
lvextend -L +5G /dev/vg0/lv0

# 367. lvreduce — Reduce logical volume
lvreduce -L -5G /dev/vg0/lv0

# 368. lvremove — Remove logical volume
lvremove /dev/vg0/lv0

# 369. lvresize — Resize logical volume
lvresize -L 15G /dev/vg0/lv0

# 370. lvscan — Scan for logical volumes
lvscan
13. User Management (20 commands)
bash


# 371. useradd — Add user account
useradd -m username

# 372. userdel — Delete user account
userdel -r username

# 373. usermod — Modify user account
usermod -aG group username

# 374. passwd — Change password
passwd username

# 375. chpasswd — Change passwords in batch
chpasswd < file

# 376. pwck — Verify password file integrity
pwck

# 377. grpck — Verify group file integrity
grpck

# 378. groupadd — Add group
groupadd groupname

# 379. groupdel — Delete group
groupdel groupname

# 380. groupmod — Modify group
groupmod -n newname oldname

# 381. gpasswd — Group password administration
gpasswd -a user group

# 382. newusers — Add multiple users
newusers < file

# 383. chfn — Change user information
chfn username

# 384. chsh — Change login shell
chsh -s /bin/bash username

# 385. finger — User information lookup
finger username

# 386. pinky — Lightweight finger
pinky username

# 387. users — Show logged-in users
users

# 388. ac — Login accounting
ac -p

# 389. lastlog — Show last login times
lastlog

# 390. faillog — Display/set login failure records
faillog -u username
14. Scheduling and Automation (15 commands)
bash


# 391. cron — Cron daemon
systemctl status cron

# 392. crontab — Schedule tasks
crontab -e

# 393. at — Schedule one-time tasks
at now + 1 hour

# 394. atq — List scheduled at jobs
atq

# 395. atrm — Remove at jobs
atrm jobnumber

# 396. batch — Execute jobs when load permits
batch

# 397. anacron — Run periodic jobs
anacron -T

# 398. systemd-run — Run transient services
systemd-run --on-calendar=daily command

# 399. fcron — Feature-rich cron
fcrontab -e

# 400. dcron — Dillon's cron
dcron

# 401. cronie — Cronie cron daemon
cronie

# 402. incron — Inotify cron
incrontab -e

# 403. systemd-timer — Systemd timers
systemctl list-timers

# 404. run-parts — Run scripts in directory
run-parts /etc/cron.daily

# 405. chronic — Run commands quietly
chronic command
15. Security and Encryption (20 commands)
bash


# 406. gpg — GNU Privacy Guard
gpg --encrypt file

# 407. openssl — SSL/TLS toolkit
openssl genrsa -out key.pem 2048

# 408. ssh-keygen — Generate SSH keys
ssh-keygen -t rsa -b 4096

# 409. ssh-copy-id — Copy SSH public key
ssh-copy-id user@host

# 410. ssh-agent — SSH authentication agent
ssh-agent bash

# 411. ssh-add — Add keys to SSH agent
ssh-add ~/.ssh/id_rsa

# 412. keychain — SSH key manager
keychain ~/.ssh/id_rsa

# 413. seahorse — GNOME keyring manager
seahorse

# 414. kleopatra — KDE certificate manager
kleopatra

# 415. shred — Securely delete files
shred -vfz -n 3 file

# 416. wipe — Secure file deletion
wipe -rf directory

# 417. srm — Secure remove
srm file

# 418. steghide — Steganography tool
steghide embed -cf image.jpg -ef secret.txt

# 419. john — Password cracker
john --wordlist=dict.txt hashes.txt

# 420. hashcat — Advanced password recovery
hashcat -m 0 hashes.txt wordlist.txt

# 421. ncrack — Network authentication cracker
ncrack -p 22 target

# 422. hydra — Login cracker
hydra -l user -P passwords.txt ssh://target

# 423. nikto — Web vulnerability scanner
nikto -h http://target

# 424. lynis — Security auditing tool
lynis audit system

# 425. rkhunter — Rootkit hunter
rkhunter --check
16. Development Tools (25 commands)
bash


# 426. gcc — GNU C compiler
gcc -o program source.c

# 427. g++ — GNU C++ compiler
g++ -o program source.cpp

# 428. make — Build automation tool
make

# 429. cmake — Cross-platform make
cmake .

# 430. autoconf — Generate configure scripts
autoconf

# 431. automake — Generate Makefile.in
automake

# 432. libtool — Generic library support
libtool --mode=compile gcc -c source.c

# 433. pkg-config — Library compile/link flags
pkg-config --cflags gtk+-3.0

# 434. gdb — GNU debugger
gdb program

# 435. valgrind — Memory error detector
valgrind ./program

# 436. strace — System call tracer
strace ./program

# 437. objdump — Display object file information
objdump -d program

# 438. nm — List symbols from object files
nm program

# 439. strip — Remove symbols from object files
strip program

# 440. ldd — Print shared library dependencies
ldd program

# 441. ldconfig — Configure dynamic linker
ldconfig

# 442. ar — Create/modify archives
ar rcs libname.a object.o

# 443. ranlib — Generate archive index
ranlib libname.a

# 444. readelf — Display ELF file information
readelf -h program

# 445. hexedit — Binary file editor
hexedit file

# 446. bless — GUI hex editor
bless file

# 447. ghex — GNOME hex editor
ghex file

# 448. okteta — KDE hex editor
okteta file

# 449. xxd — Hex dump utility
xxd file

# 450. od — Octal dump
od -x file
17. Miscellaneous Utilities (25 commands)
bash


# 451. cal — Display calendar
cal

# 452. date — Display/set date
date

# 453. timedatectl — Control system time
timedatectl status

# 454. hwclock — Hardware clock utility
hwclock --show

# 455. ntpdate — Set date via NTP
ntpdate pool.ntp.org

# 456. chrony — NTP client/server
chronyc sources

# 457. bc — Calculator
echo "2+2" | bc

# 458. dc — Desk calculator
echo "2 2 + p" | dc

# 459. factor — Factor numbers
factor 12

# 460. seq — Generate sequences
seq 1 10

# 461. shuf — Shuffle lines
shuf file.txt

# 462. random — Generate random numbers
echo $RANDOM

# 463. fortune — Display random quotes
fortune

# 464. cowsay — ASCII cow speech
cowsay "Hello"

# 465. figlet — ASCII art text
figlet "Hello"

# 466. banner — Print large text
banner "Hello"

# 467. toilet — Colored ASCII art text
toilet "Hello"

# 468. sl — Steam locomotive
sl

# 469. cmatrix — Matrix screen effect
cmatrix

# 470. hollywood — Hacker terminal effect
hollywood

# 471. asciiquarium — ASCII aquarium
asciiquarium

# 472. bb — ASCII art demo
bb

# 473. aafire — ASCII fire animation
aafire

# 474. cacafire — Colored ASCII fire
cacafire

# 475. oneko — Cat chases mouse cursor
oneko
18. Final System Commands (25 commands)
bash


# 476. init — Process control initialization
init 6

# 477. telinit — Change runlevel
telinit 3

# 478. runlevel — Show current runlevel
runlevel

# 479. shutdown — Shutdown system
shutdown -h now

# 480. halt — Halt the system
halt

# 481. poweroff — Power off system
poweroff

# 482. reboot — Restart system
reboot

# 483. wall — Send message to all users
wall "System maintenance"

# 484. write — Send message to user
write username

# 485. mesg — Control write access
mesg y

# 486. talk — Talk to another user
talk username

# 487. ytalk — Enhanced talk
ytalk username

# 488. screen — Terminal multiplexer
screen -S session

# 489. byobu — Enhanced screen/tmux
byobu

# 490. script — Record terminal session
script session.log

# 491. scriptreplay — Replay terminal session
scriptreplay session.log

# 492. asciinema — Record terminal sessions
asciinema rec

# 493. ttyrec — Record terminal
ttyrec session.tty

# 494. ttyplay — Play terminal recordings
ttyplay session.tty

# 495. expect — Automate interactive programs
expect script.exp

# 496. dialog — Display dialog boxes
dialog --msgbox "Hello" 10 30

# 497. whiptail — Display dialog boxes
whiptail --msgbox "Hello" 10 30

# 498. zenity — GNOME dialog tool
zenity --info --text="Hello"

# 499. kdialog — KDE dialog tool
kdialog --msgbox "Hello"

# 500. xmessage — X11 message display
xmessage "Hello"