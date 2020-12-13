## Question 1. Describe each member and which part each member participated in
	1. Deepa = Modifying the kernel by identifying not implemented exit reasons in kvm.
	2. Jae Woong = Modifying the kernel to add new leaf function to count exits and test code.

## Question 2. Steps:
NOTE: If building directly from this repo, please rename the cloned git folder to “linux” before executing make.
Create a VM on Google Cloud. (used ubuntu-1804 image)
Apply a special license file to enable nested VM.

```
gcloud compute images create nested-vm-image-2 \
  --source-disk disk2 --source-disk-zone us-west2-b \
  --licenses "https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
```
Then create a VM using this image

```
gcloud compute instances create example-nested-vm --zone us-west2-b \
              --min-cpu-platform "Intel Haswell" \
              	--image nested-vm-image-2
```                

Download linux
```
git clone https://github.com/torvalds/linux.git
```

Check the version
```
root@kernelexp:~# uname -a
Linux example-nested-vm 5.4.0-1028-gcp #29~18.04.1-Ubuntu SMP Mon Oct 5 16:41:43 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```
Make and build the new kernel

```
cd linux
apt-get install fakeroot libncurses5-dev libssl-dev ccache bison flex libelf-dev bc

make menuconfig

make && make modules && make install && make modules_install

sudo reboot
```

Check the version, it should show the new kernel version
```
# uname -a
Linux example-nested-vm 5.10.0-rc1+ #1 SMP Thu Oct 29 16:39:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

Install vncserver to create a nested vm using virt manager. Instructions followed from this blog:

http://leadtosilverlining.blogspot.com/2019/01/setup-desktop-environment-on-google.html

Install virtmanager and create nested VM: 
```
sudo apt-get install virt-manager 
sudo apt-get install libvirt-bin libvirt-doc 
sudo apt-get install qemu-system 
```

Prepare the nested VM by downloading Ubuntu 18.04 iso. 

Start a new VM with the image, following all the prompts to set up the VM. With 1 vCPU, 2G memory, 15G disk.

Modify the kernel code in cpuid.c and vmx.c

Then test your code by running
```
sudo virsh shutdown ubuntu18.04
sudo rmmod kvm_intel
sudo rmmod kvm
sudo make SUBDIRS=arch/x86/kvm
sudo insmod arch/x86/kvm/kvm.ko
sudo insmod arch/x86/kvm/kvm-intel.ko
sudo virsh start ubuntu18.04
```
   
   12-1) or compile the whole kernel using “make” sequence, and reboot


 Launch a nested VM inside the VM
VMWorkstation for linux, virt manager etc.
(Make sure nested VM and enable VT again)


 Copy & Paste your test file inside the nested VM
The test file measures information inside eax, ebx and ecx


 Compile the test file with gcc, and execute
 ```
gcc -o test_assignment3 test.c
./test_assignment3 <param>
```
where param is the exit type you want to check

## Question 3: Does the number of exits increase at a stable rate? Or are there more exits performed during certain VM operations?  Approximately how many exits does a full VM boot entail?
 Does the number of exits increase at a stable rate? Or are there more exits performed during certain VM operations?
= It depends. Some VM operations may trigger more entries or exits, e.g. operation related to I/O, receiving and sending network packets and CPUID. These typically may invoke more exits for Page Fault etc. CPUID is seen here because we are explicitly calling CPUID for different exit reasons.
Approximately how many exits does a full VM boot entail?
For this question, we use the same program as for assignment 2.
= We can figure out by subtracting the total number of exits after boot by before boot
Number of exits before boot = 3232137 After boot = 3647809 It’s about 400,000 exits. . Some exits can be included for waiting while taking pictures, and shutdown, bootup etc.

## Question 4: Of the exit types defined in the SDM, which are the most frequent? Least?
Most frequent: EXIT_REASON_IO_INSTRUCTION, EXIT_REASON_CPUID 
Least Frequent: EXIT_REASON_APIC_ACCESS, EXIT_REASON_DR_ACCESS
 
