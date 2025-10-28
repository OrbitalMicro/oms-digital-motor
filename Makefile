.PHONY : clean
clean :
	-rm -rf vivado*.jou vivado*.log

.PHONY : clobber
clobber :
	-rm -rf .cache .config .java .oracle_jre_usage .swt
