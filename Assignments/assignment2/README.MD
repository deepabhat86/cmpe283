# Question 1. Describe each member and which part each member participated in
	1. Deepa = Modifying the kernel
	2. Jae Woong = Test the kernel

# Question 2. Steps:
1. Create a VM on Google Cloud. (used ubuntu-1804 image)
2. Apply a special license file to enable nested VM.
```
	gcloud compute images create nested-vm-image-2 \
	--source-disk disk2 --source-disk-zone us-west2-b \
  	--licenses "https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
```

3. Then create a VM using this image

```
gcloud compute instances create example-nested-vm --zone us-west2-b \
              --min-cpu-platform "Intel Haswell" \
              	--image nested-vm-image-2
```

4. Launch that VM and Download linux
```
git clone https://github.com/torvalds/linux.git
```

5. Check the version first
```
root@kernelexp:~# uname -a
Linux example-nested-vm 5.4.0-1028-gcp #29~18.04.1-Ubuntu SMP Mon Oct 5 16:41:43 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

6. Make and build the new kernel
```
cd linux
apt-get install fakeroot libncurses5-dev libssl-dev ccache bison flex libelf-dev bc
make menuconfig
make && make modules && make install && make modules_install
sudo reboot
```

7. Check the version, it should show the new kernel version
```
> uname -a
Linux example-nested-vm 5.10.0-rc1+ #1 SMP Thu Oct 29 16:39:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```
8. Install vncserver to create a nested vm using virt manager. Instructions followed from this blog:
```
http://leadtosilverlining.blogspot.com/2019/01/setup-desktop-environment-on-google.html
```
9. Install virtmanager and create nested VM: 
```
sudo apt-get install virt-manager 
sudo apt-get install libvirt-bin libvirt-doc 
sudo apt-get install qemu-system 
Prepare the nested VM by downloading Ubuntu 18.04 iso. 
Start a new VM with the image, following all the prompts to set up the VM. With 1 vCPU, 2G memory, 15G disk.
```

10. Modify the kernel code in cpuid.c and vmx.c
```
To count the number of exits, define an atomic_t variable and initialize it as zero in cpuid.c. The reason for atomic is to ensure thread safety. 
Then modify the kvm_emulate_cpuid function in cpuid.c to store and calculate the counter and time spent processing the exits.
Whenever cpuid function is called, increment this counter by 1 in vmx.c.
For calculating time spent ,make use of rdtsc () function to have initial and ending time and then subtract it. This is done in vmx.c
```
11. Then test this code by removing and inserting the kernel module. You also need the test program listed below to run inside the nested VM.
```
sudo virsh shutdown ubuntu18.04
sudo rmmod kvm_intel
sudo rmmod kvm
sudo make SUBDIRS=arch/x86/kvm
sudo insmod arch/x86/kvm/kvm.ko
sudo insmod arch/x86/kvm/kvm-intel.ko
sudo virsh start ubuntu18.04
```

12. Copy & Paste your test file inside the nested VM
> The test file measures information inside eax, ebx and ecx

13. Compile the test file with gcc, and execute
```
gcc -o test_assignment2 test.c
./test_assignment2
```

# Question 3: Does the number of exits increase at a stable rate? Or are there more exits performed during certain VM operations?  Approximately how many exits does a full VM boot entail?
1. Does the number of exits increase at a stable rate? Or are there more exits performed during certain VM operations?
> It depends. Some VM operations may trigger more entries or exits, e.g. operation related to I/O, receiving and sending network packets. These typically may invoke more exits for Page Fault etc.
2. Approximately how many exits does a full VM boot entail?
> We can figure out by subtracting the total number of exits after boot by before boot. Number of exits before boot = 3232137 After boot = 3647809 It’s about 400,000 exits. Some exits can be included for waiting while taking pictures, and shutdown, bootup etc.

