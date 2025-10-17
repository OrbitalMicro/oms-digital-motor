REGISTRY=orbitalmicro

ifeq ($(strip $(tag)),)
TAG=v0.0.1
else
TAG=$(tag)
endif

VIVADO=vivado-2018.3

.PHONY : $(VIVADO)
$(VIVADO) : Dockerfile
	 docker build --file $< --tag $(REGISTRY)/$@:latest --tag $(REGISTRY)/$@:$(TAG) .

# NOTE: final image is ~30GB, so probably just build locally rather than pushing to dockerhub.
#.PHONY : push
#push :
#	docker push $(REGISTRY)/$(VIVADO):$(TAG)
#	docker push $(REGISTRY)/$(VIVADO):latest

.PHONY : all
all : $(VIVADO)
