REGISTRY=orbitalmicro

.PHONY : vivado-2018.3
vivado-2018.3 : Dockerfile
	 docker build --file $< --tag $(REGISTRY)/$@:latest .

