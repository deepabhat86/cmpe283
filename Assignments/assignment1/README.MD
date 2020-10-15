# Questions
1. For each member in your team, provide 1 paragraph detailing what parts of the lab that member
implemented / researched. (You may skip this question if you are doing the lab by yourself).
  1. Deepa Vyasabhat: Added code for procbased and secondary procbased vm controls.
  2. Jaewoong Lee: Added code for Entry and Exit vm controls.


2. Describe in detail the steps you used to complete the assignment. Consider your reader to be someone
skilled in software development but otherwise unfamiliar with the assignment. Good answers to this
question will be recipes that someone can follow to reproduce your development steps.
Note: I may decide to follow these instructions for random assignments, so you should make sure
they are accurate.

1) Installed VMware Fusion on Mac
2) Created a Ubuntu server (64 bit) VM.
3) Set the "Enable Hypervisor applications in this virtual machine" option in Processor settings in Vmware Fusion.
4) Clone the repo.
5) Make changes to the code.
6) Run make
```
sudo insmod cmpe283-1.ko
dmesg
```

# Related Commands
- `cat /proc/cpuinfo | more `
- `dmesg`
- `insmod ./YOUR_COMPILED_KERNEL.ko`
- `rmmod YOUR_COMPILED_KERNEL`

# Sample Output
```
[ 6295.279020] CMPE 283 Assignment 1 Module Start
[ 6295.279022] Pinbased Controls MSR: 0x3f00000016
[ 6295.279022]   External Interrupt Exiting: Can set=Yes, Can clear=Yes
[ 6295.279023]   NMI Exiting: Can set=Yes, Can clear=Yes
[ 6295.279023]   Virtual NMIs: Can set=Yes, Can clear=Yes
[ 6295.279024]   Activate VMX Preemption Timer: Can set=No, Can clear=Yes
[ 6295.279024]   Process Posted Interrupts: Can set=No, Can clear=Yes
[ 6295.279025] Exit Controls MSR: 0x3fffff00036dff
[ 6295.279026]   Save Debug Controls: Can set=Yes, Can clear=No
[ 6295.279026]   Host address-space size: Can set=Yes, Can clear=Yes
[ 6295.279027]   Load IA32_PERF_GLOBAL_CTRL: Can set=Yes, Can clear=Yes
[ 6295.279027]   Acknowledge interrupt on exit: Can set=Yes, Can clear=Yes
[ 6295.279028]   Save IA32_PAT: Can set=Yes, Can clear=Yes
[ 6295.279028]   Load IA32_PAT: Can set=Yes, Can clear=Yes
[ 6295.279029]   Save IA32_EFER: Can set=Yes, Can clear=Yes
[ 6295.279029]   Load IA32_EFER: Can set=Yes, Can clear=Yes
[ 6295.279029]   Save VMX-preemption timer value: Can set=No, Can clear=Yes
[ 6295.279030]   Clear IA32_BNDCFGS: Can set=No, Can clear=Yes
[ 6295.279030]   Conceal VMX from PT: Can set=No, Can clear=Yes
[ 6295.279031]   Clear IA32_RTIT_CTL: Can set=No, Can clear=Yes
[ 6295.279031]   Load CET state: Can set=No, Can clear=Yes
[ 6295.279032]   Load PKRS: Can set=No, Can clear=Yes
[ 6295.279032] Entry Controls MSR: 0xf3ff000011ff
[ 6295.279033]   Load Debug Controls: Can set=Yes, Can clear=No
[ 6295.279033]   IA-32e mode guest: Can set=Yes, Can clear=Yes
[ 6295.279034]   Entry to SMM: Can set=No, Can clear=Yes
[ 6295.279034]   Deactivate dual-monitor treatment: Can set=No, Can clear=Yes
[ 6295.279035]   Load IA32_PERF_GLOBAL_CTRL: Can set=Yes, Can clear=Yes
[ 6295.279035]   Load IA32_PAT: Can set=Yes, Can clear=Yes
[ 6295.279036]   Load IA32_EFER: Can set=Yes, Can clear=Yes
[ 6295.279036]   Load IA32_BNDCFGS: Can set=No, Can clear=Yes
[ 6295.279037]   Conceal VMX from PT: Can set=No, Can clear=Yes
[ 6295.279037]   Load IA32_RTIT_CTL: Can set=No, Can clear=Yes
[ 6295.279037]   Load CET state: Can set=No, Can clear=Yes
[ 6295.279038]   Load PKRS: Can set=No, Can clear=Yes
[ 6295.279038]   Save Debug Controls: Can set=Yes, Can clear=No
[ 6295.279039]   Host address-space size: Can set=Yes, Can clear=Yes
[ 6295.279040] Procbased Controls MSR: 0xfff9fffe0401e172
[ 6295.279040]   Interrupt-window exiting: Can set=Yes, Can clear=Yes
[ 6295.279040]   Use TSC offsetting: Can set=Yes, Can clear=Yes
[ 6295.279041]   HLT exiting: Can set=Yes, Can clear=Yes
[ 6295.279041]   INVLPG exiting: Can set=Yes, Can clear=Yes
[ 6295.279042]   MWAIT exiting: Can set=Yes, Can clear=Yes
[ 6295.279042]   RDPMC exiting: Can set=Yes, Can clear=Yes
[ 6295.279043]   RDTSC exiting: Can set=Yes, Can clear=Yes
[ 6295.279043]   CR3-load exiting: Can set=Yes, Can clear=No
[ 6295.279043]   CR3-store exiting: Can set=Yes, Can clear=No
[ 6295.279044]   CR8-load exiting: Can set=Yes, Can clear=Yes
[ 6295.279044]   CR8-store exiting: Can set=Yes, Can clear=Yes
[ 6295.279045]   Use TPR shadow: Can set=Yes, Can clear=Yes
[ 6295.279045]   NMI-window exiting: Can set=Yes, Can clear=Yes
[ 6295.279045]   MOV-DR exiting: Can set=Yes, Can clear=Yes
[ 6295.279046]   Unconditional I/O exiting: Can set=Yes, Can clear=Yes
[ 6295.279046]   Use I/O bitmaps: Can set=Yes, Can clear=Yes
[ 6295.279047]   Monitor trap flag: Can set=Yes, Can clear=Yes
[ 6295.279047]   MONITOR exiting: Can set=Yes, Can clear=Yes
[ 6295.279048]   PAUSE exiting: Can set=Yes, Can clear=Yes
[ 6295.279048]   Activate secondary controls: Can set=Yes, Can clear=Yes
[ 6295.279049] Secondary Procbased Controls MSR: 0x553cfe00000000
[ 6295.279050]   Virtualize APIC accesses: Can set=No, Can clear=Yes
[ 6295.279050]   Enable EPT: Can set=Yes, Can clear=Yes
[ 6295.279051]   Descriptor-table exiting: Can set=Yes, Can clear=Yes
[ 6295.279051]   Enable RDTSCP: Can set=Yes, Can clear=Yes
[ 6295.279051]   Virtualize x2APIC mode: Can set=Yes, Can clear=Yes
[ 6295.279052]   Enable VPID: Can set=Yes, Can clear=Yes
[ 6295.279052]   WBINVD exiting: Can set=Yes, Can clear=Yes
[ 6295.279053]   Unrestricted guest: Can set=Yes, Can clear=Yes
[ 6295.279053]   APIC-register virtualization: Can set=No, Can clear=Yes
[ 6295.279054]   Virtual-interrupt delivery: Can set=No, Can clear=Yes
[ 6295.279054]   PAUSE-loop exiting: Can set=Yes, Can clear=Yes
[ 6295.279054]   RDRAND exiting: Can set=Yes, Can clear=Yes
[ 6295.279055]   Enable INVPCID: Can set=Yes, Can clear=Yes
[ 6295.279055]   Enable VM functions: Can set=Yes, Can clear=Yes
[ 6295.279056]   VMCS shadowing: Can set=No, Can clear=Yes
[ 6295.279056]   Enable ENCLS exiting: Can set=No, Can clear=Yes
[ 6295.279056]   RDSEED exiting: Can set=Yes, Can clear=Yes
[ 6295.279057]   Enable PML: Can set=No, Can clear=Yes
[ 6295.279057]   EPT-violation #VE: Can set=Yes, Can clear=Yes
[ 6295.279058]   Conceal VMX from PT: Can set=No, Can clear=Yes
[ 6295.279058]   Enable XSAVES/XRSTORS: Can set=Yes, Can clear=Yes
[ 6295.279059]   Mode-based execute control for EPT: Can set=Yes, Can clear=Yes
[ 6295.279059]   Sub-page write permissions for EPT: Can set=No, Can clear=Yes
[ 6295.279060]   Intel PT uses guest physical addresses: Can set=No, Can clear=Yes
[ 6295.279060]   Use TSC scaling: Can set=No, Can clear=Yes
[ 6295.279060]   Enable user wait and pause: Can set=No, Can clear=Yes
[ 6295.279061]   Enable ENCLV exiting: Can set=No, Can clear=Yes
[10539.990650] CMPE 283 Assignment 1 Module Exits
[10556.823945] CMPE 283 Assignment 1 Module Start
[10556.823948] Pinbased Controls MSR: 0x3f00000016
[10556.823949]   External Interrupt Exiting: Can set=Yes, Can clear=Yes
[10556.823950]   NMI Exiting: Can set=Yes, Can clear=Yes
[10556.823950]   Virtual NMIs: Can set=Yes, Can clear=Yes
[10556.823951]   Activate VMX Preemption Timer: Can set=No, Can clear=Yes
[10556.823951]   Process Posted Interrupts: Can set=No, Can clear=Yes
[10556.823952] Exit Controls MSR: 0x3fffff00036dff
[10556.823953]   Save Debug Controls: Can set=Yes, Can clear=No
[10556.823953]   Host address-space size: Can set=Yes, Can clear=Yes
[10556.823954]   Load IA32_PERF_GLOBAL_CTRL: Can set=Yes, Can clear=Yes
[10556.823954]   Acknowledge interrupt on exit: Can set=Yes, Can clear=Yes
[10556.823955]   Save IA32_PAT: Can set=Yes, Can clear=Yes
[10556.823955]   Load IA32_PAT: Can set=Yes, Can clear=Yes
[10556.823956]   Save IA32_EFER: Can set=Yes, Can clear=Yes
[10556.823956]   Load IA32_EFER: Can set=Yes, Can clear=Yes
[10556.823957]   Save VMX-preemption timer value: Can set=No, Can clear=Yes
[10556.823957]   Clear IA32_BNDCFGS: Can set=No, Can clear=Yes
[10556.823958]   Conceal VMX from PT: Can set=No, Can clear=Yes
[10556.823958]   Clear IA32_RTIT_CTL: Can set=No, Can clear=Yes
[10556.823959]   Load CET state: Can set=No, Can clear=Yes
[10556.823959]   Load PKRS: Can set=No, Can clear=Yes
[10556.823960] Entry Controls MSR: 0xf3ff000011ff
[10556.823961]   Load Debug Controls: Can set=Yes, Can clear=No
[10556.823961]   IA-32e mode guest: Can set=Yes, Can clear=Yes
[10556.823962]   Entry to SMM: Can set=No, Can clear=Yes
[10556.823962]   Deactivate dual-monitor treatment: Can set=No, Can clear=Yes
[10556.823963]   Load IA32_PERF_GLOBAL_CTRL: Can set=Yes, Can clear=Yes
[10556.823963]   Load IA32_PAT: Can set=Yes, Can clear=Yes
[10556.823964]   Load IA32_EFER: Can set=Yes, Can clear=Yes
[10556.823964]   Load IA32_BNDCFGS: Can set=No, Can clear=Yes
[10556.823965]   Conceal VMX from PT: Can set=No, Can clear=Yes
[10556.823965]   Load IA32_RTIT_CTL: Can set=No, Can clear=Yes
[10556.823966]   Load CET state: Can set=No, Can clear=Yes
[10556.823966]   Load PKRS: Can set=No, Can clear=Yes
[10556.823967]   Save Debug Controls: Can set=Yes, Can clear=No
[10556.823967]   Host address-space size: Can set=Yes, Can clear=Yes
[10556.823968] Procbased Controls MSR: 0xfff9fffe0401e172
[10556.823969]   Interrupt-window exiting: Can set=Yes, Can clear=Yes
[10556.823969]   Use TSC offsetting: Can set=Yes, Can clear=Yes
[10556.823970]   HLT exiting: Can set=Yes, Can clear=Yes
[10556.823970]   INVLPG exiting: Can set=Yes, Can clear=Yes
[10556.823971]   MWAIT exiting: Can set=Yes, Can clear=Yes
[10556.823971]   RDPMC exiting: Can set=Yes, Can clear=Yes
[10556.823971]   RDTSC exiting: Can set=Yes, Can clear=Yes
[10556.823972]   CR3-load exiting: Can set=Yes, Can clear=No
[10556.823972]   CR3-store exiting: Can set=Yes, Can clear=No
[10556.823973]   CR8-load exiting: Can set=Yes, Can clear=Yes
[10556.823973]   CR8-store exiting: Can set=Yes, Can clear=Yes
[10556.823974]   Use TPR shadow: Can set=Yes, Can clear=Yes
[10556.823974]   NMI-window exiting: Can set=Yes, Can clear=Yes
[10556.823975]   MOV-DR exiting: Can set=Yes, Can clear=Yes
[10556.823975]   Unconditional I/O exiting: Can set=Yes, Can clear=Yes
[10556.823976]   Use I/O bitmaps: Can set=Yes, Can clear=Yes
[10556.823976]   Monitor trap flag: Can set=Yes, Can clear=Yes
[10556.823977]   Use MSR bitmaps: Can set=Yes, Can clear=Yes
[10556.823977]   MONITOR exiting: Can set=Yes, Can clear=Yes
[10556.823978]   PAUSE exiting: Can set=Yes, Can clear=Yes
[10556.823978]   Activate secondary controls: Can set=Yes, Can clear=Yes
[10556.823979] Secondary Procbased Controls MSR: 0x553cfe00000000
[10556.823980]   Virtualize APIC accesses: Can set=No, Can clear=Yes
[10556.823980]   Enable EPT: Can set=Yes, Can clear=Yes
[10556.823981]   Descriptor-table exiting: Can set=Yes, Can clear=Yes
[10556.823981]   Enable RDTSCP: Can set=Yes, Can clear=Yes
[10556.823982]   Virtualize x2APIC mode: Can set=Yes, Can clear=Yes
[10556.823982]   Enable VPID: Can set=Yes, Can clear=Yes
[10556.823982]   WBINVD exiting: Can set=Yes, Can clear=Yes
[10556.823983]   Unrestricted guest: Can set=Yes, Can clear=Yes
[10556.823983]   APIC-register virtualization: Can set=No, Can clear=Yes
[10556.823984]   Virtual-interrupt delivery: Can set=No, Can clear=Yes
[10556.823984]   PAUSE-loop exiting: Can set=Yes, Can clear=Yes
[10556.823985]   RDRAND exiting: Can set=Yes, Can clear=Yes
[10556.823985]   Enable INVPCID: Can set=Yes, Can clear=Yes
[10556.823986]   Enable VM functions: Can set=Yes, Can clear=Yes
[10556.823986]   VMCS shadowing: Can set=No, Can clear=Yes
[10556.823987]   Enable ENCLS exiting: Can set=No, Can clear=Yes
[10556.823987]   RDSEED exiting: Can set=Yes, Can clear=Yes
[10556.823988]   Enable PML: Can set=No, Can clear=Yes
[10556.823988]   EPT-violation #VE: Can set=Yes, Can clear=Yes
[10556.823989]   Conceal VMX from PT: Can set=No, Can clear=Yes
[10556.823989]   Enable XSAVES/XRSTORS: Can set=Yes, Can clear=Yes
[10556.823990]   Mode-based execute control for EPT: Can set=Yes, Can clear=Yes
[10556.823990]   Sub-page write permissions for EPT: Can set=No, Can clear=Yes
[10556.823991]   Intel PT uses guest physical addresses: Can set=No, Can clear=Yes
[10556.823991]   Use TSC scaling: Can set=No, Can clear=Yes
[10556.823992]   Enable user wait and pause: Can set=No, Can clear=Yes
[10556.823992]   Enable ENCLV exiting: Can set=No, Can clear=Yes
```
