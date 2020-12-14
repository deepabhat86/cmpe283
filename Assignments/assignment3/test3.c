#include <stdio.h>
#include <stdlib.h>

void trig_cpuid(unsigned int* eax, unsigned int* ebx, unsigned int* ecx, unsigned int* edx) {
asm volatile("cpuid"
: "=a" (*eax),
  "=b" (*ebx),
  "=c" (*ecx),
  "=d" (*edx)
: "0" (*eax), "2" (*ecx) );
}

int main(int argc, char **argv) {
unsigned int eax, ebx, ecx, edx;

for(int i=0;i<70;i++){
//ecx = atoi(argv[1]);
	ecx=i;
	eax = 0x4FFFFFFE;
	
trig_cpuid(&eax, &ebx, &ecx, &edx);
if(edx=0xFFFFFFFF)
	printf("CPUID: The exit number %d, is not supported\n");
else if(eax==0&&ebx==0&&ecx==0&&edx==0)
	printf("The exit number %d is not supported in kvm\n",i);
else
printf("CPUID(0X4FFFFFFE) The exit Number: %d, exits = %d\n", i, eax);
}