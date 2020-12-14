#include <stdio.h>

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

	eax = 0x4FFFFFFF;
	trig_cpuid(&eax, &ebx, &ecx, &edx);
	printf("The total number of exits: %d\n", eax);
	printf("High 32 bits: 0x%08x \n", ebx);
	printf("Low 32 bits: 0x%08x \n", ecx);
	printf("Total bits: 0x%08x%08x \n", ebx, ecx);
}
