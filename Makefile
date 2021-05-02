build:
	docker build -t opstree/vm:1.0 .

create-network:
	@docker network create opstree || true > /dev/null

run-vm:
	echo "Creating VM $(VM_NAME)"
	@docker rm -f $(VM_NAME) || true > /dev/null
	@docker run -itd -l vm --name $(VM_NAME) --rm --net opstree opstree/vm:1.0
	@docker exec -it $(VM_NAME) bash -c "/etc/init.d/ssh start"

terminate-vm:
	echo "Terminating VM $(VM_NAME)"
	@docker rm -f $(VM_NAME) || true

list-vm:
	echo "Listing VM's"
	@docker ps --filter "label=vm" --format "{{.Names}}"
	
run-controlserver:
	@docker rm -f controlserver || true  > /dev/null
	@docker run -itd --name controlserver --rm --net opstree -v ${PWD}:/src opstree/vm:1.0

create-recreate-deployment-setup:
	make run-controlserver
	make run-vm VM_NAME=load-balancer
	make run-vm VM_NAME=vm1
	make run-vm VM_NAME=vm2
	make run-vm VM_NAME=vm3

cleanup-recreate-deployment-setup:
	make terminate-vm VM_NAME=controlserver
	make terminate-vm VM_NAME=load-balancer
	make terminate-vm VM_NAME=vm1
	make terminate-vm VM_NAME=vm2
	make terminate-vm VM_NAME=vm3

