REGISTRY=orbitalmicro

ifeq ($(strip $(tag)),)
TAG=v0.0.1
else
TAG=$(tag)
endif

VIVADO=vivado-2018.3

DOCKER_DEBUG=
#DOCKER_DEBUG=--debug --progress=plain
BUILD_LOG=
#BUILD_LOG=2>&1 | tee build.log

.PHONY : $(VIVADO)
$(VIVADO) : Dockerfile
	 docker build $(DOCKER_DEBUG) --file $< --tag $(REGISTRY)/$@:latest --tag $(REGISTRY)/$@:$(TAG) . $(BUILD_LOG)

# NOTE: final image is ~30GB, so probably just build locally rather than pushing to dockerhub.
#.PHONY : push
#push :
#	docker push $(REGISTRY)/$(VIVADO):$(TAG)
#	docker push $(REGISTRY)/$(VIVADO):latest

.PHONY : all
all : $(VIVADO)
