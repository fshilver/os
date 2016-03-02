
Kernel Compile
====

OS version : CentOS 6.7
kernel version : 2.6.32-573.18.1

1. Download the kernel source rpm
	```bash
	$ wget http://vault.centos.org/6.7/updates/Source/SPackages/kernel-2.6.32-573.18.1.el6.src.rpm 
	```
	
2. Prepare for compiling
	```bash
	$ rpm -ivh asciidoc-8.4.5-4.1.el6.noarch.rpm
	$ rpm -ivh xmlto-0.0.23-3.el6.x86_64.rpm
	$ rpm -ivh slang-devel-2.2.1-1.el6.x86_64.rpm
	$ rpm -ivh newt-devel-0.52.11-3.el6.x86_64.rpm
	```

3. Installing kernel source rpm
	```bash
	$ rpm -ivh kernel-2.6.32-573.18.1.el6.src.rpm
	```

4. Compiling %pre% section
	```bash
	$ cd ~/rpmbuild/SPECS/
	$ rpmbuild -bp --target=`uname -m` kernel.spec
	```

5. Changing kernel options
	```bash
	$ cd ~/rpmbuild/BUILD/kernel-2.6.32-573.18.1.el6/linux-2.6.32-573.18.1.el6.x86_64
	$ cp configs/kernel-2.6.32-x86_64.config .config
	$ make menuconfig
	```
	- General Setup
		- Kernel .config support
			- Enable access to .config through /proc/config.gz
	- Enable the block layer
		- IO Schedulers
			- Default I/O Scheduler
				- Deadline
	- Processor type and features
		- Tickless System(Dynamic Ticks)
		- High Reolution Timer Support
		- Preemption Model
			- No Forced Preemption (Server)
	- File systems
		- XFS filesystem support
			- XFS Realtime subvolume
			- XFS Debugging support 

6. Copying .config file
	```bash
	$ cp .config configs/kernel-2.6.32-x86_64.config
	$ vim configs/kernel-2.6.32-x86_64.config
	# x86_64
	$ cp configs/kernel-2.6.32-x86_64.config ../../../SOURCES/
	$ cd ~/rpmbuild/SPECS/
	$ vim kernel.spec
	# change below line
	# from ( 928 line )
	cp $RPM_SOURCE_DIR/config-* .
	# to
	cp $RPM_SOURCE_DIR/kernel-*.config .
	
	# comment below line ( 932 line )
	make -f %{SOURCE20} VERSION=%{version} configs
	```
	
7.  Compling kernel
	```bash
	$ rpmbuild --bb --target=`uname -m` kernel.spec --with baseonly --without xen
	$ rpmbuild --bb --target=noarch kernel.spec --with firmware --without xen
	```

8. Updating rpms for kernel update
	```bash
	$ rpm -Uvh dracut-004-388.el6.noarch.rpm --nodeps
	$ rpm -Uvh dracut-kernel-004-388.el6.noarch.rpm
	$ rpm -Uvh bfa-firmware-3.2.23.0-2.el6.noarch.rpm 
	```
	
9. Updating kernel
	```bash
	$ cd ~/rpmbuild/RPMS/noarch/ 
	$ rpm -Uvh kernel-firmware-2.6.32-573.18.1.el6.noarch.rpm
	$ cd ~/rpmbuild/RPMS/x86_64/
	$ rpm -Uvh kernel-2.6.32-573.18.1.el6.x86_64.rpm
	$ rpm -Uvh kernel-devel-2.6.32-573.18.1.el6.x86_64.rpm	
	```
	





