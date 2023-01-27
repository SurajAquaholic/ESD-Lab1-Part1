################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/ESD_LAB1.asm 

OBJS += \
./src/ESD_LAB1.OBJ 


# Each subdirectory must supply rules for building sources it contributes
src/%.OBJ: ../src/%.asm src/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: Keil 8051 Assembler'
	AX51 "@$(patsubst %.OBJ,%.__ia,$@)" || $(RC)
	@echo 'Finished building: $<'
	@echo ' '


