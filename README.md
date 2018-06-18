### Ly - ncurses display manager - v0.0.1

![ly screenshot](https://cloud.githubusercontent.com/assets/5473047/26368771/ef4aa91a-3ff2-11e7-8f3e-1b3e3ea67e49.png "ly on st")

### Ly debian fork
Thanks for cylgom's work! To make ly work for debian, I did some small changes to the code:   
1. make `launch_xorg` always using `xinit` to start the x session   
Because lots of work have been done by debian to fit the daily use of 
regular xsessions, such as gnome, i3wm, awesome, kde. Start xsessions using xinit will call all these scripts in /etc/X11/Xsession.d/. We have
no necessity to do it by hands. 
2. create a mkdeb.sh to compile and package a deb for us.
3. some lib path fix for debian

---

This is a lightweight login/display manager for linux made with ncurses.
It is based on linux-pam and systemd and was developped in good old C99.
This program was designed to be simple, modular and highly configurable.
Ly was made for crazy people. If you're not insane, run away.

### Configuration and installation
Ly tries not to reinvent the wheel and uses linux-utils and xorg-xinit
instead of providing heavy, incomplete and outdated implementations.
Make sure all the following tools and libraries are available on your
distribution before going further:
- make
- a c99 compiler
- systemd
- linux-pam
- ncurses
- tput
- libX11 (required if you wish to use X)
- xorg-xinit (required if you wish to use X)
- xorg-xauth (required if you wish to use X)
- mcookie (required if you wish to use X)

You can now configure Ly by editing "src/config.h". Modify "ly.service"
as well if you changed the default tty, then build the executable:
```
make
```
Check if it works on the tty you configured (default is tty2). You can
also run it in terminal emulators, but desktop environments won't start.
```
sudo build/ly
```
Then, install Ly and the systemd service file:
```
sudo make install
```
Now enable the systemd service to make it spawn on startup:
```
sudo systemctl enable ly.service
```
If you need to switch between ttys after Ly's start you also have to
disable getty on Ly's tty to prevent "login" from spawning on top of it:
```
sudo systemctl disable getty@tty2.service
```
If messages from other services pops-up over the login prompt, you have to edit the service in order to run it last. In order to do this, simply edit the following file:
```
/usr/lib/systemd/system/ly.service
```
Just under the "After getty", add another one with your last-launching service. Example on my computer:
```
After=tlp.service
```

### Controls
Use the up and down arrow keys to change the current field, and the
left and right arrow keys to change the target desktop environment
while on the desktop field (above the username field).

### Additionnal informations
The name "Ly" is a tribute to the fairy from the game Rayman.
Ly was tested by oxodao, who is some seriously awesome dude. (you rock!)
I wish to thank ncurses, linux-pam, X11 and systemd developers for not
providing anything close to a reference or documentation.
